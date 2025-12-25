# LagPs1

[![GitHub License](https://img.shields.io/badge/License-MIT-blue.svg)](LICENSE)

O **LagPs1** é um repositório com módulos PowerShell focados em automação e produtividade.
O projeto inclui módulos independentes (ex.: RabbitMQ, SQL Server, Azure) e um perfil de shell com atalhos para facilitar o uso no dia a dia.

## Conteúdo

- [LagPs1](#lagps1)
  - [Conteúdo](#conteúdo)
  - [Módulos](#módulos)
  - [Requisitos](#requisitos)
  - [Instalação (modo manual)](#instalação-modo-manual)

## Módulos

| Módulo | Descrição |
| --- | --- |
| [LagRabbitManager](src/modules/LagRabbitManager) | Interação com filas/mensagens do RabbitMQ (Management API). |
| [LagRegistroNacional](src/modules/LagRegistroNacional) | Geração de documentos nacionais randomizados. |
| [LagVariable](src/modules/LagVariable) | Gerenciamento de variáveis globais e persistência (.lag). |
| [LagSQL](src/modules/LagSQL) | Consultas e rotinas para SQL Server. |
| [LagAz](src/modules/LagAz) | Interação com Azure. |
| [LagUtil](src/modules/LagUtil) | Utilitários diversos (terminal/janelas). |
| [LagGit](src/modules/LagGit) | Funções auxiliares relacionadas a Git. |

## Requisitos

- PowerShell 5.1+ (Windows) ou PowerShell 7+.

## Instalação (modo manual)

Importe apenas o módulo necessário para a sessão atual:

```powershell
# Exemplo: LagRabbitManager
Import-Module .\src\modules\LagRabbitManager\LagRabbitManager.psd1 -Force

# Exemplo: LagVariable
Import-Module .\src\modules\LagVariable\LagVariable.psd1 -Force
```