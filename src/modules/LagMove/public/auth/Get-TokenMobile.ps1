function Get-TokenMobile {

    [CmdletBinding()]
    param (
        [Parameter()]
        [string]
        $cpf, 

        [Parameter()]
        [string]
        $pass,

        [Parameter()]
        [System.Uri]
        $apiUrl,

        [Parameter()]
        [string]
        $clientId
    )

    $moveSession = [MoveSession]::Get()

    # validation

    if ($null -eq $moveSession) {
        Write-Host 'Sessão não definida' -ForegroundColor DarkYellow
        return
    }

    if ([string]::IsNullOrEmpty($cpf)) {
        $cpf = $moveSession.Mobile.cpf 
    }

    if ([string]::IsNullOrEmpty($pass)) {
        $pass = $moveSession.Mobile.password 
    }

    if ([string]::IsNullOrEmpty($clientId)) {
        $clientId = $moveSession.Mobile.clientId 
    }
    
    if ($null -eq $apiUrl) { 
        $urlBuilder = [System.UriBuilder]::new($moveSession.Url)
        $urlBuilder.Port = [MobileSession]::portAuthDefault
        $apiUrl = $urlBuilder.Uri
    }

    # Request

    $body = @{
        client_id  = $clientId
        grant_type = 'password'
        userName   = $cpf
        password   = $pass
    }
    
    $url = [System.Uri]::new($apiUrl, 'token');

    $request = Invoke-WebRequest -Method POST -Uri $url -body $body
    
    $json = $request.Content | ConvertFrom-Json

    # Result

    $bearer = "Bearer $($json.AccessToken)"; 

    Set-Clipboard -Value $bearer

    return $bearer
}
