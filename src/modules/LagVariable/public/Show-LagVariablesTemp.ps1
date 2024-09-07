<#
    .Synopsis
       Exibe as variaveis salvas na sessão e retorna a selecionada
    .DESCRIPTION
       Abre uma GridView contendo as variaveis da sessão
#>
function Show-LagVariablesTemp {
    [CmdletBinding()]
    param ()

    $ErrorActionPreference = 'Stop'
    $variblesTemp = Get-Variable -Name 'LagVariablesTemp' -ValueOnly
    $variable = $variblesTemp | ForEach-Object { Get-Variable -Name $_ } | Sort-Object -Property Name | Out-GridView -Title "Variaveis" -OutputMode Single
    return $variable.Value
}