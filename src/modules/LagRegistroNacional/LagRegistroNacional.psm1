using namespace System.IO;

$scriptsPath = [Path]::Combine($PSScriptRoot, '*')
$scripts = Get-ChildItem -Path $scriptsPath -Filter '*.ps1' -Recurse | Select-Object -ExpandProperty FullName

# Importa os scripts
$scripts | ForEach-Object { Import-Module -Name $_ }

$functionsToExport = @(
    "Get-CPFAleatorio",
    "Get-CNPJAleatorio"
)

Export-ModuleMember -Function $functionsToExport