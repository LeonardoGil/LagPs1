<#
    .SYNOPSIS
       Gera o arquivo .Lag com base na variables Lag adicionada
    .DESCRIPTION
       Gera um arquivo no estilo JSON com nome .Lag com as Variaveis adicionais
       com o comando Add-LagVariable (Pode consultar a variavel $LagVariablesTemp)
       no diretório informado
#>
function Save-LagVariablesFile {
    
    [CmdletBinding()]
    param(
        [Parameter(Position = 0, ValueFromPipeline)]
        [string]
        $directory = (Get-Location)
    )
    
    $ErrorActionPreference = 'Stop'
    
    if ([string]::IsNullOrEmpty($directory)) {
        $directory = Get-Location
    }
    elseif (-not (Test-Path $directory)) {
        Write-Host 'Directory not found' -ForegroundColor Red
        return
    }
        
    if ($null -eq $LagVariablesTemp) {
        Write-Host "LagVariablesTemp does not exist" -ForegroundColor Yellow
        return
    }
    
    $path = Join-Path $directory -ChildPath '.Lag'
    $lag = @{}
    
    foreach ($var in $LagVariablesTemp) {
        $lagVariable = Get-Variable -Name $var
        $lag.Add($lagVariable.Name, $lagVariable.Value)
    }
    
    $json = $lag | ConvertTo-Json
        
    New-Item -Path $path -Value $json
    Write-Host 'Saved .Lag file'
}
    