function Set-MoveSession() {

    [CmdletBinding()]
    param (
        [Parameter()]
        [System.Uri]
        $url = [System.Uri]::new('http://localhost'),

        [Parameter()]
        [string]
        $cpf = 11484671902, 

        [Parameter()]
        [string]
        $pass = 12345678
    )

    $ErrorActionPreference = 'break'

    $moveSession = [MoveSession]::Get()
    $new = $false

    Write-Verbose ([MoveSession]::variableName)

    if ($null -eq $moveSession) {
        $new = $true
        $moveSession = [moveSession]::new()
    }

    $moveSession.Mobile.cpf = $cpf
    $moveSession.Mobile.password = $pass

    if ($new) {
        New-Variable -Name ([MoveSession]::variableName) -Value $moveSession -Scope Global
        Write-Verbose "$([MoveSession]) Added!"
    } else {
        Set-Variable -Name ([MoveSession]::variableName) -Value $moveSession -Scope Global
        Write-Verbose "$([MoveSession]::variableName) Updated!"
    }
}
