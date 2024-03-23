function Connect-Polaris {
    param (
        [Parameter(Position = 0, ValueFromPipeline)]
        [string]
        $username,

        [Parameter(Position = 1, ValueFromPipeline)]
        [string]
        $ip,

        [Parameter(Position = 2, ValueFromPipeline)]
        [string]
        $key,

        [switch]
        $putty
    )
    
    if ([string]::IsNullOrEmpty($ip)) { 
        Write-Output 'Necessário informar um Ip!'; 
        return; 
    }

    if (-not (Test-Path $key)) {
        Write-Host 'Key not found' -ForegroundColor Red
        return;
    }

    Clear-Host;

    if ($putty) {
        Write-Host 'Conectando na maquina via Putty' -ForegroundColor Green;
        plink -ssh -i $key "$username@$ip";
    }
    else {
        Write-Host 'Conectando na maquina via SSH' -ForegroundColor Green;
        ssh -i $key "$username@$ip"
    }
}