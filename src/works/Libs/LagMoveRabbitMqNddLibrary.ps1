using namespace System;
using namespace System.Text;

# Configurações RabbitMQ
$rabbitUrl =        "http://localhost:15672";
$rabbitApiUrl =     "${rabbitUrl}/api";

# Autenticação
$rabbitBase64Auth = [Convert]::ToBase64String([Encoding]::ASCII.GetBytes("guest:guest"));
$credential =       @{ Authorization = "Basic $rabbitBase64Auth" }

$disregardList =        @('nsb.delay*');

class LagQueue {

    [string] $name
    [int] $messages
    [string] $vHost

    static [string] $vHostDefault = '%2f'
}

function Get-RabbitQueueMessages {
    param (
        [Parameter(Mandatory)]
        [string]
        $nameQueue
    )

    $body = @{
        ackmode  = "ack_requeue_true"
        encoding = "auto"            
        count  = 20  
    } | ConvertTo-Json

    $url = "$rabbitApiUrl/queues/$([LagQueue]::vHostDefault)/$nameQueue/get";

    Invoke-RestMethod -Uri $url -Headers $credential -Method Post -Body $body -ContentType "application/json";
}

function Get-RabbitQueues() {

    param (
        # Considera todas as filas
        [switch]
        $All
    )

    $queues = Invoke-RestMethod -Uri "${rabbitUrl}/api/queues" -Headers $credential -Method Get;

    $queues = $queues | ForEach-Object { 
        $queue = [LagQueue]::new();
        $queue.name = $_.name;
        $queue.messages = $_.messages;

        return $queue;
    };

    # Em construção
    # if (-not($All)) {
    #     # Desconsidera algumas filas (Como nsb.Delay)
    #     $queues = $queues | Where-Object {
    #         $queue = $_;
    #         $disregard = ($disregardList | Where-Object { $queue -like $_ }).Count > 0;
            
    #         Write-Output "$($queue.name) = $disregard";

    #         return -not($disregard);
    #     }
    # }
 
    Write-Output $queues;
}

function Get-RabbitOverview() {
    Invoke-RestMethod -Uri "${rabbitUrl}/api/overview" -Headers $credential -Method Get;   
}   