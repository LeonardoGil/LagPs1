function Get-RabbitQueues() {
    [CmdletBinding()]
    param (
        [int]
        [Alias('c')]
        $clipboard,

        [switch]
        [Alias('m')]
        $withMessage
    )

    $queuesResult = Invoke-RestMethod -Uri "${rabbitUrl}/api/queues" -Headers $credential -Method Get;
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
            return;
        }
    }

    if ($clipboard -ne $null) {
        $name = $queues[$clipboard].name
        Write-Verbose "Set-Clipboard => $name"
        Set-Clipboard -Value $name
    }

    return $queues;
}