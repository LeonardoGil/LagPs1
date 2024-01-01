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

function UpdateInator {
    Set-Location -Path $ndd.update
    .\updatinator.exe
}

function Get-Token-Portal {
    $body = @{
        grant_type='client_credentials'
        client_id='7afbb7b3a0ab4ede893e2f9490e9ffcf'
        client_secret='ibtwgrHna+thf+p9wkqdo7M250zyynUTwYXA72lPWC4='
    }
    
    $contentType = 'application/x-www-form-urlencoded' 
    
    $request = Invoke-WebRequest -Method POST -Uri 'https://host.docker.internal:5001/connect/token' -body $body -ContentType $contentType
    
    $json = $request.Content | ConvertFrom-Json

    $bearer =  "Bearer $($json.access_token)"; 

    Set-Clipboard -Value $bearer

    Write-Output "Token Gerado: $($bearer)"
}

function Get-Token-Mobile {
    $body = @{
        client_id='3b9a77fb35a54e40815f4fa8641234c5'
        grant_type='password'
        userName='11484671902'
        password='12345678'
    }
    
    $request = Invoke-WebRequest -Method POST -Uri 'http://localhost:9002/token' -body $body
    
    $json = $request.Content | ConvertFrom-Json

    $bearer =  "Bearer $($json.AccessToken)"; 

    Set-Clipboard -Value $bearer

    Write-Output "Token Gerado: $($bearer)"
}