using namespace System.IO;

function Remove-ParticularSoftware {

    $particularSoftwarePath = [Path]::Combine($env:LOCALAPPDATA, 'ParticularSoftware');
    Write-Output $particularSoftwarePath

    if (Test-Path -Path $particularSoftwarePath) {
        Write-Output "Excluindo pasta";
        Remove-Item -Path $particularSoftwarePath -Force;
    }
    else {
        Write-Output 'ParticularSoftware não encontrado!';
        return;
    }
}

function Get-Token-Portal {
    $body = @{
        grant_type    = 'client_credentials'
        client_id     = '7afbb7b3a0ab4ede893e2f9490e9ffcf'
        client_secret = 'ibtwgrHna+thf+p9wkqdo7M250zyynUTwYXA72lPWC4='
    }
    
    $contentType = 'application/x-www-form-urlencoded' 
    
    $request = Invoke-WebRequest -Method POST -Uri 'https://host.docker.internal:5001/connect/token' -body $body -ContentType $contentType
    
    $json = $request.Content | ConvertFrom-Json

    $bearer = "Bearer $($json.access_token)"; 

    Set-Clipboard -Value $bearer

    return $bearer;
}

function Get-Token-Mobile {
    $body = @{
        client_id  = '3b9a77fb35a54e40815f4fa8641234c5'
        grant_type = 'password'
        userName   = '11484671902'
        password   = '12345678'
    }
    
    $request = Invoke-WebRequest -Method POST -Uri 'http://localhost:9002/token' -body $body
    
    $json = $request.Content | ConvertFrom-Json

    $bearer = "Bearer $($json.AccessToken)"; 

    Set-Clipboard -Value $bearer

    return $bearer;
}

function Set-Certificates {
    
    $certificates = @("identity-cert.pfx", "identity-root-cert.cer", "identity-root-cert.crt");
    
    $certBackupPath = "$($Ndd.Move)/Certificados Identity/*";    
    $certBackup = Get-ChildItem -Path $certBackupPath -Include $certificates;
    
    if ($certBackup.Length -le 2) {
        Write-Output 'Não foi encontrado todos os certificados necessários';
        return;
    }

    $certActualPath = "$($Polaris.Path)/configs/identity/*";
    
    # Removido temporariamente
    # Validação devo ocorrer apenas quando os certificados forem Untracked

    <#    
        $certActual = Get-ChildItem -Path $certActualPath -Include $certificates;

        if ($certActual.Length -ge 1)
        {
            $maxBackupDate = $certBackup | Measure-Object -Property LastAccessTime -Maximum;
            $maxActualDate = $certActual | Measure-Object -Property LastAccessTime -Maximum;
        
            if ($maxActualDate.Maximum -gt $maxBackupDate.Maximum)
            {
                Write-Output 'Certificados do Backup estão desatualizados!';
                return;
            }
        }
    #>

    Remove-Item -Path $certActualPath -Include $certificates -Force;
    
    Copy-Item -Path $certBackupPath -Include $certificates -Destination "$($Polaris.Path)/configs/identity";

    Write-Output 'Certificados atualizados!';
}

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
        $lone1, 

        [switch]
        $lone2, 

        [switch]
        $lone3
    )
    
    if ($lone1) {
        $username = 'lonestar';
        $ip = '20.55.122.52';
        $key = 'C:/Ndd/Move/SSH Ambientes/Lonestar1.ppk'
    }
    elseif ($lone2) {
        $username = 'lonestar';
        $ip = '172.203.236.130';
        $key = 'C:/Ndd/Move/SSH Ambientes/Lonestar2.ppk'
    }
    elseif ($lone3) {
        $username = 'polaris';
        $ip = '172.210.57.148';
        $key = 'C:/Ndd/Move/SSH Ambientes/Lonestar3.ppk'
    }

    if ([string]::IsNullOrEmpty($ip)) { Write-Output 'Necessário informar um Ip!'; return; }

    if (-not (Test-Path $key)) {
        Write-Output 'Chave .ppk não encontrada!';
        return;
    }

    Clear-Host;

    Write-Host 'Conectando na maquina' -ForegroundColor Green;
    plink -ssh -i $key "$username@$ip";
}