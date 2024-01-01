function Get-Lag-Variables {
    param ( 
        [Parameter(Position=0)]
        [string]
        $Path
    )

    if ([string]::IsNullOrEmpty($path)) {
        $Path = Set-Location;
    }

    $file = '.lag';
    $filePath = [string]::Concat($path, '/', $file);
    
    if (-not (Test-Path $filePath)) {
        Write-Error 'Arquivo .lag nao Localizado!'
        return;
    }

    Write-Output 'File .lag Ok!';

    try {
        $fileContent = [System.IO.File]::ReadAllText($filePath) | ConvertFrom-Json;

        $fileContent.psobject.properties | ForEach-Object {
            try {
                Write-Output "Consultando variavel: $($_.Name)"
                Set-Variable -Name $_.Name -Value $_.Value -Scope Global; 
            }
            catch [System.Management.Automation.ItemNotFoundException] {
                Write-Output "Status: Nova"
                New-Variable -Name $_.Name -Value $_.Value -Scope Global;
            }
            catch [System.Exception] {
                Write-Error 'Ocorreu um erro inesperado!'
                Write-Error $_.Exception.Message;
            }
        }  
    }
    catch {
        Write-Error 'Ocorreu um erro inesperado!'
        Write-Error $_.Exception.Message;
    }
    finally {
        Write-Output 'Finish!'
    }
}