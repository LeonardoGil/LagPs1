using namespace System.IO
using namespace System

$scriptsPath = [Path]::Combine($PSScriptRoot, '*')

Get-ChildItem -Path $scriptsPath -Filter '*.ps1' -Recurse | 
    Select-Object -ExpandProperty FullName | 
        ForEach-Object { Import-Module -Name $_ }

# Autenticação
Set-RabbitCredential 'http://localhost:15672' 'guest' 'guest'

$functionsToExport = @(
    "Get-RabbitOverview",
    "Get-RabbitQueueMessages",
    "Get-RabbitQueues",
    "Publish-RabbitMessageToQueue",
    "Clear-RabbitQueue",
    "Clear-RabbitQueues",
    "Set-RabbitCredential",
    "Start-RabbitInteractive"
)

$variablesToExport = @(
)

Export-ModuleMember -Function $functionsToExport -Variable $variablesToExport