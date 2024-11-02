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