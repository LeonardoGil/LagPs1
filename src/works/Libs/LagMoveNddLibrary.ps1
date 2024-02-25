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
        client_id     = 'i-comprova-client-sdk'
        client_secret = 'i-comprova-core-web-api-client-sdk'
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
    
    param (
        [string]
        $certificatesPath = (Get-Location),

        [Parameter(Mandatory)]
        [string]
        $projectPath
    )

    $certificates = @("identity-cert.pfx", "identity-root-cert.cer", "identity-root-cert.crt");
    $identityProjectPath = "$projectPath/configs/identity";

    if (-not(Test-Path $certificatesPath)) {
        Write-Output 'Caminho do Certificado inválido';
        return;
    }

    if (-not(Test-Path $projectPath)) {
        Write-Output 'Caminho do Projeto inválido';
        return;
    }

    try {
        # Verifica se possui todos os 3 certificados necessario na pasta
        if ((Get-ChildItem -Path "$certificatesPath/*" -Include $certificates).Length -le 2) {
            
            Write-Output 'Não foi encontrado todos os certificados necessários';
            return;
        }

        # Limpa os certificados do Projeto
        Remove-Item -Path "$identityProjectPath/*" -Include $certificates -Force;

        # Clona os certificados para Projeto
        Copy-Item -Path "$certificatesPath/*" -Include $certificates -Destination $identityProjectPath;

        Write-Output 'Certificados atualizados!';
    }
    catch {
        Write-Output "Ocorreu um erro. $($_.message)"
    }
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
        $key
    )
    
    if ([string]::IsNullOrEmpty($ip)) { 
        Write-Output 'Necessário informar um Ip!'; 
        return; 
    }

    if (-not (Test-Path $key)) {
        Write-Output 'Chave .ppk não encontrada!';
        return;
    }

    Clear-Host;

    Write-Host 'Conectando na maquina' -ForegroundColor Green;
    plink -ssh -i $key "$username@$ip";
}