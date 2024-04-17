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

    $variableName = 'Credential'

    $variable = Get-Variable -Name $variableName -ErrorAction SilentlyContinue

    if ($null -eq $variable) {
        New-Variable -Name $variableName -Value $credential -Scope Global
    }
    else {
        Set-Variable -Name $variableName -Value $credential -Scope Global
    }
}