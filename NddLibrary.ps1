class Projeto {
    [string] $path    
    [string] $sln

    Projeto ([string]$path, [string]$sln) {
        $this.path = $path;
        $this.sln = $sln;
    }
}

function Set-Projeto-Variable {
    
    # .SYNOPSIS 
    # Defini as váriaveis de Projeto no ambiente local.

    param (        
        [Parameter()]
        [string]$pathProject,

        [Parameter()]
        [string]$nameVariable
    )

    if ([string]::IsNullOrEmpty($pathProject)) {
        $pathProject = Get-Location;
    }
    elseif (!Test-Path $pathProject) {
        Write-Error "Caminho inválido.";
        Write-Error "Operação Cancelada.";
        return;
    }

    $solutions = Get-ChildItem -Path $pathProject -Recurse -Filter '*.sln' -File;

    if (($solutions | Measure-Object).Count -eq 0) {
        Write-Error "Arquivo .sln não encontrado.";
        Write-Error "Operação Cancelada.";
        return;
    }

    $project = [Projeto]::new($pathProject, ($solutions | Select-Object -First 1).DirectoryName);

    if ([string]::IsNullOrEmpty($nameVariable)) {
        $nameVariable = [System.IO.DirectoryInfo]::new($pathProject).BaseName;
    }

    Set-Variable -Name $nameVariable -Value $project;

    Write-Output $"Variavel $($nameVariable) inputado."
}

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