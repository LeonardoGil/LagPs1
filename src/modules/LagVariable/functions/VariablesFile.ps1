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

    [CmdletBinding()]
    param ( 
        [Parameter(Position = 0)]
        [string]
        $Path
    )

    if ([string]::IsNullOrEmpty($path)) {
        $Path = $Home
    }

    $variables = Get-LagVariablesFile -Path $Path

    $variables.psobject.properties | ForEach-Object { Add-LagVariable $_.Name $_.Value }
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

    [CmdletBinding()]
    param ( 
        [Parameter(Mandatory)]
        [string]
        $Path
    )

    $ErrorActionPreference = 'Stop'

    $file = '.lag';
    $filePath = [Path]::Combine($path, $file);
    
    if (-not (Test-Path $filePath)) {
        Write-Host 'File .lag not Found' -ForegroundColor Red
        Write-Host 'Operation Canceled' -ForegroundColor Red
        return;
    }
    
    Write-Verbose 'Get File Text and Convert to PSCustomObject'
    New-Variable -Name 'LagFilePath' -Value $filePath -Scope Global;

    return [System.IO.File]::ReadAllText($filePath) | ConvertFrom-Json;
    
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

    [CmdletBinding()]
    param(
        [Parameter(Position = 0, ValueFromPipeline)]
        [string]
        $directory = (Get-Location)
    )

    $ErrorActionPreference = 'Stop'

    if ([string]::IsNullOrEmpty($directory)) {
        $directory = Get-Location
    }
    elseif (-not (Test-Path $directory)) {
        Write-Host 'Directory not found' -ForegroundColor Red
        return
    }
    
    if ($null -eq $LagVariablesTemp) {
        Write-Host "LagVariablesTemp does not exist" -ForegroundColor Yellow
        return
    }

    $path = Join-Path $directory -ChildPath '.Lag'
    $lag = @{}

    foreach ($var in $LagVariablesTemp) {
        $lagVariable = Get-Variable -Name $var
        $lag.Add($lagVariable.Name, $lagVariable.Value)
    }

    $json = $lag | ConvertTo-Json
    
    New-Item -Path $path -Value $json
    Write-Host 'Saved .Lag file'
}
