function Set-LagAzIp {
    
    [CmdletBinding()]
    param (
        [Parameter(Mandatory)]
        [string]
        $ruleName,

        [Parameter(Mandatory)]
        [string]
        $ip,

        [Parameter()]
        [string]
        $resourceGroupName,
        
        [Parameter()]
        [string]
        $nsgName,

        [Parameter()]
        [Guid]
        $subscriptionId
    )

    $ErrorActionPreference = 'Stop'

    if ($subscriptionId -ne [Guid]::Empty) {
        Connect-AzAccount -Subscription $subscriptionId | Out-Null
    }

    Get-AzNetworkSecurityGroup | 
        Where-Object { [string]::IsNullOrEmpty($nsgName) -or $_.Name -eq $nsgName } | 
        Set-LagAzNetworkSecurityGroupIp -ruleName $ruleName -ip $ip
}

function Set-LagAzNetworkSecurityGroupIp {
    
    [CmdletBinding()]
    param (
        [Parameter(Mandatory, ValueFromPipeline)]
        [Microsoft.Azure.Commands.Network.Models.PSNetworkSecurityGroup]
        $nsg,

        [Parameter(Mandatory)]
        [string]
        $ruleName,

        [Parameter(Mandatory)]
        [string]
        $ip
    )

    process {
        $rule = $nsg.SecurityRules | Where-Object { $_.Name -eq $ruleName }
        
        if ($rule) {
            
            $list = New-Object System.Collections.Generic.List[string]
            $list.Add($ip)
            $rule.SourceAddressPrefix = $list

            Set-AzNetworkSecurityGroup -NetworkSecurityGroup $nsg | Out-Null
            Write-Host "Regra de segurança atualizada com o novo IP: $ip"
        }
        else {
            Write-Host "Regra $ruleName não encontrada!" -ForegroundColor DarkYellow
        }
    }
}