class Message {
        [guid]$MessageId
        [string]$Queue
        [int]$Position
        [string]$Type
        [string]$Payload
        [string]$ContentType

        [string]$ExceptionMessage
        [string]$ExceptionStackTrace

        [datetime]$TimeSent
        [string]$Tenant
}