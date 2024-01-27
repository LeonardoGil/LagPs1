<#
    .DESCRIPTION
    Para realizar a execução do script é necessário estar na pasta do projeto Polaris;

    O Script a seguir realiza o build das seguintes aplicações:
        - Layout
        - Gateway
        - Global-Styles
        - Platform-browser
    
    E publica os mesmo no IIS.
    Os Artefatos são gerados na Pasta padrão do ISS (C:\inetpub\wwwroot) no diretóro Move.
#>

using namespace System.IO;

<#
    Parte 1
    Gerar os artefatos na pasta C:\\inetpub\\wwwroot\\Teste + (Projeto)
#>

$projectsClient = @('global-styles', 'layout', 'platform-browser');

## Implementar ##
# $projectsDotnet = @('gateway'); 

$projectsPath = '';
$inetpub = "C:\\inetpub\\wwwroot\\Teste"

if (Test-Path 'projects')
{
    $local = Get-Location;
    $projectsPath = [Path]::Combine($local, 'projects');
}
else 
{
    Write-Output 'Necessário estar no caminho base do projeto.'
    Write-Output "Exemplo: 'C:\projetos\polaris'";
    return;
}

foreach ($project in $projectsClient)
{
    "ndk build $project" | Invoke-Expression;

    $distPath = [Path]::Combine($projectsPath, $project, 'Client', 'Dist');
    $pubPath = [Path]::Combine($inetpub, $project);

    if (-not (Test-Path $pubPath))
    {
        New-Item -ItemType Directory $pubPath -Force
    }
    
    Copy-Item "$distPath/*" $pubPath -Recurse;
}

<# PARTE 2
    Publicar os artefatos no IIS 
    Chamar o executavel C:\Program Files\IIS\Microsoft Web Deploy V3\msdeploy.exe
#>