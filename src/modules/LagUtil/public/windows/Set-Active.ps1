function Set-Active {

    [CmdletBinding()]
    param (
        [Parameter(Position=0)]
        [Nullable[Timespan]]
        $timer = ([Timespan]::FromHours(2))
    )

    Add-Type -TypeDefinition @"
using System;
using System.Runtime.InteropServices;

public class Keyboard
{
    [DllImport("user32.dll", CharSet = CharSet.Auto, ExactSpelling = true)]
    public static extern void keybd_event(byte bVk, byte bScan, int dwFlags, int dwExtraInfo);

    public const int KEYEVENTF_KEYDOWN = 0x0000;
    public const int KEYEVENTF_KEYUP = 0x0002;  
    public const byte VK_SCROLL = 0x91;         

    public static void PressScrollLock()
    {
        keybd_event(VK_SCROLL, 0, KEYEVENTF_KEYDOWN, 0);
        keybd_event(VK_SCROLL, 0, KEYEVENTF_KEYUP, 0);
    }
}
"@

    $temp = New-TimeSpan
    $sleep = 30

    do
    {
        [Keyboard]::PressScrollLock()

        Start-Sleep -Seconds $sleep
        
        if ($null -ne $timer) {

            $temp = $temp.Add([timespan]::FromSeconds($sleep))
        }

    } while ($null -eq $timer -or $timer -ge $temp)
}