function Set-LagVariable {

    [CmdletBinding()]
    param (
        [Parameter(Mandatory, Position=0)]
        [string]
        $key,

        [Parameter()]
        [string]
        $parameter,

        [Parameter(Mandatory)]
        [string]
        $value
    )

    $ErrorActionPreference = 'Stop'
    $variableValue = $null

    try {
        $variableValue = (Get-Variable -Name $key -ErrorAction 'Stop').Value
        Write-Verbose "Variable found; Value: $variableValue"
    }
    catch {
        Write-Host "Key ($key) not found." -ForegroundColor Red
        return
    }

    if ($variableValue -is [string]) {
        Write-Verbose 'Variable is String'

        Write-Verbose "Will be replaced from $variableValue to $value"
        $variableValue = $value
    }
    elseif ($variableValue -is [PSCustomObject]) {
        Write-Verbose 'Variable is Object'

        if ([string]::IsNullOrEmpty($parameter)) {
            Write-Host 'Please specify the property you want to change' -ForegroundColor DarkYellow
            $parameter = Read-Host

            if ([string]::IsNullOrEmpty($parameter)) {
                Write-Host 'Operation canceled' -ForegroundColor Red
                return
            }
        }

        $properyInfo = $variableValue.psobject.Properties | Where-Object { $_.Name -like $parameter }
        
        Write-Verbose "Will be replaced from $($properyInfo.Value) to $value"
        $properyInfo.Value = $value
    }
    else {
        Write-Host 'Unsupported variable type' -ForegroundColor Red
        return
    }

    Set-Variable -Name $key -Value $variableValue -Scope Global

    # Atualiza o arquivo .Lag
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