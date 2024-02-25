$scriptsPath = [IO.Path]::Combine($PSScriptRoot, 'functions/*.ps1')
$lagAutoSave = $false

# Importa os scripts
Get-ChildItem -Path $scriptsPath -Recurse -ErrorAction Stop | ForEach-Object { Import-Module -Name $_ }

$functionsToExport = @(
    # File 
    "Push-LagVariablesFile",
    "Get-LagVariablesFile",
    "Save-LagVariablesFile"

    # Variable
    "Add-LagVariable",
    "New-LagVariable"
)

$variablesToExport = @(
    "lagAutoSave"
)

Export-ModuleMember -Function $functionsToExport -Variable $variablesToExport