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