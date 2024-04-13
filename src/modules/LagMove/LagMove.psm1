using namespace System.IO
using namespace System

$scriptsPath = [Path]::Combine($PSScriptRoot, '*')

Get-ChildItem -Path $scriptsPath -Filter '*.ps1' -Recurse | 
    Select-Object -ExpandProperty FullName | 
        ForEach-Object { Import-Module -Name $_ }

Set-MobileSession
        
$functionsToExport = @(
    # Auth
    "Get-TokenMobile",
    "Get-TokenPortal",

    # Development-Enviroment
    "Connect-Polaris",

    # General
    "Remove-ParticularSoftware",
    "Set-Certificates",

    # Integration
    "Out-AdicionarEntregaJson",
    "Out-IniciarViagemMobile",
    "Out-EntregaMobile"
)

$variablesToExport = @()

Export-ModuleMember -Function $functionsToExport -Variable $variablesToExport