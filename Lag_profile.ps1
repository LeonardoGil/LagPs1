Import-Module -Name "C:\Projetos\LagPS\LagNddLibrary.ps1";
Import-Module -Name "C:\Projetos\LagPS\LagVariableLibrary.ps1";
Import-Module -Name "C:\Projetos\LagPS\LagRegistroNacional.ps1";

Push-Lag-Variables-File

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
function binzinho { ."$(${env:ProgramFiles(x86)})\Bodega\BinKiller\BinKiller.exe" }

oh-my-posh init pwsh --config "C:\Projetos\MyThemesOnOhMyPosh\godShell.omp.json" | Invoke-Expression

Write-Output "Terminal ON FIREEE"
Write-Output "Bem vindo a base de controle."