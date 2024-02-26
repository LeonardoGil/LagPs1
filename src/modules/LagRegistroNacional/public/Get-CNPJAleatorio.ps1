function Get-CNPJAleatorio() {
    $random = [System.Random]::new();
    $cnpj = [string]::Empty;

    # Gera um cnpj Aleatorio (sem o Digito Verificador) 
    for ($i = 0; $i -lt 8; $i++) {
        $number = $random.Next(0, 9);

        $cnpj = -join ($cnpj, $number);
    }

    $cnpj += "0001"

    $digitoVerificador = Get-DigitoVerificador $cnpj 9;

    $cnpj = -join ($cnpj, $digitoVerificador);

    $digitoVerificador = Get-DigitoVerificador $cnpj 9;

    $cnpj = -join ($cnpj, $digitoVerificador);

    Set-Clipboard -Value $cnpj

    Write-Output "cnpj: $cnpj";
}