function Get-RabbitQueueMessages {
    param (
        [Parameter(Mandatory)]
        [string]
        [Alias('name', 'queue')]
        $nameQueue,

        [Parameter()]
        [int]
        $count = 40,

        [Parameter()]
        [switch]
        $originalResult,
        
        [Parameter()]
        [string]
        $export
    )

    $body = @{
        ackmode  = "ack_requeue_true"
        encoding = "auto"            
        count  = $count  
    } | ConvertTo-Json

    $url = "$rabbitApiUrl/queues/$([Queue]::vHostDefault)/$nameQueue/get";

    $result = Invoke-RestMethod -Uri $url -Headers $credential -Method Post -Body $body -ContentType "application/json";

    if ($originalResult) {
        return $result
    }

    $messages = @()

    foreach ($obj in $result) {
        $message = [Message]::new()
        $message.Queue = $obj.exchange
        $message.Position = $obj.message_count
        $message.Payload = $obj.payload

        $message.MessageId = $obj.Properties.message_id
        $message.Type = $obj.Properties.type
        $message.ContentType = $obj.Properties.content_type

        # Write-Output $obj.Properties.headers

        $message.TimeSent = -join ($obj.Properties.headers.'NServiceBus.TimeSent'[0..18]) 

        if ($obj.Properties.headers.'Tenant') {
            $message.Tenant = $obj.Properties.headers.'Tenant'
        }

        $messages += $message
    }

    if (-not [string]::IsNullOrEmpty($export)) {
        Export-RabbitMessages -pathLocation $export -messages $messages
    }
    else {
        return $messages
    }
}