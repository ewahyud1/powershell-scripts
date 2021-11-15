# Set AD Group Name
$ADGrpName = "Active Directory Group Name"

# Set domain FQDN here
$domain = "domain FQDN"

# Ensure the correct domain name is set in the -Path
$NewADGrp = New-ADGroup -Name $ADGrpName -Server $domain `
                        -SamAccountName $ADGrpName `
                        -Description "Description field in AD Window" `
                        -Path "OU=OU,OU=AWS,OU=Groups,OU=Cloud,DC=DC,DC=DC,DC=com" `
                        -GroupScope Universal ` 
                        -GroupCategory Security `
                        -ManagedBy username

# Add to the Notes field in ADGroup - Notes will differ for each account
Set-ADGroup -Identity $ADGrpName -Replace @{info=" 'Notes' field in AD Group window"} -Server $domain
                        

#Add members (samAccountName) to the newly created AD Group
$members = "user1", "user2", "user3"

#This FOR loop will add all of the above users into the AD group as members
foreach ($member in $members){
    
    Add-ADGroupMember -Identity $ADGrpName -Members $member -Server $domain

}