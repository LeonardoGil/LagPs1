function Start-RabbitInteractive() {
    $run = $true

    do {
        Clear-Host
        Write-Host 'Informe uma acao: ' -ForegroundColor DarkGreen
        Write-Host '1 - Consultar Filas com mensagens'
        Write-Host '9 - Sair'

        $out = Read-Host

        switch ($out) {
            "1" { Get-RabbitQueues -withMessage }
            
            "9" { $run = $false }
            Default {
                Write-Host 'Valor invalido' -ForegroundColor DarkYellow
            }
        }
        
        Write-Host "$([System.Environment]::NewLine)"
        Write-Host 'Aperte Enter para continuar...'
        Read-Host
    } while ($run)
}