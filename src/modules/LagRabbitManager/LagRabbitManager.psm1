using namespace System.IO
using namespace System

$scriptsPath = [Path]::Combine($PSScriptRoot, '*')

Get-ChildItem -Path $scriptsPath -Filter '*.ps1' -Recurse | 
    Select-Object -ExpandProperty FullName | 
        ForEach-Object { Import-Module -Name $_ }

# Autenticação
Set-RabbitCredential 'http://localhost:15672' 'guest' 'guest'

# Outros
$disregardList =        @('nsb.delay*');

$functionsToExport = @(
    "Get-RabbitOverview",
    "Get-RabbitQueueMessages",
    "Get-RabbitQueues",
    "Publish-RabbitMessageToQueue",
    "Remove-RabbitMessages",
    "Clear-RabbitQueues",
    "Set-RabbitCredential"
)

$variablesToExport = @(
)

Export-ModuleMember -Function $functionsToExport -Variable $variablesToExport