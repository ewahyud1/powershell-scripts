<#

# Set the AWS Creds as needed - uncomment this block to use
Set-AWSCredential -AccessKey "" `
                  -SecretKey "" `
                  -SessionToken ""
#>


#Compile a list of IAM roles
$roles = Get-Content -Path "C:\temp\IAMRoles.txt"

#Tags multiple IAM roles with the same Tag Key/Value pairs
foreach ($role in $roles) {

    Add-IAMRoleTag -RoleName $role -Tag @( @{ Key=”Key1”; Value=”Value1” },
                                           @{ Key=”Key2”; Value=”Value2” },
                                           @{ Key=”Key3”; Value=”Value3” } )   

}

<#
    #Tag individual IAM Role
    Add-IAMRoleTag -RoleName Role_Name -Tag @( @{ Key = 'Key1'; Value = 'Value1'},
                                               @{ Key = 'Key2'; Value = 'Value2'},
                                               @{ Key = 'Key3'; Value = 'Value3'} )
#>