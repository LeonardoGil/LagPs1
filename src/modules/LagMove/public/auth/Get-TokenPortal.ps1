function Get-TokenPortal {
    
    [CmdletBinding()]
    param (
        [Parameter()]
        [string]
        $clientId,

        [Parameter()]
        [string]
        $clientSecret,

        [Parameter()]
        [string]
        $url = 'https://host.docker.internal:5001/connect/token',

        [Parameter()]
        [switch]
        $default
    )
    
    $body = @{
        grant_type = 'client_credentials'
    }

    if ($default.IsPresent) {
        $body.client_id = 'i-comprova-client-sdk'
        $body.client_secret = 'i-comprova-core-web-api-client-sdk'
    }
    else {

        if ([string]::IsNullOrEmpty($clientId) -or [string]::IsNullOrEmpty($clientSecret)) {
            Write-Error 'Necessario informar ClientId e ClientSecret'
            return
        }

        $body.client_id = $clientId
        $body.client_secret = $clientSecret
    }

    $contentType = 'application/x-www-form-urlencoded' 

    $request = Invoke-WebRequest -Method POST -Uri $url -body $body -ContentType $contentType 
    
    $json = $request.Content | ConvertFrom-Json

    $bearer = "Bearer $($json.access_token)"; 

    Set-Clipboard -Value $bearer

    return $bearer;
}