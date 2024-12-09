# LagRabbitManager

## Descrição
O **LagRabbitManager** é um módulo PowerShell projetado para facilitar a interação com o RabbitMQ, permitindo consultar, manipular e monitorar filas e mensagens de maneira simples e eficiente.

## Instalação
1. Certifique-se de ter o PowerShell 5.1+ instalado.
2. Clone o repositório e importe o Modulo para sessão.
    ```powershell
    git clone https://github.com/LeonardoGil/LagPs1.git
    
    Set-Location 'LagPs1/src/LagRabbitManager'
    
    Import-Module ./LagRabbitManager.psm1
    ```

## Cmdlets Disponíveis

### `Get-RabbitQueues`
Obtem as filas do RabbitMQ

**Parâmetros**:  
  
`-clipboard` | `-c` : Copia o nome da fila para Area de Transferencia. Deve informar a posição da Fila  
`-withMessage` | `-wm` : Obtem apenas as filas com mensagens  
`-messages` | `-m` : Obtem as mensagens da fila informada. Deve informar a posição da Fila  
`-interactive` | `-i` : Habilita o modo interativo  

**Exemplo**:
```powershell
Get-RabbitQueues -withMessage

Get-RabbitQueues -i

Get-RabbitQueues -messages 1

Get-RabbitQueues -clipboard 2 | Clear-RabbitQueue
```

### `Set-RabbitCredential`
Defini a credencial de uso do RabbitMQ na sessão  

**Parâmetros**:  
  
`-Url`: URL do servidor RabbitMQ  
`-User`: Nome de usuário  
`-Pass`: Senha  

**Exemplo**:
```powershell
# Credencial utilizado por padrão ao importar o Modulo
Set-RabbitCredential 'http://localhost:15672' 'guest' 'guest'
``` 