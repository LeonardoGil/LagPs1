using namespace System.Management.Automation.Host;


function Get-RabbitQueues() {
    [CmdletBinding()]
    param (
        [nullable[int]]
        [Alias('c')]
        $clipboard,

        [switch]
        [Alias('wm')]
        $withMessage,

        [nullable[int]]
        $messages,

        [switch]
        [Alias('i')]
        $interactive
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

    if ($interactive) {
        $choices = [ChoiceDescription[]](
            [ChoiceDescription]::new("Yes"),
            [ChoiceDescription]::new("No")
        )

        $withMessage = ($host.UI.PromptForChoice("Yes", "Search queues with messages?", $choices, 0) -eq 0)
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

    if ($messages -ne $null) {
        $name = ($queues | Where-Object { $_.index -eq $messages}).name

        if ([string]::IsNullOrEmpty($name)) {
            Write-Host "Index [$messages] is out of range" -ForegroundColor Red
            return
        }

        return (Get-RabbitQueueMessages -nameQueue $name)
    }
    
    return $queues
}