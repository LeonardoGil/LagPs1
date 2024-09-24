using namespace System.IO;

$scriptsPath = [Path]::Combine($PSScriptRoot, '*')
$scripts = Get-ChildItem -Path $scriptsPath -Filter '*.ps1' -Recurse | Select-Object -ExpandProperty FullName

$ErrorActionPreference = 'stop'

# Importa os scripts
$scripts | ForEach-Object { Import-Module -Name $_ }

$functionsToExport = @()
$variablesToExport = @()

Export-ModuleMember -Function $functionsToExport -Variable $variablesToExport