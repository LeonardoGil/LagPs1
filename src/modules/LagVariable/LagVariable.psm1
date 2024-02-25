using namespace System.IO;

<#
    .Synopsis
       Adiciona as Variaveis conforme o arquivo .Lag
    .DESCRIPTION
       Converte o arquivo .Lag em Variaveis Globais para serem utilizadas no contexto atual
    .EXAMPLE
       Push-LagVariablesFile
#>
function Push-LagVariablesFile {

    param ( 
        [Parameter(Position=0)]
        [string]
        $Path
    )

    if ([string]::IsNullOrEmpty($path)) {
        $Path = $Home;
    }

    $variables = Get-LagVariablesFile -Path $Path;

    $variables.psobject.properties | ForEach-Object { Add-LagVariable $_.Name $_.Value; }
}

<#
    .Synopsis
       Obtem as Variaveis do arquivo .Lag
    .DESCRIPTION
       Converte o arquivo .Lag em um PSCustomObject
    .EXAMPLE
       Get-LagVariablesFile -Path "C:\temp"
#>
function Get-LagVariablesFile {
    param ( 
        [Parameter(Mandatory)]
        [string]
        $Path
    )

    $file = '.lag';
    $filePath = [Path]::Combine($path, $file);
    
    if (-not (Test-Path $filePath)) {
        Write-Error 'File .lag not Found!'
        return;
    }

    try {
        Write-Verbose 'Get File Text and Convert to PSCustomObject'
        New-Variable -Name 'LagFilePath' -Value $filePath -Scope Global;

        return [System.IO.File]::ReadAllText($filePath) | ConvertFrom-Json;
    }
    catch {
        Write-Error 'An unexpected error Occurred';
        Write-Error $_.Exception.Message;
        throw $_;
    }
}

<#
    .Synopsis
       Adiciona a Variavel no contexto Global
    .DESCRIPTION
       Adiciona PSCustomObject como Variavel no Contexto Global
    .EXAMPLE
       Add-LagVariable 'Projetos' 'C:\Projetos' }
#>
function Add-LagVariable {
    param (
        # Nome da Variavel
        [Parameter(Mandatory, Position=0)]
        [string]
        $Key,

        # Valor da Variavel
        [Parameter(Mandatory, Position=1)]
        [System.Object]
        $Value,

        [Parameter()]
        [switch]
        $UpdateFile
    )

    try {
        Write-Verbose "Add Variable: $key";
        New-Variable -Name $Key -Value $Value -Scope Global;
        
        # Grava o nome da Variavel numa lista temporaria
        Push-LagVariablesTemp $Key;

        if ($UpdateFile -and (Test-Path $LagFilePath)) 
        {
            Remove-Item -Path $LagFilePath -Force;

            [Path]::GetDirectoryName($LagFilePath) | Save-LagVariablesFile
        }
    }
    catch [System.Exception] {
        Write-Error 'Ocorreu um erro inesperado!'
        Write-Error $_.Exception.Message;
    }
}

<#
    .Synopsis
       Adiciona o nome da Variavel Lag numa lista temporária
    .DESCRIPTION
       Adiciona o nome da Variavel Lag na lista: LagVariablesTemp
       Será criado uma nova lista caso a Variavel não exista
       Recomendo utilizar com -ErrorAction SilentlyContinue devido a mensagem
       de VariableNOTFOUND
    .EXAMPLE
       Push-LagVariablesTemp 'Teste' -ErrorAction SilentlyContinue;}
#>
function Push-LagVariablesTemp {

    param(
        [Parameter(Mandatory, Position=0)]
        [string]
        $variableName
    )

    try {
        $variablesTemp = Get-Variable -Name 'LagVariablesTemp' -ErrorAction SilentlyContinue;
        $variablesTemp.Value += $variableName;

        Write-Verbose 'Update LagVariablesTemp'
        Set-Variable -Name 'LagVariablesTemp' -Value $variablesTemp.Value -Scope Global;
    }
    catch [System.Exception] {
        Write-Verbose 'Add LagVariablesTemp'
        new-Variable -Name 'LagVariablesTemp' -Value @($variableName) -Scope Global;
    }
}

<#
    .SYNOPSIS
       Gera o arquivo .Lag com base na variables Lag adicionada
    .DESCRIPTION
       Gera um arquivo no estilo JSON com nome .Lag com as Variaveis adicionais
       com o comando Add-LagVariable (Pode consultar a variavel $LagVariablesTemp)
       no diretório informado
#>
function Save-LagVariablesFile {
    param(
        [Parameter(Position=0, ValueFromPipeline)]
        [string]
        $directory
    )

    $ErrorActionPreference = "Stop"

    if ([string]::IsNullOrEmpty($directory)) 
    {
        $directory = Get-Location
    }
    else
    {
        if (-not (Test-Path $directory))
        {
            Write-Error 'Diretório nao encontrado!'
            return;
        }
    }

    if ($null -eq $LagVariablesTemp)
    {
        Write-Output "Não possui variaveis lag para salvar"
        return;
    }

    $path = [Path]::Combine($directory, '.Lag');
    $lag = @{};

    foreach ($var in $LagVariablesTemp)
    {
        $lagVariable = Get-Variable -Name $var
        $lag.Add($lagVariable.Name, $lagVariable.Value)
    }

    $json = $lag | ConvertTo-Json;
    
    New-Item -Path $path -Value $json;
}

function New-LagVariable {
    param(
        [Parameter(Mandatory, Position=0)]
        [string]
        $name
    )

    $key = [string]::Empty
    $value = [string]::Empty
    
    $variable = @{}
    $continue = $true

    if ($LagVariablesTemp -and (($LagVariablesTemp | Where-Object { $_ -like 'teste' }).Count -ne 0)) {
        Write-Output 'Ja possui uma variavel com esse nome'
        return;
    }
    
    do {
        Write-Output 'Informe a Propriedade'
        $key = Read-Host

        if ($key -eq [string]::Empty) {
            Write-Output 'Processo interrompido (Key)'
            $continue = $false
        }
        else {
            Write-Output 'Informe o Valor'
            $value = Read-Host

            if ($value -eq [string]::Empty) {
                Write-Output 'Processo interrompido (Valor)'
                $continue = $false
            }
            else {
                # Adiciona Propriedade e valor
                $variable.Add($key, $value)
            }
        }
    } while ($continue)

    if ($variable.Count -eq 0) {
        Write-Host 'Evento cancelado'
        return
    }

    Add-LagVariable -Key $name -Value $variable
}

$functionsToExport = @(
    # File 
    "Push-LagVariablesFile",
    "Get-LagVariablesFile",
    "Save-LagVariablesFile"

    # Variable
    "Add-LagVariable",
    "New-LagVariable"
)

Export-ModuleMember -Function $functionsToExport