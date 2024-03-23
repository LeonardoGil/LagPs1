function Set-RabbitCredential {
    [CmdletBinding()]
    param (
        [Parameter(Mandatory, Position=0)]
        [string]
        $url,

        [Parameter(Mandatory, Position=1)]
        [string]
        $user,

        [Parameter(Mandatory, Position=2)]
        [string]
        $pass
    )

    $credential = [Credential]::new()

    $credential.url = $url
    $credential.username = $user
    $credential.password = $pass

    New-Variable -Name 'Credential' -Value $credential -Scope Global
}