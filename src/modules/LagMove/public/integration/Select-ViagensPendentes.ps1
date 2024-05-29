function Select-ViagensPendentes {
    [CmdletBinding()]
    param (

    )
    
    $viagens = Select-MoveDatabase "SELECT * FROM core.Viagens WHERE StatusViagem = 0"

    return $viagens | Select-Object -Property @{ Name = 'Index'; Expression = { [Array]::IndexOf($viagens, $_) } }, Id, NumeroMDFe, NumeroManifesto
}