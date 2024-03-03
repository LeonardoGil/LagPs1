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

    $url = "$rabbitApiUrl/queues/$([Queue]::vHostDefault)/$nameQueue/get";

    $result = Invoke-RestMethod -Uri $url -Headers $credential -Method Post -Body $body -ContentType "application/json";

    return $result
}