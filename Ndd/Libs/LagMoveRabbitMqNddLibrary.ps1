using namespace System;
using namespace System.Text;

# Configurações RabbitMQ
$rabbitUrl =        "http://localhost:15672";
$rabbitBase64Auth = [Convert]::ToBase64String([Encoding]::ASCII.GetBytes("guest:guest"));
$credential =       @{ Authorization = "Basic $rabbitBase64Auth" }
$disregardList =        @('nsb.delay*');

class LagQueue {

    [string] $name
    [int] $messages
    [string] $vHost

    static [string] $vHostDefault = '%2f'
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