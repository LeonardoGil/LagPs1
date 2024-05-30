using module .\MobileSession.ps1

class MoveSession { 
    static [string]$variableName = 'moveSession'

    [String]$Ambiente
    [System.Uri]$url

    [MobileSession]$Mobile

    static [MoveSession] Get() {
        return Get-Variable -Name ([MoveSession]::variableName) -Scope Global -ValueOnly -ErrorAction SilentlyContinue
    }

    MoveSession() {
        $this.Mobile = [MobileSession]::new()
    }
}