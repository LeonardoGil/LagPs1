using namespace System;
using namespace System.Text;

# Configurações RabbitMQ
$rabbitUrl = "http://localhost:15672";
$rabbitBase64Auth = [Convert]::ToBase64String([Encoding]::ASCII.GetBytes("guest:guest"));

function Get-RabbitQueues() {
    return Invoke-RestMethod -Uri "${rabbitUrl}/api/queues" -Headers @{ Authorization = "Basic $rabbitBase64Auth" } -Method Get | 
            ForEach-Object { $_.Name };
}