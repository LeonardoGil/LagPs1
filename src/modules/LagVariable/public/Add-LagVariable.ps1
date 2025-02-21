<#
    .Synopsis
       Adiciona a Variavel no contexto Global
    .DESCRIPTION
       Adiciona PSCustomObject como Variavel no Contexto Global
    .EXAMPLE
       Add-LagVariable 'Projetos' 'C:\Projetos' 
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
        Write-Verbose "Adding variable: $key"
        New-Variable -Name $Key -Value $Value -Scope Global
        
        # Grava o nome da Variavel numa lista temporaria
        Push-LagVariablesTemp $Key

        if ($UpdateFile -or $LagAutoSave) {

            if ($null -eq $LagFilePath) {
                Write-Host '$LagFilePath is not defined.' -ForegroundColor Red
                return;
            }

            if (Test-Path $LagFilePath) {
                Remove-Item -Path $LagFilePath -Force
                Write-Host 'Removed .Lag file'
    
                [Path]::GetDirectoryName($LagFilePath) | Save-LagVariablesFile
            }
            else {
                Write-Host 'File .lag does not exist.' -ForegroundColor Red
                return
            }
        }
    }
    catch [System.Exception] {
        Write-Host 'An unexpected error occurred.' -ForegroundColor Red
        throw $_
    }
}