function Get-RabbitOverview() {
    Invoke-RestMethod -Uri "${rabbitUrl}/api/overview" -Headers $credential -Method Get;   
} 