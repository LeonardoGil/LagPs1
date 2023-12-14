$Projetos = 'C:\Projetos'

$Cargo = @{
    path = "$projetos\nddCargo"
    sln = "$projetos\nddCargo\microsservices\MicrosservicesNDDCargo\MicrosservicesNDDCargo.sln"
}

$Tcg = @{
    path    = "$projetos\LagTcg\"
    sln     = "$projetos\LagTcg\LagTcg.sln"
}

$Tax = 
$TaxCalculation = @{
    path    = "$projetos\nddFrete_TaxCalculation"
    sln     = "$projetos\nddFrete_TaxCalculation\Solutions\NDDigital.Shipper.TaxCalculation.sln"
}

$pay = 
$Payment = @{
    path    = "$projetos\nddFrete_Payment" 
    sln     = "$projetos\nddFrete_Payment\solutions\Payment.sln"
    front   = "$projetos\nddFrete_Payment\frontend" 
}

$Platform = 
$Plat =  @{
    path    = "$projetos\nddFrete_Platform"
    config  = "$projetos\nddFrete_Platform\configs\"
    projects= "$projetos\nddFrete_Platform\projects\"
}

$TPL = @{
    path    = "$($platform.path)\projects\tpl"
    sln     = "$($platform.path)\projects\tpl\Solutions\3PL Current Version.sln"
    client  = "$($platform.path)\projects\tpl\Client"
    logs    = "C:\Applications\operadorlogistico\logs"
}

$ClientTpl = @{
    path    = "$($platform.path)\projects\client-tpl"
    client  = "$($platform.path)\projects\client-tpl\Client"
}

$Autentication =  @{
    path    = "$projetos\nddFrete_Authentication"
    sln     = "$projetos\nddFrete_Authentication\solutions\Authentication.sln"
}

$Omp = @{
    path        = "$projetos\MyThemesOnOhMyPosh"
    fileTheme   = "$projetos\MyThemesOnOhMyPosh\godShell.omp.json"
}

$lagPS = @{
    path = 'C:\PowerShell'
}

$ndd = @{
    path = 'C:\Ndd'
    server = 'C:\Ndd\Servidores.md'
    update = 'C:\Ndd\UpdateInator'
}

$polaris = @{
    path    = "$projetos\Polaris" 
    client  = "$projetos\Polaris\projects\core\client"
    sln     = "$projetos\Polaris\projects\core\server\NDDPolarisSolutionServer.sln"
}

$lagControl = @{
    path    = "$projetos\lagControl\"
    sln     = "$projetos\lagControl\lagControl.sln"
}