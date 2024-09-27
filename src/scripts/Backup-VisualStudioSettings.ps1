
[CmdletBinding()]
param (
    [Parameter(Mandatory)]
    [string]
    $outputFile
)

$ErrorActionPreference = 'Break'

$vsApp = New-Object -ComObject "VisualStudio.DTE.17.0"
$vsApp.ExecuteCommand("Tools.ImportandExportSettings", "/export:$outputFile")

if (Test-Path $outputFile) {
    Write-Host 'Settings exportado com sucesso' -ForegroundColor DarkGreen
} else {
    Write-Host 'Settings não foi gerado' -ForegroundColor DarkRed
}
