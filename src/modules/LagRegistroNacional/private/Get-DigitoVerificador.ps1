function Get-DigitoVerificador() {
    param(
        [Parameter(Mandatory, Position = 0)]
        [ValidateNotNullOrEmpty()]
        [string]
        $inputString,

        [Parameter(Position = 1)]
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