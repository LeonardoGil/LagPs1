# LagPs1

[![GitHub License](https://img.shields.io/badge/License-MIT-blue.svg)](LICENSE)

Esse é meu primeiro projeto Powershell totalmente voltado para automatizar e agilizar demandas do dia a dia  
O intuito é adquirir e praticar todo conhecimento obtido sobre a tecnologia..

## 🚀 Modulos:

- **LagRegistroNacional:** 
> Modulo responsavel pela geração de Documento Nacionais aleatórios.
- **LagVariable** 
> Modulo responsavel pelo gerenciamento das Variaveis da sessão do Powershell. 
- **LagRabbitManager** 
> Modulo responsavel por facilitar a visualização de Filas e mensagens do RabbitMQ.
- **LagMove**
> Modulo responsavel por automatizar ações da aplicação do MOVE.
  
## 😉 Profile

- **LagProfile**
> Perfil pessoal para configuração da sessão do Powershell.
  
## 📦 Instalação

1. Clone o projeto na sua máquina;
2. Abra o arquivo Profile e cole o seguinte código:
> Para descobrir o caminho do arquivo profile, basta digitar no seu terminal: $PROFILE

```powershell
$projectPath = "PASTA DO PROJETO";

Import-Module -Name "$projectPath/src/profiles/LagProfile.ps1"
```
