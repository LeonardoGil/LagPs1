function Get-TokenPortal {
    $body = @{
        grant_type    = 'client_credentials'
        client_id     = 'i-comprova-client-sdk'
        client_secret = 'i-comprova-core-web-api-client-sdk'
    }
    
    $contentType = 'application/x-www-form-urlencoded' 
    
    $request = Invoke-WebRequest -Method POST -Uri 'https://host.docker.internal:5001/connect/token' -body $body -ContentType $contentType
    
    $json = $request.Content | ConvertFrom-Json

    $bearer = "Bearer $($json.access_token)"; 

    Set-Clipboard -Value $bearer

    return $bearer;
}