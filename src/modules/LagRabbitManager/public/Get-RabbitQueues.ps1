function Get-RabbitQueues() {
    [CmdletBinding()]
    param (
        [int]
        $clipboard 
    )

    $queuesResult = Invoke-RestMethod -Uri "${rabbitUrl}/api/queues" -Headers $credential -Method Get;
    $queues = @()

    for ($i = 0; $i -lt $queuesResult.Count; $i++) {
        $queue = [LagQueue]::new()
        
        $queue.name = $queuesResult[$i].name
        $queue.messages = $queuesResult[$i].messages
        $queue.index = $i

        $queues += $queue
    }

    if ($clipboard -ne $null) {
        $name = $queues[$clipboard].name
        Write-Verbose "Set-Clipboard => $name"
        Set-Clipboard -Value $name
    }

    return $queues;
}