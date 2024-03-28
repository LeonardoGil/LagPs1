function Get-ChaveAcesso {
    
    [CmdletBinding()]
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
        [string]
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
                            $cnpj,
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