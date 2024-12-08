# LagRabbitManager

## Descrição
O **LagRabbitManager** é um módulo PowerShell para interações com o RabbitMQ, permitindo consultar, manipular e monitorar filas e mensagens de forma simples.

## Instalação
1. Certifique-se de ter o PowerShell 5.1+ instalado.
2. Clone o repositório e importe o Modulo para sessão.
    ```powershell
    git clone https://github.com/LeonardoGil/LagPs1.git
    
    Set-Location 'LagPs1/src/LagRabbitManager'
    
    Import-Module ./LagRabbitManager.psm1
    ```

## Cmdlets Disponíveis

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