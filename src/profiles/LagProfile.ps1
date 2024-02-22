$psProjectPath = 'C:\Projetos\LagPs1\src'

# Local Modules 
Import-Module -Name "$psProjectPath\functions\LagVariableLibrary.ps1"
Import-Module -Name "$psProjectPath\functions\LagRegistroNacional.ps1"
Import-Module -Name "$psProjectPath\functions\LagPermissions.ps1"

Import-Module -Name "$psProjectPath\works\Libs\LagMoveNddLibrary.ps1"
Import-Module -Name "$psProjectPath\works\Libs\LagThirdPartyLogisticNddLibrary.ps1"
Import-Module -Name "$psProjectPath\works\Libs\LagMoveIntegrationNddLibrary.ps1"
Import-Module -Name "$psProjectPath\works\Libs\LagMoveRabbitMqNddLibrary.ps1"

# Third-Party Modules
Import-Module -Name Terminal-Icons

# PSReadLine
Set-PSReadlineKeyHandler -Key Tab -Function MenuComplete
Set-PSReadLineKeyHandler -Key UpArrow -Function HistorySearchBackward
Set-PSReadLineKeyHandler -Key DownArrow -Function HistorySearchForward
Set-PSReadlineOption -HistorySearchCursorMovesToEnd
Set-PSReadlineOption -ShowToolTips

# Alias
New-Alias -Name 'ex' -Value explorer;

function Initialize-Lag {
    # Push-Lag-Variables-File;
    # oh-my-posh init pwsh --config "C:\Projetos\MyThemesOnOhMyPosh\godShell.omp.json" | Invoke-Expression;
    
    Write-Host "Terminal ON FIREEE" -ForegroundColor Red;
    Write-Output "Bem vindo a base de controle.";
}

Initialize-Lag