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