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

class LagQueue {

    [string] $name
    [int] $messages
    [string] $vHost

    static [string] $vHostDefault = '%2f'
}

$functionsToExport = @(
    "Get-RabbitOverview",
    "Get-RabbitQueueMessages",
    "Get-RabbitQueues"
)

$variablesToExport = @(
)

Export-ModuleMember -Function $functionsToExport -Variable $variablesToExport