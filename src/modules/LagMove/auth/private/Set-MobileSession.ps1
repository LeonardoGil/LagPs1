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
        $api = [System.Uri]::new('http://localhost:9001'),

        [Parameter()]
        [System.Uri]
        $auth = [System.Uri]::new('http://localhost:9002')
    )

    $mobileSession = [MobileSession]::Get()
    $new = $false

    Write-Output ([MobileSession]::variableName)

    if ($null -eq $mobileSession) {
        $new = $true
        $mobileSession = [MobileSession]::new()
    }

    $mobileSession.cpf = $cpf
    $mobileSession.password = $pass
    $mobileSession.api = [System.Uri]::new($api)
    $mobileSession.auth = [System.Uri]::new($auth)

    if ($new) {
        New-Variable -Name ([MobileSession]::variableName) -Value $mobileSession -Scope Global
        Write-Verbose "$([MobileSession]) Added!"
    } else {
        Set-Variable -Name ([MobileSession]::variableName) -Value $mobileSession -Scope Global
        Write-Verbose "$([MobileSession]::variableName) Updated!"
    }
}
