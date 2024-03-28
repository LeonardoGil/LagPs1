function Get-CPFAleatorio() {
    $random = [System.Random]::new()
    $cpf = [string]::Empty

    # Gera um CPF Aleatorio (sem o Digito Verificador) 
    for ($i = 0; $i -lt 9; $i++) {
        $number = $random.Next(0, 9)
        $cpf = -join ($cpf, $number)
    }

    $digitoVerificador = Get-DigitoVerificador $cpf 11
    $cpf = -join ($cpf, $digitoVerificador)

    $digitoVerificador = Get-DigitoVerificador $cpf 11
    $cpf = -join ($cpf, $digitoVerificador)

    Set-Clipboard -Value $cpf
    Write-Verbose "CPF: $cpf"

    return $cpf
}