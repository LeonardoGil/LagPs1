$scriptsPath = [IO.Path]::Combine($PSScriptRoot, 'functions/*.ps1')

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

Export-ModuleMember -Function $functionsToExport