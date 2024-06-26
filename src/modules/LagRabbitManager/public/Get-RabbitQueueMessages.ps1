function Get-RabbitQueueMessages {
    param (
        [Parameter(Mandatory, ValueFromPipeline=$true)]
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
        $export,

        [Parameter()]
        [switch]
        $fullDetails,

        [Parameter()]
        [string]
        $tenant,

        [Parameter()]
        [string]
        $type
    )

    $body = @{
        ackmode  = "ack_requeue_true"
        encoding = "auto"            
        count  = $count  
    } | ConvertTo-Json

    $url = "$($credential.Url)/api/queues/$([Queue]::vHostDefault)/$nameQueue/get";

    $result = Invoke-RestMethod -Uri $url -Header $credential.GetHeader() -Method Post -Body $body -ContentType "application/json";

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

        $headers = $obj.Properties.headers

        $message.TimeSent = -join ($headers.'NServiceBus.TimeSent'[0..18]) 

        if ($headers.'Tenant') { $message.Tenant = $headers.'Tenant' }
        if ($headers.'NServiceBus.ExceptionInfo.StackTrace') { $message.ExceptionStackTrace = $headers.'NServiceBus.ExceptionInfo.StackTrace' }
        if ($headers.'NServiceBus.ExceptionInfo.Message') { $message.ExceptionMessage = $headers.'NServiceBus.ExceptionInfo.Message' }

        $messages += $message
    }

    if (-not [string]::IsNullOrEmpty($type)) {
        $messages = $messages | Where-Object { $_.Type -like "*$type*" }
    }

    if (-not [string]::IsNullOrEmpty($tenant)) {
        $messages = $messages | Where-Object { $_.Tenant -like "*$tenant*" }
    }

    if (-not [string]::IsNullOrEmpty($export)) {
        Export-RabbitMessages -pathLocation $export -messages $messages
        return
    }

    if ($fullDetails) {
        return $messages | Format-List
    }

    return $messages | Select-Object -Property Queue, Position, Type, Tenant, TimeSent, ExceptionMessage | Format-List
}