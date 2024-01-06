function Get-Token-Portal {
    $body = @{
        grant_type='client_credentials'
        client_id='7afbb7b3a0ab4ede893e2f9490e9ffcf'
        client_secret='ibtwgrHna+thf+p9wkqdo7M250zyynUTwYXA72lPWC4='
    }
    
    $contentType = 'application/x-www-form-urlencoded' 
    
    $request = Invoke-WebRequest -Method POST -Uri 'https://host.docker.internal:5001/connect/token' -body $body -ContentType $contentType
    
    $json = $request.Content | ConvertFrom-Json

    $bearer =  "Bearer $($json.access_token)"; 

    Set-Clipboard -Value $bearer

    Write-Output "Token Gerado: $($bearer)"
}

function Get-Token-Mobile {
    $body = @{
        client_id='3b9a77fb35a54e40815f4fa8641234c5'
        grant_type='password'
        userName='11484671902'
        password='12345678'
    }
    
    $request = Invoke-WebRequest -Method POST -Uri 'http://localhost:9002/token' -body $body
    
    $json = $request.Content | ConvertFrom-Json

    $bearer =  "Bearer $($json.AccessToken)"; 

    Set-Clipboard -Value $bearer

    Write-Output "Token Gerado: $($bearer)"
}

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