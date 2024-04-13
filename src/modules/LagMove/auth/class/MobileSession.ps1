class MobileSession {
    
    static [string]$variableName = 'MobileSession'

    [string]$motorista
    [string]$cpf
    [string]$password

    [string]$clientId = '3b9a77fb35a54e40815f4fa8641234c5'

    [System.Uri]$api
    [System.Uri]$auth

    static [MobileSession] Get() {
        return Get-Variable -Name ([MobileSession]::variableName) -Scope Global -ValueOnly -ErrorAction SilentlyContinue
    }
}