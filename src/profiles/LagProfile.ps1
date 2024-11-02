$psProjectPath = 'C:\Projetos\LagPs1\src'

$lagVerbose = $false

# Local Modules 
Import-Module -Name "$psProjectPath\modules\LagVariable\LagVariable.psm1" -Verbose:$lagVerbose
Import-Module -Name "$psProjectPath\modules\LagRegistroNacional\LagRegistroNacional.psm1" -Verbose:$lagVerbose
# Import-Module -Name "$psProjectPath\modules\LagRabbitManager\LagRabbitManager.psm1" -Verbose:$lagVerbose
# Import-Module -Name "$psProjectPath\modules\LagSQL\LagSQL.psm1" -Verbose:$lagVerbose
# Import-Module -Name "$psProjectPath\modules\LagAz\LagAz.psm1" -Verbose:$lagVerbose

# Third-Party Modules
Import-Module -Name Terminal-Icons

# PSReadLine Keys
Set-PSReadlineKeyHandler -Key Tab -Function MenuComplete
Set-PSReadLineKeyHandler -Key UpArrow -Function HistorySearchBackward
Set-PSReadLineKeyHandler -Key DownArrow -Function HistorySearchForward

# PSReadLine Options
Set-PSReadlineOption -HistorySearchCursorMovesToEnd
Set-PSReadlineOption -ShowToolTips
Set-PSReadlineOption -BellStyle None  # Desabilita campainha
Set-PSReadLineOption -HistorySavePath "C:\Temp\$($Host.Name)_history.txt"

function Initialize-Lag {
    # Load the lag Variables for session
    Push-LagVariablesFile
    
    # Load Theme of Oh-my-Posh
    # oh-my-posh init pwsh --config "C:\Projetos\MyThemesOnOhMyPosh\godShell.omp.json" | Invoke-Expression
    
    Write-Host "Terminal ON FIREEE" -ForegroundColor Red
    Write-Output "Bem vindo a base de controle."
}

Initialize-Lag

# Alias
New-Alias -Name 'ex' -Value explorer

function Start-Modules {
    param (
        [Parameter()]
        [switch]
        $Az,
        
        [Parameter()]
        [switch]
        $Rabbitmq,

        [Parameter()]
        [switch]
        $Sql,

        [Parameter()]
        [switch]
        $Util
    )

    if ($Rabbitmq) { Import-Module -Name "$psProjectPath\modules\LagRabbitManager\LagRabbitManager.psm1" }
    if ($Sql) { Import-Module -Name "$psProjectPath\modules\LagSQL\LagSQL.psm1" }
    if ($Az) { Import-Module -Name "$psProjectPath\modules\LagAz\LagAz.psm1" }
    if ($Util) { Import-Module -Name "$psProjectPath\modules\LagUtil\LagUtil.psd1" }
}