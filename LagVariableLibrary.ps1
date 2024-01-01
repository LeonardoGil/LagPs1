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

    Write-Output 'Ok!';
}