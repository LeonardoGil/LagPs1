function Build-Platform {

    Write-Output 'Iniciando Jobs';

    $coreBuildJob = Start-Job -Name 'coreBuildJob' -ScriptBlock { Import-Module -Name 'C:\PowerShell\NddLibrary.ps1'; Build-Project -Project 'core' };
    $layoutBuildJob = Start-Job -Name 'layoutBuildJob' -ScriptBlock { Import-Module -Name 'C:\PowerShell\NddLibrary.ps1'; Build-Project -Project 'layout' };
    $platformBrowserBuildJob = Start-Job -Name 'platformBrowserBuildJob' -ScriptBlock { Import-Module -Name 'C:\PowerShell\NddLibrary.ps1'; Build-Project -Project 'platform-browser' };
    $globalStylesBuildJob = Start-Job -Name 'globalStylesBuildJob' -ScriptBlock { Import-Module -Name 'C:\PowerShell\NddLibrary.ps1'; Build-Project -Project 'global-styles' };

    Write-Output 'Aguardando execução';
    Wait-Job -Name 'coreBuildJob', 'layoutBuildJob', 'platformBrowserBuildJob', 'globalStylesBuildJob';

    Receive-Job -Job $coreBuildJob;
    Receive-Job -Job $layoutBuildJob;
    Receive-Job -Job $platformBrowserBuildJob;
    Receive-Job -Job $globalStylesBuildJob;

    Write-Output 'Excluindo jobs';
    Remove-Job $coreBuildJob, $layoutBuildJob, $platformBrowserBuildJob, $globalStylesBuildJob;

    Write-Output 'Exit code: 0';
}

function Build-Project {
    
    param (        
        [Parameter(Mandatory=$true)]
        [string]
        $Project
    )

    if ([string]::IsNullOrEmpty($Project)) {
        Write-Error 'Variavel do Projeto vazia.'
        return;
    }
    
    try {
        
        Set-Location "C:\Projetos\nddFrete_Platform";

        ndk build $Project --featureMode=tpl;

        if ($lastexitcode -ne 0) {
            throw ("Fail build $Project -> $errorMessage");
        }

        clear-;
        Write-Host "Successfully build $Project" -ForegroundColor Green;
    }
    catch {
        Clear-Host; 
        Write-Host "Fail build $Project" -ForegroundColor Red;
    }
}

function Invoke-Projects {

    param (
        [Parameter(Mandatory=$true)]
        [string]
        $path
    )

    Set-Location $path;

    wt new-tab --run `
    {
        Write-Output 'Teste';
    } -p 'Windows PowerShell'
}

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

function Docker-Lag {
    $actual = Get-Location

    Set-Location -Path $tpl.path
    Set-Location -Path .\Configurations\Docker
    
    docker-compose -f tpl.yml up -d --force-recreate

    Set-Location -Path $actual
}

function Lag-Client-TPL {
    Set-Location -Path $platform.Path;
    ndk run 'client-tpl';
}

function Lag-TPL {
    Set-Location -Path $platform.Path;
    ndk run 'tpl';
}

function Open-Info {
    code $ndd.server
}

function UpdateInator {
    Set-Location -Path $ndd.update
    .\updatinator.exe
}