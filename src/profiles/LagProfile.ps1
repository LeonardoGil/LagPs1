$lagVerbose     = $false
$psProjectPath  = 'C:\Projetos\LagPs1\src\modules'

Import-Module -Name "$psProjectPath\LagVariable\LagVariable.psm1"   -Verbose:$lagVerbose
Import-Module -Name "$psProjectPath\LagUtil\LagUtil.psd1"           -Verbose:$lagVerbose

# Third-Party Modules
Import-Module -Name Terminal-Icons

# PSReadLine
Set-PSReadlineKeyHandler -Key Tab -Function MenuComplete
Set-PSReadLineKeyHandler -Key UpArrow -Function HistorySearchBackward
Set-PSReadLineKeyHandler -Key DownArrow -Function HistorySearchForward
Set-PSReadlineOption -HistorySearchCursorMovesToEnd
Set-PSReadlineOption -ShowToolTips
Set-PSReadlineOption -BellStyle None
Set-PSReadLineOption -HistorySavePath "C:\Temp\$($Host.Name)_history.txt"

function Initialize-Lag {
    Push-LagVariablesFile
    
    # Load Theme of Oh-my-Posh
    # oh-my-posh init pwsh --config "C:\Projetos\MyThemesOnOhMyPosh\godShell.omp.json" | Invoke-Expression
    
    Write-Host "Terminal ON FIREEE" -ForegroundColor Red
    Write-Output "Bem vindo a base de controle."
}

Initialize-Lag

# Alias
New-Alias -Name 'ex' -Value explorer