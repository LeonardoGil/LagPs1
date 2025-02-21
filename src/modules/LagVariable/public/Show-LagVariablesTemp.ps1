<#
    .Synopsis
       Exibe as variaveis salvas na sessão e retorna a selecionada
    .DESCRIPTION
       Abre uma GridView contendo as variaveis da sessão
#>
function Show-LagVariablesTemp {
    [CmdletBinding()]
    param (
        [Parameter()]
        [Switch]
        $Select
    )

    $ErrorActionPreference = 'Stop'
    $variblesTemp = Get-Variable -Name 'LagVariablesTemp' -ValueOnly
    $variables = $variblesTemp | ForEach-Object { Get-Variable -Name $_ } | Sort-Object -Property Name

    if ($Select.IsPresent) {
        return $variables | Out-GridView -Title "Variaveis" -OutputMode Single
    }

    return $variables
}