function Select-LagSQL {
    
    [CmdletBinding()]
    param (
        [Parameter(Mandatory)]
        [string]
        $query,

        [Parameter()]
        [string]
        $server = 'localhost',

        [Parameter()]
        [string]
        $database = 'master',

        [Parameter()]
        [string]
        $user,

        [Parameter()]
        [string]
        $password
    )
    
    $securePassword = ConvertTo-SecureString $password -AsPlainText -Force
    $credential = New-Object System.Management.Automation.PSCredential ($username, $securePassword)

    return Invoke-Sqlcmd -ServerInstance $serverName -Database $databaseName -Query $query -Credential $credential -TrustServerCertificate
}