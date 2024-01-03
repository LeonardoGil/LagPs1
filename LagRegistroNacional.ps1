function Get-CPF-Aleatorio() {
    $random = [System.Random]::new();
    $cpf = [string]::Empty;

    # Gera um CPF Aleatorio (sem o Digito Verificador) 
    for ($i = 0; $i -lt 9; $i++) {
        $number = $random.Next(0, 9);

        $cpf = -join($cpf, $number);
    }

    $digitoVerificador = Get-Digito-Verificador $cpf 11;

    $cpf = -join($cpf, $digitoVerificador);

    $digitoVerificador = Get-Digito-Verificador $cpf 11;

    $cpf = -join($cpf, $digitoVerificador);

    Write-Output "CPF: $cpf";

    Set-Clipboard $cpf
}

function Get-Digito-Verificador() {
    param(
        [Parameter(Mandatory, Position=0)]
        [ValidateNotNullOrEmpty()]
        [string]
        $inputString,

        [Parameter(Position=1)]
        [int]
        $peso
    )

    $arrayString = $inputString.ToCharArray();
    [array]::Reverse($arrayString);

    $reverseString = -join $arrayString;

    $multi = 2;
    $soma = 0;

    for ($i = 0; $i -lt $arrayString.Length; $i++) {
        # Converte o caracter em inteiro
        $number = [int]::Parse($reverseString[$i].ToString());
        # Incrementa a Soma com valor calculado (Numero x Multiplicador)
        $soma = $soma + ($number * $multi);
        # 11 Peso máximo do Mod11 
        if ($multi -ge $peso) {
            # Reseta o Multiplicador para valor inicial
            $multi = 2;
        }
        else {
            # Incrementa o Multiplicador
            $multi = $multi + 1;
        }
    }

    # Mod11
    $resto = $soma % 11;

    if ($resto -le 1) { 
        return 0; 
    }
    else {
        return 11 - $resto;
    }
} 