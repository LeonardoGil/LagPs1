function Remove-RabbitMessages () {
    [CmdletBinding()]
    param (
        [Parameter(Position=0, Mandatory)]
        [string]
        $queueName
    )

    $queue = Get-RabbitQueues | Where-Object { $_.Name -like $queueName }

    if ($queue -isnot [Queue]) {
        Write-Host 'Queue not found.' -ForegroundColor Red
        return
    } 

    $url = "${rabbitApiUrl}/queues/$([Queue]::vHostDefault)/$($queue.Name)/contents"

    Invoke-RestMethod -Uri $url -Headers $credential -Method Delete

    Write-Host 'Deleted messages' -ForegroundColor DarkGreen
}