function Connect-Polaris {
    
    [CmdletBinding()]
    param (
        [Parameter(Mandatory, Position = 0, ValueFromPipeline)]
        [ValidateNotNullOrEmpty()]
        [string]
        $username,

        [Parameter(Mandatory, Position = 1, ValueFromPipeline)]
        [ValidateNotNullOrEmpty()]
        [string]
        $ip,

        [Parameter(Mandatory, Position = 2, ValueFromPipeline)]
        [ValidateNotNullOrEmpty()]
        [ValidateScript({ Test-Key -key $_ })]
        [string]
        $key,

        [switch]
        $putty
    )

    if (-not(Test-Connection -ComputerName $ip -Count 1 -Quiet)) {
        Write-Host 'Host unavailable' -ForegroundColor Red
        return
    }

    Clear-Host;

    if ($putty) {
        Write-Host 'Conectando na maquina via Putty' -ForegroundColor Green
        plink -ssh -i $key "$username@$ip"
    }
    else {
        Write-Host 'Conectando na maquina via SSH' -ForegroundColor Green
        ssh -i $key "$username@$ip"
    }
}

function Test-Key() {
    
    [CmdletBinding()]
    param (
        [Parameter()]
        [string]
        $key
    )

    if (-not (Test-Path $key)) {
        Write-Error 'Key not found'
        return $false
    }

    if (-not ($key -match '\.ppk$')) {
        Write-Error 'Key must be in .ppk format'
        return $false
    }

    return $true
}