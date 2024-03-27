function Clear-RabbitQueues {
    $queues = Get-RabbitQueues -withMessage

    if ($queues.Count -eq 0) {
        Write-Host 'Empty queues' -ForegroundColor DarkYellow
        return
    } 

    $header = $credential.GetHeader();

    $queues | ForEach-Object {
        $url = "$($credential.Url)/api/queues/$([Queue]::vHostDefault)/$($_.Name)/contents"
        Invoke-RestMethod -Uri $url -Header $header -Method Delete
    }

    Write-Host 'Deleted messages' -ForegroundColor DarkGreen
}