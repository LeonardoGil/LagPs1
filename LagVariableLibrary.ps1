<#
    .Synopsis
       Adiciona as Variaveis conforme o arquivo .Lag
    .DESCRIPTION
       Converte o arquivo .Lag em Variaveis Globais para serem utilizadas no contexto atual
    .EXAMPLE
       Push-Lag-Variables-File
#>
function Push-Lag-Variables-File {

    param ( 
        [Parameter(Position=0)]
        [string]
        $Path
    )

    if ([string]::IsNullOrEmpty($path)) {
        $Path = $Home;
    }

    $variables = Get-Lag-Variables-File -Path $Path;

    $variables.psobject.properties | ForEach-Object { Add-Lag-Variable $_.Name $_.Value; }
}

<#
    .Synopsis
       Obtem as Variaveis do arquivo .Lag
    .DESCRIPTION
       Converte o arquivo .Lag em um PSCustomObject
    .EXAMPLE
       Get-Lag-Variables-File -Path "C:\temp"
#>
function Get-Lag-Variables-File {
    param ( 
        [Parameter(Mandatory)]
        [string]
        $Path
    )

    $file = '.lag';
    $filePath = [string]::Concat($path, '/', $file);
    
    if (-not (Test-Path $filePath)) {
        Write-Error 'Arquivo .lag nao Localizado!'
        return;
    }

    try {
        Write-Verbose 'Get File Text and Convert to PSCustomObject'
        return [System.IO.File]::ReadAllText($filePath) | ConvertFrom-Json;
    }
    catch {
        Write-Error 'Ocorreu um erro inesperado!'
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
       Add-Lag-Variable 'Projetos' 'C:\Projetos' }
#>
function Add-Lag-Variable {
    param (
        # Nome da Variavel
        [Parameter(Mandatory, Position=0)]
        [string]
        $Key,

        # Valor da Variavel
        [Parameter(Mandatory, Position=2)]
        [System.Object]
        $Value
    )

    try {
        Write-Verbose "Add Variable: $key"
        New-Variable -Name $Key -Value $Value -Scope Global;
    }
    catch [System.Exception] {
        Write-Error 'Ocorreu um erro inesperado!'
        Write-Error $_.Exception.Message;
    }

    Write-Verbose 'Variables Ok!';
}