function Set-MobileSession() {

    [CmdletBinding()]
    param (
        [Parameter()]
        [string]
        $cpf = 11484671902, 

        [Parameter()]
        [string]
        $pass = 12345678,

        [Parameter()]
        [System.Uri]
        $url = [System.Uri]::new('http://localhost')
    )

    $api = [System.UriBuilder]::new($url)
    $api.Port = '9001'

    $auth = [System.UriBuilder]::new($url)
    $auth.Port = '9002'


    $mobileSession = [MobileSession]::Get()
    $new = $false

    Write-Output ([MobileSession]::variableName)

    if ($null -eq $mobileSession) {
        $new = $true
        $mobileSession = [MobileSession]::new()
    }

    $mobileSession.cpf = $cpf
    $mobileSession.password = $pass
    $mobileSession.api = $api.Uri
    $mobileSession.auth = $auth.Uri

    if ($new) {
        New-Variable -Name ([MobileSession]::variableName) -Value $mobileSession -Scope Global
        Write-Verbose "$([MobileSession]) Added!"
    } else {
        Set-Variable -Name ([MobileSession]::variableName) -Value $mobileSession -Scope Global
        Write-Verbose "$([MobileSession]::variableName) Updated!"
    }
}
