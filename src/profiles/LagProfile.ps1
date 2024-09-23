$psProjectPath = 'C:\Projetos\LagPs1\src'

$lagVerbose = $false

# Local Modules 
Import-Module -Name "$psProjectPath\modules\LagVariable\LagVariable.psm1" -Verbose:$lagVerbose
Import-Module -Name "$psProjectPath\modules\LagRegistroNacional\LagRegistroNacional.psm1" -Verbose:$lagVerbose
Import-Module -Name "$psProjectPath\modules\LagRabbitManager\LagRabbitManager.psm1" -Verbose:$lagVerbose
Import-Module -Name "$psProjectPath\modules\LagSQL\LagSQL.psm1" -Verbose:$lagVerbose

# Third-Party Modules
Import-Module -Name Terminal-Icons

# PSReadLine Keys
Set-PSReadlineKeyHandler -Key Tab -Function MenuComplete
Set-PSReadLineKeyHandler -Key UpArrow -Function HistorySearchBackward
Set-PSReadLineKeyHandler -Key DownArrow -Function HistorySearchForward

# PSReadLine Options
Set-PSReadlineOption -HistorySearchCursorMovesToEnd
Set-PSReadlineOption -ShowToolTips
Set-PSReadlineOption -BellStyle None  # Desabilita campainha
Set-PSReadLineOption -HistorySavePath "C:\Temp\$($Host.Name)_history.txt"

function Initialize-Lag {
    # Load the lag Variables for session
    Push-LagVariablesFile
    
    # Load Theme of Oh-my-Posh
    # oh-my-posh init pwsh --config "C:\Projetos\MyThemesOnOhMyPosh\godShell.omp.json" | Invoke-Expression
    
    Write-Host "Terminal ON FIREEE" -ForegroundColor Red
    Write-Output "Bem vindo a base de controle."
}

Initialize-Lag

# Alias
New-Alias -Name 'ex' -Value explorer
New-Alias -Name 'st' -Value Set-Title
New-Alias -Name 'sm' -Value Set-Max

function Set-Title {
    [CmdletBinding()]
    param (
        [Parameter(ValueFromPipeline = $true)]
        [string]
        $title
    )

    $Host.UI.RawUI.WindowTitle = $title
}

function Set-Max {

    $user32cs = @"

using System;
using System.Runtime.InteropServices;

public class User32 {    
    [DllImport("user32.dll", SetLastError = true)]
    [return: MarshalAs(UnmanagedType.Bool)]
    public static extern bool ShowWindow(IntPtr hWnd, int nCmdShow);
    
    [DllImport("user32.dll", SetLastError = true)]
    public static extern IntPtr GetForegroundWindow();
}

"@

    Add-Type $user32cs

    $SW_MAXIMIZE = 3
    $hwnd = [User32]::GetForegroundWindow() 

    [User32]::ShowWindow($hwnd, $SW_MAXIMIZE)
}