# Variables
$projetos = "C:\Projetos"

# class ProjetoCSharp

$taxcalculation = @{
    path    = "$($projetos)\nddFrete_TaxCalculation"
    sln     = "$($projetos)\nddFrete_TaxCalculation\Solutions\NDDigital.Shipper.TaxCalculation.sln"
}

$payment = @{
    path    = "$($projetos)\nddFrete_Payment" 
    sln     = "$($projetos)\nddFrete_Payment\solutions\Payment.sln"
    front   = "$($projetos)\nddFrete_Payment\frontend" 
}

$platform = @{
    path    = "$($projetos)\nddFrete_Platform"
}

$tpl = @{
    path    = "$($platform.path)\projects\tpl"
    sln     = "$($platform.path)\projects\tpl\Solutions\3PL Current Version.sln"
    client  = "$($platform.path)\projects\tpl\Client"
    logs    = "C:\Applications\operadorlogistico\logs"
}

$autentication =  @{
    path    = "$($projetos)\nddFrete_Authentication"
    sln     = "$($projetos)\nddFrete_Authentication\solutions\Authentication.sln"
}

$omp = @{
    path        = "$($projetos)\MyThemesOnOhMyPosh"
    fileTheme   = "$($projetos)\MyThemesOnOhMyPosh\godShell.omp.json"
}

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