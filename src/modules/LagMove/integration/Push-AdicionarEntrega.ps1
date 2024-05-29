function Push-AdicionarEntrega {
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
        $numeroDocumento,

        # CNPJ Emissor
        [Parameter(Mandatory, Position=4)]
        [string]
        $cnpjEmissor
    )

    $body = Out-AdicionarEntrega $numeroViagem $cnpjEmissor $serieDocumento $numeroDocumento;

    $header = @{
        Authorization = Get-TokenPortal
        ContentType = 'application/json'
    }

    $url = 'https://localhost:44392/api/Entregas/AdicionarEntregas'

    $request = Invoke-WebRequest -Headers $header -Uri $url -Method Post -Body $body -UseBasicParsing -ContentType "application/json"
    
    $json = $request.Content | ConvertFrom-Json

    Write-Output $json;
}