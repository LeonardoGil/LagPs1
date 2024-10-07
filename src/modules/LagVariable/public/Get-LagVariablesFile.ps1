<#
    .Synopsis
       Obtem as Variaveis do arquivo .Lag
    .DESCRIPTION
       Converte o arquivo .Lag em um PSCustomObject
    .EXAMPLE
       Get-LagVariablesFile -Path "C:\temp"
#>
function Get-LagVariablesFile {
    
    [CmdletBinding()]
    param ( 
        [Parameter(Mandatory)]
        [string]
        $Path
    )
    
    $ErrorActionPreference = 'Stop'
    
    $filePath = Join-Path $path '.lag'

    if (-not (Test-Path $filePath)) {
        Write-Host 'File .lag not Found' -ForegroundColor Red
        Write-Host 'Operation Canceled' -ForegroundColor Red
        return;
    }
        
    Write-Verbose 'Get File Text and Convert to PSCustomObject'
    New-Variable -Name 'LagFilePath' -Value $filePath -Scope Global;
    
    return [System.IO.File]::ReadAllText($filePath) | ConvertFrom-Json;
}