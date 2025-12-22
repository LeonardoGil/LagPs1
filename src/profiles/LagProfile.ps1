if ($IsWindows) {
    New-Variable -Name 'Projetos' -Value 'C:\Projetos' -Scope Global
    New-Variable -Name 'Shell' -Value 'C:\Shell' -Scope Global
    New-Variable -Name 'Temp' -Value 'C:\Temp' -Scope Global

    # Não funciona em ambientes Linux
    Import-Module -Name Terminal-Icons
}

# PSReadLine
Set-PSReadlineKeyHandler -Key Tab -Function MenuComplete
Set-PSReadLineKeyHandler -Key UpArrow -Function HistorySearchBackward
Set-PSReadLineKeyHandler -Key DownArrow -Function HistorySearchForward
Set-PSReadlineOption -HistorySearchCursorMovesToEnd
Set-PSReadlineOption -ShowToolTips
Set-PSReadlineOption -BellStyle None
Set-PSReadLineOption -HistorySavePath "$Temp\$($Host.Name)_history.txt"

function Import-LagModules {
    $psProjectPath  = "$Projetos\LagPs1\src\modules"
    
    Import-Module -Name "$psProjectPath\LagVariable\LagVariable.psm1"   
    Import-Module -Name "$psProjectPath\LagUtil\LagUtil.psd1"           

    Push-LagVariablesFile
}

# Alias
New-Alias -Name 'ex' -Value explorer
New-Alias -Name 'ilag' -Value Import-LagModules
New-Alias -Name 'imod' -Value Import-Module