Import-Module -Name ".\NddLibrary.ps1" --verbose;
Import-Module -Name ".\Lag-variable.ps1" --verbose;

# PSReadLine
Set-PSReadlineKeyHandler -Key Tab -Function MenuComplete
Set-PSReadLineKeyHandler -Key UpArrow -Function HistorySearchBackward
Set-PSReadLineKeyHandler -Key DownArrow -Function HistorySearchForward
Set-PSReadlineOption -HistorySearchCursorMovesToEnd
Set-PSReadlineOption -ShowToolTips

# Functions
function set-PS7 { ."$($env:ProgramFiles)\powershell\7\pwsh.exe" }
function ssms { ."$(${env:ProgramFiles(x86)})\Microsoft SQL Server Management Studio 18\Common7\IDE\Ssms.exe" }
function dockerdesktop { ."$($env:ProgramFiles)\Docker\Docker\Docker Desktop.exe" }
function queue { ."$(${env:ProgramFiles(x86)})\Jarbas\QueueViewer\QueueViewer.exe" }
function dmozinho { ."C:\MoveInteractive\LDMO\DMLauncher.exe" }

oh-my-posh init pwsh --config $omp.fileTheme | Invoke-Expression

clear

Write-Output "Terminal ON FIREEE"
Write-Output "Bem vindo a base de controle."