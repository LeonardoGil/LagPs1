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

    $mobileSession = [MobileSession]::Get()

    if ([string]::IsNullOrEmpty($cpf)) { $cpf = $mobileSession.cpf }
    if ([string]::IsNullOrEmpty($pass)) { $pass = $mobileSession.password }
    if ($null -eq $apiUrl) { $apiUrl = $mobileSession.auth }

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
