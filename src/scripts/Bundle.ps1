[CmdletBinding()]

param (
    [Parameter(Mandatory)]
    [string]
    $ModuleName,

    [string]
    $ModuleRoot = (Resolve-Path .),

    [string]
    $OutDir = (Join-Path $ModuleRoot 'dist')
)

$OutPsm1 = Join-Path $OutDir "$ModuleName.psm1"
$OutPsd1 = Join-Path $OutDir "$ModuleName.psd1"

New-Item -ItemType Directory -Path $OutDir -Force | Out-Null

# Cabeçalho
@"
# ==================================================
# Module: $ModuleName
# Generated on: $(Get-Date -Format 'yyyy-MM-dd HH:mm:ss')
# ==================================================
"@ | Set-Content $OutPsm1 -Encoding UTF8

function Add-Files($Path, $Filter) {
    
    if (-not (Test-Path $Path)) {
        return 
    }

    Get-ChildItem $Path -Recurse -Filter $Filter |
    Sort-Object FullName |
    ForEach-Object {
        "`n# ----- $($_.FullName) -----`n" | Add-Content $OutPsm1 -Encoding UTF8
        Get-Content $_.FullName -Raw | Add-Content $OutPsm1 -Encoding UTF8
    }
}

Add-Files "$ModuleRoot\class" '*.ps1'
Add-Files "$ModuleRoot\private" '*.ps1'
Add-Files "$ModuleRoot\public" '*.ps1'

$PublicFunctions = Get-ChildItem "$ModuleRoot\public" -Filter *.ps1 | Select-Object -ExpandProperty BaseName

"`nExport-ModuleMember -Function $($PublicFunctions -join ', ')" | Add-Content $OutPsm1 -Encoding UTF8

(Get-Content "$ModuleRoot\$ModuleName.psd1" -Raw) -replace "RootModule\s*=\s*'.*?'", "RootModule = '$ModuleName.psm1'" | Set-Content $OutPsd1 -Encoding UTF8