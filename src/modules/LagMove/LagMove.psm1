using namespace System.IO
using namespace System

$scriptsPath = [Path]::Combine($PSScriptRoot, '*')

Get-ChildItem -Path $scriptsPath -Filter '*.ps1' -Recurse | 
    Select-Object -ExpandProperty FullName | 
        ForEach-Object { Import-Module -Name $_ }

Set-MoveSession
        
$functionsToExport = @(
    # Auth
    "Set-MoveSession"
    "Get-TokenMobile",
    "Get-TokenPortal",

    # Database
    "Select-LagMoveDatabase",

    # Development-Enviroment
    "Connect-Polaris",

    # General
    "Remove-ParticularSoftware",
    "Set-Certificates",
    "Set-PolarisWindowsApplication",

    # Integration
    "Push-AdicionarEntrega",
    "Out-AdicionarEntrega",
    "Out-IniciarViagemMobile",
    "Out-EntregaMobile",
    "Select-ViagensPendentes"
)

$variablesToExport = @()

Export-ModuleMember -Function $functionsToExport -Variable $variablesToExport