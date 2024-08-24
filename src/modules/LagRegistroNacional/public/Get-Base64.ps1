 # Mudar de lugar
function Get-Base64 {
    
    [CmdletBinding()]
    param (
        [Parameter(Position=0, Mandatory)]
        [string]
        $filePath
    )
    
    if (-not (Test-Path $filePath)) {
        Write-Host 'Arquivo não encontrado!' -ForegroundColor DarkYellow
        return 
    }

    $bytes = [System.IO.File]::ReadAllBytes($filePath)

    return [System.Convert]::ToBase64String($bytes)
}