function Clear-RabbitQueue () {
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

    $url = "$($credential.Url)/api/queues/$([Queue]::vHostDefault)/$($queue.Name)/contents"
    $header = $credential.GetHeader();

    Invoke-RestMethod -Uri $url -Header $header -Method Delete

    Write-Host 'Deleted messages' -ForegroundColor DarkGreen
}