using namespace System

function Get-RabbitQueueMessages {
    param (
        [Parameter(ValueFromPipeline, Mandatory)]
        [string]
        [Alias('name', 'queue')]
        $nameQueue,

        [Parameter()]
        [int]
        $count = 100,

        [Parameter()]
        [switch]
        $originalResult,
        
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

    begin {
        $body           = @{
                            ackmode     = "ack_requeue_true"
                            encoding    = "auto"            
                            count       = $count  
                        } | ConvertTo-Json

        $contentType    = 'application/json'
        $baseUrl        = $credential.Url + '/api/queues/' + [Queue]::vHostDefault
        $header         = $credential.GetHeader() 
    }

    process {
        $url        = "$baseUrl/$nameQueue/get";
        $result     = @()

        try {
            $result = Invoke-RestMethod -Uri $url -Header $header -Method Post -Body $body -ContentType $contentType  
        }
        catch [System.Net.WebException] {
            $message = "Ocorreu um erro ao estabelecer conexão com RabbitMQ"
            throw New-Object Exception $message
        }
        catch {
            $message = "Ocorreu um erro inesperado: $_"
            throw New-Object Exception $message
        }
    
        if ($originalResult.IsPresent) {
            return $result
        }
    
        $messages =  Get-RabbitQueueMessagesFilter ($result | ConvertTo-Message) -type $type -tenant $tenant
    
        if ($fullDetails.IsPresent) {
            return $messages
        }
    
        return $messages | Select-Object -Property Queue, Position, Type, Tenant, TimeSent, ExceptionMessage | Format-List
    }
}


function ConvertTo-Message {
    [CmdletBinding()]
    param (
        [Parameter(ValueFromPipeline)]
        [PSCustomObject]
        $obj
    )
    
    process {
        $message = New-Object Message

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

        return $message
    }    
}

function Get-RabbitQueueMessagesFilter {
    [CmdletBinding()]
    param (
        [parameter()]
        [Message[]]
        $messages,

        [Parameter()]
        [string]
        $type,

        [Parameter()]
        [string]
        $tenant
    )

    if (-not [string]::IsNullOrEmpty($type)) {
        $messages = $messages | Where-Object { $_.Type -like "*$type*" }
    }
    
    if (-not [string]::IsNullOrEmpty($tenant)) {
        $messages = $messages | Where-Object { $_.Tenant -like "*$tenant*" }
    }
    
    return $messages
}