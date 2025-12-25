[CmdletBinding()]

param (
    [Parameter(Mandatory)]
    [string]
    $ModuleName,

    [string]
    $ModuleRoot = $null,

    [string]
    $OutDir = $null
)

if (-not $ModuleRoot) {
    
    if ($PSScriptRoot) {
        $ModuleRoot = $PSScriptRoot
    }
    elseif ($PSCommandPath) {
        $ModuleRoot = Split-Path -Path $PSCommandPath -Parent
    }
    elseif ($MyInvocation?.MyCommand?.Definition) {
        $ModuleRoot = Split-Path -Path $MyInvocation.MyCommand.Definition -Parent
    }
    else {
        $ModuleRoot = (Get-Location).ProviderPath
    }
}

$ModulePath = Join-Path $ModuleRoot "$ModuleName.psm1"
if (-not (Test-Path $ModulePath)) {
    throw "Módulo (.psm1) não encontrado: $ModulePath"
}

$ManifestPath = Join-Path $ModuleRoot "$ModuleName.psd1"
if (-not (Test-Path $ManifestPath)) {
    throw "Manifest de módulo (.psd1) não encontrado: $ManifestPath"
}

if (-not $OutDir) {
    $OutDir = Join-Path $ModuleRoot 'dist'
}

$OutPsm1 = Join-Path $OutDir "$ModuleName.psm1"
$OutPsd1 = Join-Path $OutDir "$ModuleName.psd1"

New-Item -ItemType Directory -Path $OutDir -Force | Out-Null
New-Item -ItemType File -Path $OutPsm1 -Force | Out-Null
New-Item -ItemType File -Path $OutPsd1 -Force| Out-Null

# Cabeçalho
@"
# ==================================================
# Module      : $ModuleName
# Generated   : $(Get-Date -Format 'yyyy-MM-dd HH:mm:ss')
# Source Root : $(Resolve-Path $ModuleRoot)
# Output File : $(Resolve-Path $OutPsm1)
# ==================================================
"@ | Set-Content $OutPsm1 -Encoding UTF8

function Add-ScriptsToPsm1($Path, $Filter) {
    
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

$Paths = @{
    Class   = Join-Path $ModuleRoot 'class'
    Private = Join-Path $ModuleRoot 'private'
    Public  = Join-Path $ModuleRoot 'public'
}

Add-ScriptsToPsm1 $Paths.Class '*.ps1'
Add-ScriptsToPsm1 $Paths.Private '*.ps1'
Add-ScriptsToPsm1 $Paths.Public '*.ps1'

$PublicDir = $Paths.Public
$PublicFunctions = @()

if (Test-Path $PublicDir) {
    $PublicFunctions = Get-ChildItem -Path $PublicDir -Recurse -Filter *.ps1 | Select-Object -ExpandProperty BaseName -Unique
}

if ($PublicFunctions -and $PublicFunctions.Count -gt 0) {
    "`nExport-ModuleMember -Function $($PublicFunctions -join ', ')" | Add-Content $OutPsm1 -Encoding UTF8
}

(Get-Content "$ModuleRoot\$ModuleName.psd1" -Raw) -replace "RootModule\s*=\s*'.*?'", "RootModule = '$ModuleName.psm1'" | Set-Content $OutPsd1 -Encoding UTF8