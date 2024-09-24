function Set-AzureIp {
    
    [CmdletBinding()]
    param (
        [Parameter(Mandatory)]
        [string]
        $resourceGroupName,
        
        [Parameter(Mandatory)]
        [string]
        $nsgName,

        [Parameter(Mandatory)]
        [string]
        $ruleName,

        [Parameter(Mandatory)]
        [string]
        $ip,

        [Parameter()]
        [Guid]
        $subscriptionId
    )

    $ErrorActionPreference = 'Stop'

    if ($null -eq $subscriptionId -or $subscriptionId -eq [Guid]::Empty) {
        Connect-AzAccount | Out-Null
    }
    else {
        Connect-AzAccount -Subscription $subscriptionId | Out-Null
    }

    $nsg = Get-AzNetworkSecurityGroup -ResourceGroupName $resourceGroupName -Name $nsgName

    $rule = $nsg.SecurityRules | Where-Object { $_.Name -eq $ruleName }

    if ($rule) {
        
        $list = New-Object System.Collections.Generic.List[string]
        $list.Add($ip)

        $rule.SourceAddressPrefix = $list
        Set-AzNetworkSecurityGroup -NetworkSecurityGroup $nsg | Out-Null
        
        Write-Output "Regra de segurança atualizada com o novo IP: $ip"
    }
}