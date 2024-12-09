# LagPs1

[![GitHub License](https://img.shields.io/badge/License-MIT-blue.svg)](LICENSE)

**LagPs1** é uma coleção de módulos PowerShell desenvolvidos para automatizar tarefas e facilitar a interação com ferramentas específicas.

## 🚀 Modulos:

- [**LagRabbitManager:**](https://github.com/LeonardoGil/LagPs1/tree/main/src/modules/LagRabbitManager) Módulo para interação com filas e mensagens do RabbitMQ.
- [**LagRegistroNacional:**](https://github.com/LeonardoGil/LagPs1/tree/main/src/modules/LagRegistroNacional) Módulo para geração de documentos nacionais randomizados.
- [**LagVariable:**](https://github.com/LeonardoGil/LagPs1/tree/main/src/modules/LagVariable) Módulo para gerenciamento de Variaveis globais nas sessões.
- [**LagSQL:**](https://github.com/LeonardoGil/LagPs1/tree/main/src/modules/LagSQL) Módulo para realização de consultas no banco SQLServer.
- [**LagAZ:**](https://github.com/LeonardoGil/LagPs1/tree/main/src/modules/LagAz) Módulo para interação com Azure.

## 📦 Instalação

1. Clone o projeto na sua máquina;
2. Abra o arquivo Profile e cole o seguinte código:
> Para descobrir o caminho do arquivo profile, basta digitar no seu terminal: $PROFILE

```powershell
$projectPath = "PASTA DO PROJETO";

Import-Module -Name "$projectPath/src/profiles/LagProfile.ps1"
```
