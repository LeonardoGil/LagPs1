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
        $apiUrl
    )

    $moveSession = [MoveSession]::Get()

    if ([string]::IsNullOrEmpty($cpf)) { $cpf = $moveSession.Mobile.cpf }
    if ([string]::IsNullOrEmpty($pass)) { $pass = $moveSession.Mobile.password }

    if ($null -eq $apiUrl) { 
        $urlBuilder = [System.UriBuilder]::new($mobileSession.Url)
        $urlBuilder.Port = [MobileSession]::portAuthDefault
        $apiUrl = $urlBuilder.Uri
    }

    $body = @{
        client_id  = $mobileSession.clientId
        grant_type = 'password'
        userName   = $cpf
        password   = $pass
    }
    
    $ErrorActionPreference = 'Stop'

    $url = [System.Uri]::new($apiUrl, 'token');

    $request = Invoke-WebRequest -Method POST -Uri $url -body $body
    
    $json = $request.Content | ConvertFrom-Json

    $bearer = "Bearer $($json.AccessToken)"; 

    Set-Clipboard -Value $bearer

    return $bearer
}
