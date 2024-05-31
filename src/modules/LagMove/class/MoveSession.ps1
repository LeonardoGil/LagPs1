class MoveSession { 
    static [string] $variableName = 'moveSession'

    [String] $Ambiente
    [System.Uri] $Url

    [MobileSession] $Mobile
    [DatabaseSession] $Database

    static [MoveSession] Get() {
        return Get-Variable -Name ([MoveSession]::variableName) -Scope Global -ValueOnly -ErrorAction SilentlyContinue
    }

    MoveSession() {
        $this.Mobile = [MobileSession]::new()
        $this.Database = [DatabaseSession]::new()
    }
}