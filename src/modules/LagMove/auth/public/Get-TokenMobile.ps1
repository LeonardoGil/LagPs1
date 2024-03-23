function Get-TokenMobile {

    [CmdletBinding()]
    param (
        [Parameter()]
        [string]
        $cpf = 11484671902, 

        [Parameter()]
        [string]
        $senha = 12345678,

        [Parameter()]
        [string]
        $uri = 'http://localhost:9002'
    )

    $body = @{
        client_id  = '3b9a77fb35a54e40815f4fa8641234c5'
        grant_type = 'password'
        userName   = $cpf
        password   = $senha
    }
    
    $request = Invoke-WebRequest -Method POST -Uri "$uri/token" -body $body
    
    $json = $request.Content | ConvertFrom-Json

    $bearer = "Bearer $($json.AccessToken)"; 

    Set-Clipboard -Value $bearer

    return $bearer;
}
