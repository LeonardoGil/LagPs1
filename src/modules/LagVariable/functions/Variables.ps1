function Add-LagVariable {
<#
    .Synopsis
       Adiciona a Variavel no contexto Global
    .DESCRIPTION
       Adiciona PSCustomObject como Variavel no Contexto Global
    .EXAMPLE
       Add-LagVariable 'Projetos' 'C:\Projetos' 
#>

    [CmdletBinding()]
    param (
        # Nome da Variavel
        [Parameter(Mandatory, Position = 0)]
        [string]
        $Key,

        # Valor da Variavel
        [Parameter(Mandatory, Position = 1)]
        [System.Object]
        $Value,

        [Parameter()]
        [switch]
        $UpdateFile
    )

    $ErrorActionPreference = 'Stop'

    try {
        Write-Verbose "Adding variable: $key"
        New-Variable -Name $Key -Value $Value -Scope Global
        
        # Grava o nome da Variavel numa lista temporaria
        Push-LagVariablesTemp $Key

        if ($UpdateFile) {

            if ($null -eq $LagFilePath) {
                Write-Host '$LagFilePath is not defined.' -ForegroundColor Red
                return;
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
    }
    catch [System.Exception] {
        Write-Host 'An unexpected error occurred.' -ForegroundColor Red
        throw $_
    }
}

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

function Push-LagVariablesTemp {
<#
    .Synopsis
       Adiciona o nome da Variavel Lag numa lista temporária
    .DESCRIPTION
       Adiciona o nome da Variavel Lag na lista: LagVariablesTemp
       Será criado uma nova lista caso a Variavel não exista
    .EXAMPLE
       Push-LagVariablesTemp 'Teste'
#>

    [CmdletBinding()]
    param(
        [Parameter(Mandatory, Position = 0)]
        [string]
        $variableName
    )

    try {
        # Busca $LagVariablesTemp
        $variablesTemp = Get-Variable -Name 'LagVariablesTemp' -ErrorAction SilentlyContinue
        
        # Adiciona o nome da variavel a lista: $LagVariablesTemp
        $variablesTemp.Value += $variableName
 
        # Atualiza $LagVariablesTemp
        Set-Variable -Name 'LagVariablesTemp' -Value $variablesTemp.Value -Scope Global
        
        Write-Verbose "Updated LagVariablesTemp with $variableName"
    }
    catch [System.Exception] {
        New-Variable -Name 'LagVariablesTemp' -Value @($variableName) -Scope Global

        Write-Verbose 'Generated LagVariablesTemp'
    }
}