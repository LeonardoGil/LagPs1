function Get-Logs-Files {

    # .SYNOPSIS 
    # Retorna uma Lista de arquivos Logs geradas a partir da aplicação do Operador Logistico.

    # .PARAMETER -Path
    # Caminho aonde será obtido os Logs.

    # .PARAMETER -All
    # Retorna os arquivos Logs incluindo todos os formatos. Exemple: 'log.1', 'log.2', 'log.3'...

    # .EXAMPLE
    # Get-Logs-Files -Path "C:\Example" --All 

    param (
        [Parameter(Mandatory=$true)]
        [string]$Path,

        [Parameter()]
        [switch]$All
    )

    Write-Output 'Listando Logs Operador...';
    
    $files = Get-ChildItem -Path $path -Recurse -File;

    if (!$All) {
        $files = $files | Where-Object Extension -eq ".txt"; 
    }

    return $files;
}

function Restore-Docker-TPL {
    $actual = Get-Location

    Set-Location -Path $tpl.path
    Set-Location -Path .\Configurations\Docker
    
    docker-compose -f tpl.yml up -d --force-recreate

    Set-Location -Path $actual
}

function Initialize-Client-TPL {
    Set-Location -Path $platform.Path;
    ndk run 'client-tpl';
}

function Initialize-TPL {
    Set-Location -Path $platform.Path;
    ndk run 'tpl';
}