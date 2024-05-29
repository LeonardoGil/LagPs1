function Out-IniciarViagemMobile() {
    
    [CmdletBinding()]
    param (
        [Parameter(Mandatory, ValueFromPipeline=$true)]
        [guid]
        $viagemId
    )

    $random = [System.Random]::new()
    $date = [system.DateTime]::Now.ToString('yyyy-MM-ddTHH:mm:ss')
    $latitude = ($random.NextDouble() * 100) - 50
    $longitude = ($random.NextDouble() * 100) - 50


    $viagem = [PSCustomObject]@{
        viagemId   = $viagemId
        dataInicio = $date
        latitude   = $latitude.ToString('F6')
        longitude  = $longitude.ToString('F6')
    }

    $iniciarViagens = @{ 
        created = @($viagem)
    }

    $object = [PSCustomObject]@{ 
        changes = @{
            iniciarViagens = $iniciarViagens
        }
    }

    $json = $object | ConvertTo-Json -Depth 15

    Set-Clipboard -Value $json

    return $json
}