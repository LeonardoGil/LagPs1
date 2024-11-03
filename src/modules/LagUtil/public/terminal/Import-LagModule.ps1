function Import-LagModule {
    param (
        [Parameter()]
        [switch]
        $RegistroNacional,

        [Parameter()]
        [switch]
        $Az,
        
        [Parameter()]
        [switch]
        $Rabbitmq,

        [Parameter()]
        [switch]
        $Sql
    )

    $RegistroNacionalModulePath = "$psProjectPath\LagRegistroNacional\LagRegistroNacional.psm1"
    $AzModulePath               = "$psProjectPath\LagAz\LagAz.psm1"
    $RabbitmqModulePath         = "$psProjectPath\LagRabbitManager\LagRabbitManager.psm1"
    $SqlModulePath              = "$psProjectPath\LagSQL\LagSQL.psm1"

    if ($RegistroNacional) { 
        Import-Module -Name $RegistroNacionalModulePath -Scope Global 
    }

    if ($Az) { 
        Import-Module -Name $AzModulePath -Scope Global
    }

    if ($Rabbitmq) { 
        Import-Module -Name RabbitmqModulePath -Scope Global
    }

    if ($Sql) { 
        Import-Module -Name $SqlModulePath -Scope Global
    }
    
    if ($RegistroNacional -or $Az -or $Rabbitmq -or $Sql) {
        return
    }

    Import-Module -Name $RegistroNacionalModulePath -Scope Global
    Import-Module -Name $AzModulePath -Scope Global
    Import-Module -Name $RabbitmqModulePath -Scope Global
    Import-Module -Name $SqlModulePath -Scope Global
}