<#
    .Synopsis
       Adiciona as Variaveis conforme o arquivo .Lag
    .DESCRIPTION
       Converte o arquivo .Lag em Variaveis Globais para serem utilizadas no contexto atual
    .EXAMPLE
       Push-LagVariablesFile
#>
function Push-LagVariablesFile {

    [CmdletBinding()]
    param ( 
        [Parameter(Position = 0)]
        [string]
        $Path
    )
    
    if ([string]::IsNullOrEmpty($path)) {
        $Path = $Home
    }
    
    $variables = Get-LagVariablesFile -Path $Path
    
    $variables.psobject.properties | ForEach-Object { Add-LagVariable $_.Name $_.Value }
}