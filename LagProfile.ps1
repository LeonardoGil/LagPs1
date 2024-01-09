
# Imports 
Import-Module -Name "C:\Projetos\LagPS\LagVariableLibrary.ps1";
Import-Module -Name "C:\Projetos\LagPS\LagRegistroNacional.ps1";
Import-Module -Name "C:\\Projetos\\LagPS\\Ndd\\LagMoveNddLibrary.ps1";
Import-Module -Name "C:\\Projetos\\LagPS\\Ndd\\LagThirdPartyLogisticNddLibrary.ps1";
Import-Module -Name "C:\\Projetos\\LagPS\\Ndd\\LagMoveIntegrationNddLibrary.ps1";


# PSReadLine
Set-PSReadlineKeyHandler -Key Tab -Function MenuComplete
Set-PSReadLineKeyHandler -Key UpArrow -Function HistorySearchBackward
Set-PSReadLineKeyHandler -Key DownArrow -Function HistorySearchForward
Set-PSReadlineOption -HistorySearchCursorMovesToEnd
Set-PSReadlineOption -ShowToolTips

# Alias
New-Alias -Name 'ex' explorer;

function Initialize-Lag {
    Push-Lag-Variables-File;
    
    oh-my-posh init pwsh --config "C:\Projetos\MyThemesOnOhMyPosh\godShell.omp.json" | Invoke-Expression;
    
    Write-Host "Terminal ON FIREEE" -ForegroundColor Red;
    Write-Output "Bem vindo a base de controle.";
}

function Start-Lag-App {
    param ( 
        [switch]
        $PowerShellSeven,

        [switch]
        $SSMS,

        [switch]
        $DockerDesktop,

        [switch]
        $Queue,

        [switch]
        $Binzinho
    )

    if ($PowerShellSeven) { Start-Process "$($env:ProgramFiles)\powershell\7\pwsh.exe"; }

    if ($SSMS) { Start-Process "$(${env:ProgramFiles(x86)})\Microsoft SQL Server Management Studio 18\Common7\IDE\Ssms.exe"; }

    if ($DockerDesktop) { Start-Process "$($env:ProgramFiles)\Docker\Docker\Docker Desktop.exe"; }

    if ($Queue) { Start-Process "$(${env:ProgramFiles(x86)})\Jarbas\QueueViewer\QueueViewer.exe"; }

    if ($Binzinho) { Start-Process "$(${env:ProgramFiles(x86)})\Bodega\BinKiller\BinKiller.exe"; }
}

Initialize-Lag