function Clear-RabbitQueue () {
    <#
    .SYNOPSIS
        Limpa as mensagens de uma Fila especifica
    .DESCRIPTION
        Excluia as mensanges da fila informada
    .NOTES
        
    .EXAMPLE
        Clear-RabbitQueue $queue

        'Fila1', 'Fila2' | Clear-RabbitQueue

        Get-RabbitQueues -withMessage | Where-Object { $_ -contains 'erro' } | Select-Object -ExpandProperty name | Clear-RabbitQueue
    #>
    
    [CmdletBinding()]
    param (
        [Parameter(Position=0, Mandatory, ValueFromPipeline)]
        [string]
        $queueName
    )

    process {
        $queue = Get-RabbitQueues | Where-Object { $_.Name -like $queueName }

        if ($queue -isnot [Queue]) {
            Write-Host "Queue '$queueName' not found." -ForegroundColor Red
            return
        }

        $url = "$($credential.Url)/api/queues/$([Queue]::vHostDefault)/$($queueName)/contents"
        $header = $credential.GetHeader();

         Invoke-RestMethod -Uri $url -Header $header -Method Delete
    }

    end {
        Write-Host 'Deletion process completed.' -ForegroundColor DarkGreen
    }
}