using namespace System.IO
using namespace System
using namespace System.Text

$scriptsPath = [Path]::Combine($PSScriptRoot, '*')
$scripts = Get-ChildItem -Path $scriptsPath -Filter '*.ps1' -Recurse | Select-Object -ExpandProperty FullName
$scripts | ForEach-Object { Import-Module -Name $_ }

# Configurações RabbitMQ
$rabbitUrl =        "http://localhost:15672";
$rabbitApiUrl =     "${rabbitUrl}/api";

# Autenticação
$rabbitBase64Auth = [Convert]::ToBase64String([Encoding]::ASCII.GetBytes("guest:guest"));
$credential =       @{ Authorization = "Basic $rabbitBase64Auth" }

# Outros
$disregardList =        @('nsb.delay*');

$functionsToExport = @(
    "Get-RabbitOverview",
    "Get-RabbitQueueMessages",
    "Get-RabbitQueues",
    "Publish-RabbitMessageToQueue"
)

$variablesToExport = @(
    "credential"
)

Export-ModuleMember -Function $functionsToExport -Variable $variablesToExport