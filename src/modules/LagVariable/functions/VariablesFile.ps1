using namespace System.IO;

function Push-LagVariablesFile {
<#
    .Synopsis
       Adiciona as Variaveis conforme o arquivo .Lag
    .DESCRIPTION
       Converte o arquivo .Lag em Variaveis Globais para serem utilizadas no contexto atual
    .EXAMPLE
       Push-LagVariablesFile
#>

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

function Get-LagVariablesFile {
<#
    .Synopsis
       Obtem as Variaveis do arquivo .Lag
    .DESCRIPTION
       Converte o arquivo .Lag em um PSCustomObject
    .EXAMPLE
       Get-LagVariablesFile -Path "C:\temp"
#>

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

function Save-LagVariablesFile {
<#
    .SYNOPSIS
       Gera o arquivo .Lag com base na variables Lag adicionada
    .DESCRIPTION
       Gera um arquivo no estilo JSON com nome .Lag com as Variaveis adicionais
       com o comando Add-LagVariable (Pode consultar a variavel $LagVariablesTemp)
       no diretório informado
#>

    param(
        [Parameter(Position=0, ValueFromPipeline)]
        [string]
        $directory = (Get-Location)
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
