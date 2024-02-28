function Set-LagVariable {

    [CmdletBinding()]
    param (
        [Parameter(Mandatory)]
        [string]
        $key,

        [Parameter()]
        [string]
        $parameter,

        [Parameter()]
        [string]
        $value
    )

    $ErrorActionPreference = 'Stop'

    try {
        Get-Variable -Name $key -ErrorAction 'Stop'
    }
    catch {
        Write-Host "Key ($key) not found." -ForegroundColor Red
        return
    }

    # Variavel simples
    if ($key -is [string]) {
        Set-Variable -Name $key -Value $value
    }
    # Variavel composta
    else {
        if ([string]::IsNullOrEmpty($parameter)) {
            Write-Host 'Please specify the property you want to change' -ForegroundColor DarkYellow
            $parameter = Read-Host

            if ([string]::IsNullOrEmpty($parameter)) {
                Write-Host 'Operation canceled' -ForegroundColor Red
                return
            }
        }
    }

    if (Test-Path $LagFilePath) {
        Remove-Item -Path $LagFilePath -Force
        Write-Host 'Removed .Lag file'

        [Path]::GetDirectoryName($LagFilePath) | Save-LagVariablesFile
    }
    else {
        Write-Host 'File .lag does not exist.' -ForegroundColor Red
        return
    }
}