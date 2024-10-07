function Backup-LagSQL {

    [CmdletBinding()]
    param(
        [Parameter()]
        [string]
        $serverName = 'host.docker.internal',

        [Parameter()]
        [string]
        $databaseName = 'master',

        [Parameter(Mandatory)]
        [string]
        $user,

        [Parameter(Mandatory)]
        [string]
        $pass,

        [Parameter()]
        [string]
        $filePath
    )

    if ([string]::IsNullOrEmpty($filePath)) {
        $filePath = "$databaseName-$(Get-Date -Format 'yyyyMMddHHmmss').bak"
    }

    if (-not $filePath.EndsWith('.bak')) {
        Write-Host 'Arquivo precisa ter a extensão .bak' -ForegroundColor DarkYellow
        return
    }

    if (Test-Path $filePath) {
        Write-Host 'Arquivo já existe' -ForegroundColor DarkYellow
        return
    }

    $backupCommand = "BACKUP DATABASE [$databaseName] TO DISK = N'$filePath' WITH INIT, NAME = N'Backup completo de $databaseName';"

    Invoke-Sqlcmd -ServerInstance $serveName -Query $backupCommand -TrustServerCertificate -Username $user -Password $pass
}