Import-Module -Name "C:\PowerShell\NddLibrary.ps1";
Import-Module -Name "C:\PowerShell\Lag_variable.ps1";

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

oh-my-posh init pwsh --config $omp.fileTheme | Invoke-Expression

Write-Output "Terminal ON FIREEE"
Write-Output "Bem vindo a base de controle."