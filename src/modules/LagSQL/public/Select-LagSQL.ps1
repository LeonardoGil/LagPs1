function Select-LagSQL {
    
    [CmdletBinding()]
    param (
        [Parameter(Mandatory, Position=0)]
        [string]
        $query    
    )
    
    $serverName = "host.docker.internal"
    $databaseName = "TenantCatalogDb_leonardosaoficial"
    $username = "sa"
    $password = "P@ssw0rd123"

    $securePassword = ConvertTo-SecureString $password -AsPlainText -Force
    $credential = New-Object System.Management.Automation.PSCredential ($username, $securePassword)

    return Invoke-Sqlcmd -ServerInstance $serverName -Database $databaseName -Query $query -Credential $credential -TrustServerCertificate
}