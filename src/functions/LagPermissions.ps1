    function Set-FullControl-Permission() {
    param(
        [Parameter(Position=0, Mandatory)]
        [string]
        $file
    )

    if (-not(Test-Path $file)) {
        Write-Host "Arquivo não encontrado."
        return;
    }

    $user = "NDD-NOT-DEV464\nddraiz"
    $permission = "FullControl"
    
    try {
        $acl = Get-Acl $file
        $authorized = $acl.Access | Where-Object { $_.IdentityReference -eq $user }

        if (!$authorized) {
            $objUser = New-Object System.Security.Principal.NTAccount($user)
            $objUserSID = $objUser.Translate([System.Security.Principal.SecurityIdentifier])
        
            $regra = [System.Security.AccessControl.FileSystemAccessRule]::new($objUserSID, $permission, "Allow")
            $acl.AddAccessRule($regra)
        
            Set-Acl $file $acl
            Write-Host "Permissões aplicadas com sucesso."
        } else {
            Write-Host "O usuário já possui permissões no arquivo."
        }
    }
    catch {
        Write-Host "Ocorreu um erro inesperado. $_"
    }
}