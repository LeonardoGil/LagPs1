function Get-Chave-Acesso {
    param (
        # Modelo
        [Parameter(Mandatory, Position = 0)]
        [int]
        $modelo,
        
        # Mes
        [Parameter(Mandatory, Position = 1)]
        [int]
        $mes,
        
        # Ano
        [Parameter(Mandatory, Position = 2)]
        [int]
        $ano,

        # Cnpj
        [Parameter(Mandatory, Position = 3)]
        [long]
        $cnpj,
    
        # Serie
        [Parameter(Mandatory, Position = 4)]
        [int]
        $serie,

        # Numero
        [Parameter(Mandatory, Position = 5)]
        [int]
        $numero
    )

    
    $chaveSemDigito = -join('42', # UF (Codigo 42 = SC)
                            $mes.ToString("D2"), 
                            $ano.ToString("D2"),
                            $cnpj.ToString("D14"),
                            $modelo.ToString("D2"),
                            $serie.ToString("D3"),
                            $numero.ToString("D9"),
                            '1', # Tipo Emissão (Codigo 1 = Normal)
                            '12345678');

    $multi = 2;
    $soma = 0;

    Write-Verbose "Chave sem Digito: $chaveSemDigito"

    for ($i = 42; $i -ge 0; $i--) {
        $number = [int]::Parse($chaveSemDigito[$i]);

        $soma += $number * $multi;

        if ($multi -ge 9) {
            $multi = 2;
        }
        else {
            $multi += 1;
        }
    }

    $resto = $soma % 11;
    $digitoVerificador = 0;

    if ($resto -gt 1) {
        $digitoVerificador = 11 - $resto;
    }

    $chaveAcesso = -join($chaveSemDigito, $digitoVerificador);

    return $chaveAcesso;
}

function Get-CPF-Aleatorio() {
    $random = [System.Random]::new();
    $cpf = [string]::Empty;

    # Gera um CPF Aleatorio (sem o Digito Verificador) 
    for ($i = 0; $i -lt 9; $i++) {
        $number = $random.Next(0, 9);

        $cpf = -join ($cpf, $number);
    }

    $digitoVerificador = Get-Digito-Verificador $cpf 11;

    $cpf = -join ($cpf, $digitoVerificador);

    $digitoVerificador = Get-Digito-Verificador $cpf 11;

    $cpf = -join ($cpf, $digitoVerificador);

    Write-Output "CPF: $cpf";

    Set-Clipboard $cpf
}

function Get-CNPJ-Aleatorio() {
    $random = [System.Random]::new();
    $cnpj = [string]::Empty;

    # Gera um cnpj Aleatorio (sem o Digito Verificador) 
    for ($i = 0; $i -lt 8; $i++) {
        $number = $random.Next(0, 9);

        $cnpj = -join ($cnpj, $number);
    }

    $cnpj += "0001"

    $digitoVerificador = Get-Digito-Verificador $cnpj 9;

    $cnpj = -join ($cnpj, $digitoVerificador);

    $digitoVerificador = Get-Digito-Verificador $cnpj 9;

    $cnpj = -join ($cnpj, $digitoVerificador);

    Write-Output "cnpj: $cnpj";

    Set-Clipboard $cpf
}

function Get-Digito-Verificador() {
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