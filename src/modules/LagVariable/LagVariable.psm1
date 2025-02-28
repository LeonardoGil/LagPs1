using namespace System.IO;

$scriptsPath = [Path]::Combine($PSScriptRoot, '*')
$scripts = Get-ChildItem -Path $scriptsPath -Filter '*.ps1' -Recurse | Select-Object -ExpandProperty FullName

$lagAutoSave = $false

$ErrorActionPreference = 'stop'

# Importa os scripts
$scripts | ForEach-Object { Import-Module -Name $_ }

$functionsToExport = @(
    # File 
    "Get-LagVariablesFile",
    "Push-LagVariablesFile",
    "Save-LagVariablesFile",

    # Variable
    "Add-LagVariable",
    "New-LagVariable",
    "Set-LagVariable",
    "Remove-LagVariable"
    "Show-LagVariablesTemp"
)

$variablesToExport = @(
    "lagAutoSave"
)

Export-ModuleMember -Function $functionsToExport -Variable $variablesToExport