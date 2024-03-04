function Get-RabbitQueueMessages {
    param (
        [Parameter(Mandatory)]
        [string]
        [Alias('name', 'queue')]
        $nameQueue,

        [Parameter()]
        [int]
        $count = 40
    )

    $body = @{
        ackmode  = "ack_requeue_true"
        encoding = "auto"            
        count  = $count  
    } | ConvertTo-Json

    $url = "$rabbitApiUrl/queues/$([Queue]::vHostDefault)/$nameQueue/get";

    $result = Invoke-RestMethod -Uri $url -Headers $credential -Method Post -Body $body -ContentType "application/json";
    $messages = @()

    foreach ($obj in $result) {
        $message = [Message]::new()
        $message.Queue = $obj.exchange
        $message.Position = $obj.message_count
        $message.Payload = $obj.payload

        $message.Type = $obj.Properties.type
        $message.ContentType = $obj.Properties.content_type

        $message.MessageId = $obj.Properties.Headers.NServiceBus.MessageId
        $meesage.TimeSent = $obj.Properties.Headers.NServiceBus.TimeSent
        $meesage.TimeSent = $obj.Properties.Headers.Tenant

        $messages += $message
    }

    return $messages
}