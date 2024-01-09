function Out-Integration-Adicionar-Entrega {
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

    $cnpjEmissorLong = [long]::Parse($cnpjEmissor);

    $chaveAcesso = Out-Chave-Acesso 55 1 24 $cnpjEmissorLong $serieDocumento $numeroDocumento

    $adicionarEntregaModel = @{
        NumeroViagem = $numeroViagem
        CnpjEmissor = $cnpjEmissor
        Entregas = @(
            @{
                NumeroDocumento = $numeroDocumento
                Serie = $serieDocumento

                ChaveAcesso = $chaveAcesso
                NomeDestinatario = 'Leonardo'
                CnpjDestinatario = '30265543000100'

                Logradouro = 'Rua LAG'
                Numero = 123
                Bairro = 'Bairro LAG'
                Municipio = 'Municipio LAG'
                Cep = '88200000'
                Uf = 'SC'
            }
        )
    }

    $outModel = $adicionarEntregaModel | ConvertTo-Json -Depth 4;

    Write-Output $outModel;

    Set-Clipboard $outModel;
}

function Push-Integration-Adicionar-Entrega-Local {
    param(
        # Numero Viagem
        [Parameter(Mandatory, Position=0)]
        [string]
        $numeroViagem,

        # Serie Documento
        [Parameter(Mandatory, Position=2)]
        [int]
        $serieDocumento,

        # Numero Documento
        [Parameter(Mandatory, Position=3)]
        [int]
        $numeroDocumento
    )

    $cnpjEmissor = '30265543000100';

    $body = Out-Integration-Adicionar-Entrega $numeroViagem $cnpjEmissor $serieDocumento $numeroDocumento;

    $header = @{
        Authorization = Get-Token-Portal
        ContentType = 'application/json'
    }

    $url = 'https://localhost:44392/api/Entregas/AdicionarEntregas'

    $request = Invoke-WebRequest -Headers $header -Uri $url -Method Post -Body $body -UseBasicParsing -ContentType "application/json"
    
    $json = $request.Content | ConvertFrom-Json

    Write-Output $json;
}