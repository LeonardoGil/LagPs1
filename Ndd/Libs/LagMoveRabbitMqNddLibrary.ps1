using namespace System;
using namespace System.Text;

# Configurações RabbitMQ
$rabbitUrl = "http://localhost:15672";
$user = "guest";
$pass = "guest";

$base64AuthInfo = [Convert]::ToBase64String([Encoding]::ASCII.GetBytes("${user}:${pass}"));

function Get-RabbitQueues() {
    return Invoke-RestMethod -Uri "${rabbitUrl}/api/queues" -Headers @{ Authorization = "Basic $base64AuthInfo" } -Method Get
}
