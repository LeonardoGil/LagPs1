$Host.UI.RawUI.BufferSize = $Host.UI.RawUI.WindowSize

$strings = @(
    "Password",
    "Thread",
    "User",
    "Coding",
    "Debbug",
    "Writting",
    "Analysis",
    "Compiler",
    "Framework",
    "Algorithm",
    "Function",
    "Runtime",
    "Parameter",
    "Inheritance",
    "Library",
    "Module",
    "Package"
)

$exec = @()

for ($i = 0; $i -lt 900; $i++) {

    $randomString = Get-Random -Minimum 0 -Maximum ($strings.Count - 1)
    $randomColumn = Get-Random -Minimum 1 -Maximum ($Host.UI.RawUI.BufferSize.Width -1)

    if ($strings[$randomString] -notcontains ($exec | Select-Object -Property string)) {
        if ($randomColumn -notcontains ($exec | Select-Object -Property column)) {
            if ((Get-Random -Minimum 0 -Maximum 9) -le 8) {
                $item = [PSCustomObject]@{
                    column = $randomColumn
                    position = 0
                    string = $strings[$randomString]
                }
                $exec += $item
            }
        }
    }

    $exec = @($exec | Where-Object { $_.position -ne $_.string.Length } | Sort-Object column) 

    $result = ''

    foreach ($obj in $exec) {

        $spaces = $obj.column - $result.Length

        if ($spaces -gt 0) {
            for ($f = 0; $f -lt $spaces; $f++) {
                $result += ' '
            }
        }

        $result += $obj.string[$obj.position]
        $obj.position += 1
    }
    Write-Output $result
    Start-Sleep -Milliseconds 15
} 