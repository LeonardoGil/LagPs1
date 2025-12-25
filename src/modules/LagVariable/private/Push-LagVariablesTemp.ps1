<#
.SYNOPSIS
    Registra um nome de variável na lista temporária global utilizada pelos módulos Lag.

.DESCRIPTION
    Garante que a variável global `LagVariablesTemp` exista (array) e insere o
    `variableName` informado apenas se ainda não constar na lista. Esta função
    é idempotente: não adiciona duplicatas. Use o recurso de `-Verbose` para
    mensagens operacionais.

.PARAMETER variableName
    Nome (string) da variável a ser adicionada à lista temporária. Obrigatório.

.EXAMPLE
    Push-LagVariablesTemp 'Teste'
    # Adiciona o nome 'Teste' à lista global LagVariablesTemp.

.NOTES
    - A variável `LagVariablesTemp` é criada com escopo Global.
    - Destinada a facilitar rastreamento temporário de nomes de variáveis
      entre funções e módulos Lag.
#>
function Push-LagVariablesTemp {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory, Position = 0)]
        [string]
        $variableName
    )

    $variablesTemp = Get-Variable -Name 'LagVariablesTemp' -ErrorAction SilentlyContinue

    if (-not $variablesTemp) {
        New-Variable -Name 'LagVariablesTemp' -Value @($variableName) -Scope Global
        Write-Verbose "Created LagVariablesTemp and added $variableName"
    }
    elseif ($variablesTemp.Value -contains $variableName) {
        Write-Verbose "Variable $variableName already in LagVariablesTemp. Skipping."
        return
    }
    else {  
        # Adiciona o nome da variavel a lista: $LagVariablesTemp
        $variablesTemp.Value += $variableName
        Set-Variable -Name 'LagVariablesTemp' -Value $variablesTemp.Value -Scope Global
        Write-Verbose "Updated LagVariablesTemp with $variableName"
    }
}