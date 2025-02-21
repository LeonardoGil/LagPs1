<#
    .Synopsis
       Remove a Variavel no contexto Global
    .DESCRIPTION
       Remove PSCustomObject como Variavel no Contexto Global
    .EXAMPLE
       Remove-LagVariable 'Projetos' 
#>
function Remove-LagVariable {

    [CmdletBinding()]
    param (
        [Parameter(Mandatory, Position = 0)]
        [string]
        $Key,

        [Parameter()]
        [switch]
        $UpdateFile
    )

    $ErrorActionPreference = 'Stop'
    
    try {
        Write-Verbose "Removing variable: $key"
        Remove-Variable -Name $Key -Scope Global
        
        # Remove o nome da Variavel da lista temporaria
        Pop-LagVariablesTemp $Key

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