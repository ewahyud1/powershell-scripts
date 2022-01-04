
<# Optional to use this block; this can be used if you have an IAM role that you can assume
Set-AWSCredential -AccessKey "" `
                  -SecretKey "" `
                  -SessionToken ""
#>
# Compile the list of IAM roles; uncomment to use, *be sure to comment line #10
#$roleName = get-content -path "C:\<path_to>\Roles.txt"

#Manually specifying/hardcoding the role name(s); add/remove as needed
$roleName = "role_01", "role_02"

foreach ($role in $roleName) {
    
    # Get all Inline Policies of a Role
    $inline = Get-IAMRolePolicies -RoleName $role
    
    # After gathering all inline policies, delete them from the respective IAM role
    foreach ($policy in $inline) {
        
        Write-Host "Deleting Inline Policies " + $inline + " from" $role -ForegroundColor Cyan
        Remove-IAMRolePolicy -RoleName $role -PolicyName $policy -Force           
    }

    # This example finds all of the managed policies that are attached to the IAM role and detaches them from the role.
    Write-Host "Detaching Managed Policies from" $role -ForegroundColor Green
    Get-IAMAttachedRolePolicyList -RoleName $role | Unregister-IAMRolePolicy -Rolename $role -Force
    
    # Detaches roles from the Instance Profile & then deletes the Instance Profile
    Write-Host "Removing Instance Profile " $role 
    (Get-IAMInstanceProfile -InstanceProfileName $role).Roles | Remove-IAMRoleFromInstanceProfile -InstanceProfileName $role -Force
    Remove-IAMInstanceProfile -InstanceProfileName $role -Force

    # This command deletes the IAM role; after inline/managed policies are detached
    Write-Host "Deleting IAM Role" $role `n
    Remove-IAMRole -RoleName $role -Force
}
