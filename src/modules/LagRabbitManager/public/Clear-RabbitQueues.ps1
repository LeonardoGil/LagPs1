function Clear-RabbitQueues {
    <#
    .SYNOPSIS
        Limpa as mensagens de todas as filas
    .DESCRIPTION
        Excluia as mensanges de todas filas disponiveis
    .NOTES
        
    .EXAMPLE
        Clear-RabbitQueues
    #>
    
    [CmdletBinding()]
    param()

    $queues = Get-RabbitQueues -withMessage                                           

    if ($queues.Count -eq 0) {
        Write-Host 'Empty queues' -ForegroundColor DarkYellow
        return
    }

    $queues | Select-Object -ExpandProperty Name | Clear-RabbitQueue
}