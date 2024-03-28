function Out-AdicionarEntregaJson {
    
    [CmdletBinding()]
    param (
        # Numero Viagem
        [Parameter(Mandatory, Position=0)]
        [string]
        $numeroViagem,

        # CNPJ Emissor
        [Parameter(Mandatory, Position=1)]
        [string]
        $cnpjEmissor,

        # Serie Documento
        [Parameter(Mandatory, Position=2)]
        [int]
        $serieDocumento,

        # Numero Documento
        [Parameter(Mandatory, Position=3)]
        [int]
        $numeroDocumento
    )

    $chaveAcesso = Get-ChaveAcesso 55 1 24 $cnpjEmissor $serieDocumento $numeroDocumento

    $adicionarEntregaModel = @{
        NumeroViagem = $numeroViagem
        CnpjEmissor = $cnpjEmissor
        Entregas = @(
            @{
                NumeroDocumento = $numeroDocumento
                Serie = $serieDocumento

                ChaveAcesso = $chaveAcesso
                NomeDestinatario = 'Leonardo'
                CnpjDestinatario = Get-CNPJAleatorio

                Logradouro = 'Rua LAG'
                Numero = 123
                Bairro = 'Bairro LAG'
                Municipio = 'Municipio LAG'
                Cep = '88200000'
                Uf = 'SC'
            }
        )
    }

    $outModel = $adicionarEntregaModel | ConvertTo-Json;

    Write-Output $outModel;
    Set-Clipboard $outModel;
}