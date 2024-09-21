$Host.UI.RawUI.BufferSize = $Host.UI.RawUI.WindowSize

$strings = @(
    "Arrou",
    "Selou",
    "Naruto",
    "Falencia",
    "Cruel",
    "Ogroo",
    "Moreia",
    "Intelectual",
    "Anaconda",
    "Trampolim",
    "Viet",
    "Golias",
    "Padre"
)

$exec = @()

for ($i = 0; $i -lt 100; $i++) {

    $randomString = Get-Random -Minimum 0 -Maximum ($strings.Count - 1)
    $randomColumn = Get-Random -Minimum 1 -Maximum ($Host.UI.RawUI.BufferSize.Width / 2)

    if ($strings[$randomString] -notcontains ($exec | Select-Object -Property string)) {
        if ($randomColumn -notcontains ($exec | Select-Object -Property column)) {
            $item = [PSCustomObject]@{
                column = $randomColumn
                position = 0
                string = $strings[$randomString]
            }
            $exec += $item
        }
    }

    $result = ''

    $exec = @($exec | Where-Object { $_.position -ne ($_.string.Length -1) } | Sort-Object column) 

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
    Start-Sleep -Milliseconds 30
} 