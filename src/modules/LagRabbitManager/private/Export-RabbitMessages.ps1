function Export-RabbitMessages () {
    [CmdletBinding()]
    param (
        [Parameter()]
        [string]
        $pathLocation = (Get-Location),

        [Parameter(Mandatory)]
        [Message[]]
        $messages
    )

    if (-not (Test-Path $pathLocation)) {
        Write-Host 'Path invalid' -ForegroundColor Red
    }

    $path = Join-Path -Path $pathLocation -ChildPath "Messages_$(New-Guid)"

    New-Item -ItemType Directory $path | Out-Null
    
    foreach ($message in $messages) {
        $fileName = "$($message.Position)_$($message.Queue).xml"
        $filePath = Join-Path -Path $path -ChildPath $fileName

        New-Item -ItemType File $filePath -Value $message.Payload | Out-Null
    }

    Write-Host "Exported messages! Directory: $path"
}