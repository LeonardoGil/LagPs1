using namespace System.IO
using namespace System

$scriptsPath = [Path]::Combine($PSScriptRoot, '*')

Get-ChildItem -Path $scriptsPath -Filter '*.ps1' -Recurse | 
    Select-Object -ExpandProperty FullName | 
        ForEach-Object { Import-Module -Name $_ }

if (-not (Get-Module -ListAvailable -Name SqlServer)) {
    Install-Module -Name SqlServer -AllowClobber -Force
}

$functionsToExport = @(
    "Select-LagSQL"
)
$variablesToExport = @()

Export-ModuleMember -Function $functionsToExport -Variable $variablesToExport