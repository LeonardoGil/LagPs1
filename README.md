# LagPs1

[![GitHub License](https://img.shields.io/badge/License-MIT-blue.svg)](LICENSE)

Esse é meu primeiro projeto Powershell totalmente voltado para automatizar e agilizar demandas do dia a dia  
O intuito é adquirir e praticar todo conhecimento obtido sobre a tecnologia..

## 🚀 Funcionalidades Principais

- **Modulo de Registro Nacional:** Modulo de registro de Documento Nacionais aleatórios. 
> Como: CPF, CNPJ, Chaves de acesso NFe/CTe/MDFe...
- **Modulo de Gerenciamento de Variaveis:** Modulo de gerenciamento das Variaveis da sessão do Powershell. 
> Podendo Importar/Exportar/Manipular as variaveis do ambiente...
- **Outros**
> Já volto para informar 😅

## 📦 Instalação

1. Clone o projeto na sua máquina;
2. Abra o arquivo Profile e cole o seguinte código:
> Para descobrir o caminho do arquivo profile, basta digitar no seu terminal: $PROFILE

```powershell
$projectPath = "PASTA DO PROJETO";

Import-Module -Name "$projectPath/src/profiles/LagProfile.ps1"
```
