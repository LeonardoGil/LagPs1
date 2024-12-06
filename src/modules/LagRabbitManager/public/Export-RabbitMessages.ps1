function Export-RabbitMessages () {
    <#
    .SYNOPSIS
        Exporta o payload das Mensagens do Rabbit
    .DESCRIPTION
        Cria um novo diretorio contendo os arquivos .xml dos Payloads das mensagens informadas.

        Nome do Diretorio: LagRabbitExport_(New-Guid)
        Nome do Arquivo: Message_$($messageId).xml
    .NOTES
        
    .LINK
        
    .EXAMPLE
        Export-RabbitMessages $messages

        Export-RabbitMessages $messages 'C:\Temp\'

        Get-RabbitQueueMessages $QueueName | Export-RabbitMessages 
    #>
    
    [CmdletBinding()]    
    param (
        [Parameter(Mandatory, ValueFromPipeline, Position=0)]
        [Message[]]
        $messages,

        [Parameter(Position=1)]
        [string]
        $pathLocation = (Get-Location)
    )

    # Gera o diretorio para armazenar os xmls
    begin {
        if (-not (Test-Path $pathLocation)) {
            Write-Host 'Path invalid' -ForegroundColor Red
            return
        }
    
        $path = Join-Path -Path $pathLocation -ChildPath "LagRabbitExport_$(New-Guid)"
    
        New-Item -ItemType Directory $path | Out-Null
    }

    # Gera o arquivo com Payload da mensagem
    process {
        foreach ($message in $messages) {
            $fileName = "Message_$($message.MessageId).xml"
            $filePath = Join-Path -Path $path -ChildPath $fileName

            $message.Payload | Set-Content -Path $filePath -Force -Encoding UTF8
        }
    }

    end {
        Write-Host "Exported messages! Directory: $path"
    }
}