<#
    .Synopsis
       Remove o nome da Variavel Lag numa lista temporária
    .DESCRIPTION
       Remove o nome da Variavel Lag na lista: LagVariablesTemp
    .EXAMPLE
       Pop-LagVariablesTemp 'Teste'
#>
function Pop-LagVariablesTemp {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory, Position = 0)]
        [string]
        $variableName
    )
    
    # Busca $LagVariablesTemp
    $variablesTemp = Get-Variable -Name 'LagVariablesTemp' -ErrorAction SilentlyContinue
        
    if ($null -eq $variablesTemp) {
        Write-Host 'Variable not found!' -ForegroundColor DarkYellow
        return
    }

    # Adiciona o nome da variavel a lista: $LagVariablesTemp
    $variablesTemp.Value = $variablesTemp.Value | Where-Object { $_ -ne $variableName }
    
    # Atualiza $LagVariablesTemp
    Set-Variable -Name 'LagVariablesTemp' -Value $variablesTemp.Value -Scope Global
    Write-Verbose "Updated LagVariablesTemp without $variableName"
}