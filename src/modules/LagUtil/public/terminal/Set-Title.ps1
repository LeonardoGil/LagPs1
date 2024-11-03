function Set-Title {
    [CmdletBinding()]
    param (
        [Parameter(ValueFromPipeline = $true)]
        [string]
        $title
    )

    $Host.UI.RawUI.WindowTitle = $title
}