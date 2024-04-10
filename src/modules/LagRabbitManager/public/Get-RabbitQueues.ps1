function Get-RabbitQueues() {
    [CmdletBinding()]
    param (
        [nullable[int]]
        [Alias('c')]
        $clipboard,

        [switch]
        [Alias('m')]
        $withMessage,

        [nullable[int]]
        $showMessagesIndex
    )

    $queuesResult = Invoke-RestMethod -Uri "$($credential.Url)/api/queues" -Header $credential.GetHeader() -Method Get
    $queues = @()

    for ($i = 0; $i -lt $queuesResult.Count; $i++) {
        $queue = [Queue]::new()
        
        $queue.name = $queuesResult[$i].name
        $queue.messages = $queuesResult[$i].messages
        $queue.index = $i

        $queues += $queue
    }

    if ($withMessage) {
        $queues = $queues | Where-Object { $_.messages -gt 0 }        

        if ($null -eq $queues) {
            Write-Host 'No queue has messages' -ForegroundColor DarkYellow
            return
        }
    }

    if ($clipboard -ne $null) {
        $name = ($queues | Where-Object { $_.index -eq $clipboard}).name

        if ([string]::IsNullOrEmpty($name)) {
            Write-Host "Index [$clipboard] is out of range" -ForegroundColor Red
            return
        }

        Write-Host "saved $name" -ForegroundColor DarkYellow
        Set-Clipboard -Value $name

        return $name
    }

    if ($showMessagesIndex -ne $null) {
        $name = ($queues | Where-Object { $_.index -eq $showMessagesIndex}).name

        if ([string]::IsNullOrEmpty($name)) {
            Write-Host "Index [$showMessagesIndex] is out of range" -ForegroundColor Red
            return
        }

        return (Get-RabbitQueueMessages -nameQueue $name)
    }
    
    return $queues
}