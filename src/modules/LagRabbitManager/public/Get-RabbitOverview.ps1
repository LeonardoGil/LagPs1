function Get-RabbitOverview() {
    Invoke-RestMethod -Uri "$($Credential.Url)/api/overview" -Header $credential.GetHeader() -Method Get;   
} 