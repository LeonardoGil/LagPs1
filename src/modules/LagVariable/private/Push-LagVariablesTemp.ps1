<#
    .Synopsis
       Adiciona o nome da Variavel Lag numa lista temporária
    .DESCRIPTION
       Adiciona o nome da Variavel Lag na lista: LagVariablesTemp
       Será criado uma nova lista caso a Variavel não exista
    .EXAMPLE
       Push-LagVariablesTemp 'Teste'
#>
function Push-LagVariablesTemp {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory, Position = 0)]
        [string]
        $variableName
    )
    
    try {
        # Busca $LagVariablesTemp
        $variablesTemp = Get-Variable -Name 'LagVariablesTemp' -ErrorAction SilentlyContinue
            
        # Adiciona o nome da variavel a lista: $LagVariablesTemp
        $variablesTemp.Value += $variableName
     
        # Atualiza $LagVariablesTemp
        Set-Variable -Name 'LagVariablesTemp' -Value $variablesTemp.Value -Scope Global
            
        Write-Verbose "Updated LagVariablesTemp with $variableName"
    }
    catch [System.Exception] {
        New-Variable -Name 'LagVariablesTemp' -Value @($variableName) -Scope Global
    
        Write-Verbose 'Generated LagVariablesTemp'
    }
}