function Show-LagVariablesTemp {
    
    [CmdletBinding()]
    param (
        
    )
    
    $ErrorActionPreference = 'Stop'

    $variblesTemp = Get-Variable -Name 'LagVariablesTemp' -ValueOnly

    $variblesTemp | ForEach-Object { Get-Variable -Name $_ } | Sort-Object -Property Name | Out-GridView -Title "Variaveis"
}