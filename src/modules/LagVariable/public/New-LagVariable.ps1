function New-LagVariable {
    [CmdletBinding()]
    param(
        [Parameter(Mandatory, Position = 0)]
        [string]
        $key,

        [switch]
        $simples,

        [switch]
        $save
    )

    $result = @{}

    if ($LagVariablesTemp -and (($LagVariablesTemp | Where-Object { $_ -like $key }).Count -ne 0)) {
        Write-Host 'A variable with that name already exists.' -ForegroundColor Red
        return
    }
    
    do {
        if ($simples) {
            Write-Host 'Informe um Valor' -ForegroundColor DarkGray 
            $result = Read-Host

            if ($result -eq [string]::Empty) {
                Write-Host 'Operation Canceled' -ForegroundColor Red
                return
            }

            break
        }
        else {
            Write-Host 'Informe a Propriedade:' -ForegroundColor DarkGray
            $property = Read-Host

            if ($property -eq [string]::Empty) {
                Write-Host 'Process interrupted (Property)' -ForegroundColor DarkYellow
                break
            }

            Write-Output 'Informe um Valor:'
            $value = Read-Host

            if ($value -eq [string]::Empty) {
                Write-Host 'Process interrupted (Value)' -ForegroundColor DarkYellow
                break
            }

            # Adiciona Propriedade e valor
            $result.Add($property, $value)
        }
    } 
    while ($true)


    if ($result.Count -eq 0) {
        Write-Host 'Operation Canceled' -ForegroundColor Red
        return
    }


    $updateFile = $save -or $lagAutoSave
    
    if ($updateFile) {
        Write-Verbose 'Update file'
    }

    Add-LagVariable -Key $key -Value $result -UpdateFile:$updateFile
    Write-Host "Generated LagVariavel: $key" -ForegroundColor Green
}