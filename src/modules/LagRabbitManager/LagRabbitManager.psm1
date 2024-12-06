using namespace System.IO
using namespace System

$scriptsPath = [Path]::Combine($PSScriptRoot, '*')

Get-ChildItem -Path $scriptsPath -Filter '*.ps1' -Recurse | 
    Select-Object -ExpandProperty FullName | 
        ForEach-Object { Import-Module -Name $_ }

# Autenticação
Set-RabbitCredential 'http://localhost:15672' 'guest' 'guest'

New-Alias -Name 'grq' -Value Get-RabbitQueues
New-Alias -Name 'grqm' -Value Get-RabbitQueueMessages
New-Alias -Name 'crq' -Value Clear-RabbitQueues

$functionsToExport = @(
    "Get-RabbitOverview",
    "Get-RabbitQueueMessages",
    "Get-RabbitQueues",
    "Publish-RabbitMessageToQueue",
    "Clear-RabbitQueue",
    "Clear-RabbitQueues",
    "Set-RabbitCredential"
    "Export-RabbitMessages"
)

$variablesToExport = @(
)

$aliasToExport = @(
    "grq",
    "grqm",
    "crq"
)

Export-ModuleMember -Function $functionsToExport -Variable $variablesToExport -Alias $aliasToExport