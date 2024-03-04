class Message {
        [guid]$MessageId
        [string]$Queue
        [int]$Position
        [string]$Type
        [string]$Payload
        [string]$ContentType

        [datetime]$TimeSent
        [string]$Tenant
}