<#
.SYNOPSIS
    Cria ou atualiza uma variável no escopo Global usada pelos módulos Lag.

.DESCRIPTION
    Cria ou atualiza uma variável global com o nome e valor informados. Registra
    o nome da variável na lista temporária `LagVariablesTemp` para rastreamento
    entre módulos. Quando solicitado por `-UpdateFile` ou pela configuração
    `LagAutoSave`, tenta persistir alterações no arquivo apontado por
    `LagFilePath`.

.PARAMETER Key
    Nome da variável (string). Obrigatório.

.PARAMETER Value
    Valor a ser atribuído à variável (System.Object). Obrigatório.

.PARAMETER UpdateFile
    Switch que força a atualização do arquivo de persistência após a alteração.

.EXAMPLE
    Add-LagVariable 'Projetos' 'C:\Projetos'

.NOTES
    - Use `-Verbose` para visualizar mensagens operacionais.
    - Erros são reportados via `Write-Error`.
#>
function Add-LagVariable {

    [CmdletBinding()]
    param (
        # Nome da Variavel
        [Parameter(Mandatory, Position = 0)]
        [string]
        $Key,

        # Valor da Variavel
        [Parameter(Mandatory, Position = 1)]
        [System.Object]
        $Value,

        [Parameter()]
        [switch]
        $UpdateFile
    )

    $ErrorActionPreference = 'Stop'
    
    try {
        Write-Verbose ("Adding/updating variable: $key")

        $variable = Get-Variable -Name $Key -Scope Global -ErrorAction SilentlyContinue

        if ($variable) {
            Write-Verbose ("Variable $key already exists. Updating value.")
            Set-Variable -Name $Key -Value $Value -Scope Global
        }
        else {
            Write-Verbose ("Creating new variable $key in Global scope.")
            New-Variable -Name $Key -Value $Value -Scope Global
        }

        Push-LagVariablesTemp $Key

        if ($UpdateFile -or $LagAutoSave) {

            if ($null -eq $LagFilePath) {
                Write-Error "Configuration variable 'LagFilePath' is not defined. Cannot update persistence file."
                return
            }

            if (Test-Path $LagFilePath) {
                Remove-Item -Path $LagFilePath -Force
                Write-Verbose ("Removed persistence file: $LagFilePath")

                Split-Path -Path $LagFilePath -Parent | Save-LagVariablesFile
            }
            else {
                Write-Warning ("Persistence file not found: $LagFilePath")
            }
        }
    }
    catch {
        Write-Error ("(Add-LagVariable) Unexpected error while adding variable '$Key': $($_.Exception.Message)")
        throw
    }
}