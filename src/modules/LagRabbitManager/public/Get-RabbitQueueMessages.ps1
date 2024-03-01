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