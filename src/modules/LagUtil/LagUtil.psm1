using namespace System.IO
using namespace System

$scriptsPath = [Path]::Combine($PSScriptRoot, '*')

Get-ChildItem -Path $scriptsPath -Filter '*.ps1' -Recurse | 
    Select-Object -ExpandProperty FullName | 
        ForEach-Object { Import-Module -Name $_ }

New-Alias -Name 'st' -Value Set-Title
New-Alias -Name 'sm' -Value Set-Max
New-Alias -Name 'ilag' -Value Import-LagModule