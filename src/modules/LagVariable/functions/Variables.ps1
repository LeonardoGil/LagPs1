function Add-LagVariable {
<#
    .Synopsis
       Adiciona a Variavel no contexto Global
    .DESCRIPTION
       Adiciona PSCustomObject como Variavel no Contexto Global
    .EXAMPLE
       Add-LagVariable 'Projetos' 'C:\Projetos' }
#>

    param (
        # Nome da Variavel
        [Parameter(Mandatory, Position=0)]
        [string]
        $Key,

        # Valor da Variavel
        [Parameter(Mandatory, Position=1)]
        [System.Object]
        $Value,

        [Parameter()]
        [switch]
        $UpdateFile
    )

    try {
        Write-Verbose "Add Variable: $key";
        New-Variable -Name $Key -Value $Value -Scope Global;
        
        # Grava o nome da Variavel numa lista temporaria
        Push-LagVariablesTemp $Key;

        if ($UpdateFile -and (Test-Path $LagFilePath)) 
        {
            Remove-Item -Path $LagFilePath -Force;

            [Path]::GetDirectoryName($LagFilePath) | Save-LagVariablesFile
        }
    }
    catch [System.Exception] {
        Write-Host 'Ocorreu um erro inesperado!' -ForegroundColor Red
        Write-Output $_.Exception.Message;
    }
}

function New-LagVariable {
    param(
        [Parameter(Mandatory, Position=0)]
        [string]
        $name
    )

    $key = [string]::Empty
    $value = [string]::Empty
    
    $variable = @{}
    $continue = $true

    if ($LagVariablesTemp -and (($LagVariablesTemp | Where-Object { $_ -like 'teste' }).Count -ne 0)) {
        Write-Output 'Ja possui uma variavel com esse nome'
        return;
    }
    
    do {
        Write-Output 'Informe a Propriedade'
        $key = Read-Host

        if ($key -eq [string]::Empty) {
            Write-Output 'Processo interrompido (Key)'
            $continue = $false
        }
        else {
            Write-Output 'Informe o Valor'
            $value = Read-Host

            if ($value -eq [string]::Empty) {
                Write-Output 'Processo interrompido (Valor)'
                $continue = $false
            }
            else {
                # Adiciona Propriedade e valor
                $variable.Add($key, $value)
            }
        }
    } while ($continue)

    if ($variable.Count -eq 0) {
        Write-Host 'Evento cancelado'
        return
    }

    Add-LagVariable -Key $name -Value $variable
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

    param(
        [Parameter(Mandatory, Position=0)]
        [string]
        $variableName
    )

    try {
        $variablesTemp = Get-Variable -Name 'LagVariablesTemp' -ErrorAction SilentlyContinue;
        $variablesTemp.Value += $variableName;

        Write-Verbose 'Update LagVariablesTemp'
        Set-Variable -Name 'LagVariablesTemp' -Value $variablesTemp.Value -Scope Global;
    }
    catch [System.Exception] {
        Write-Verbose 'Add LagVariablesTemp'
        new-Variable -Name 'LagVariablesTemp' -Value @($variableName) -Scope Global;
    }
}