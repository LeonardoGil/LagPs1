function Set-ProjectWithoutOutput {

    [CmdletBinding()]
    param (
        [Parameter()]
        [string]
        $path = (Get-Location)
    )

    $projects =  Get-ChildItem -Path * -Filter '*BaseProcessor.csproj' -Recurse

    foreach ($project in $projects) {
        $fullName = $project.FullName

        $xml = [xml](Get-Content $fullName)

        $outTypeNode = $xml.CreateElement('OutputType')
        $outTypeNode.InnerText = 'WinExe'

        $propertyGroupNode = $xml.SelectNodes("Project/PropertyGroup")
        $propertyGroupNode.AppendChild($outTypeNode)

        $xml.Save($fullName)
    }

    Write-Host 'Updated projects' -ForegroundColor DarkGreen
}