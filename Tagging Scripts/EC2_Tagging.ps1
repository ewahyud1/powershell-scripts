<#
   This script will require a list of EC2 instance IDs.
   Will not accpet instance names. It will add
   single tag (Key/Value pair) at a time.
#>


param(
    [Parameter(Mandatory=$true)][string]$instanceID,
    [Parameter(Mandatory=$true)][string]$tagKey,
    [Parameter(Mandatory=$true)][string]$tagValue
) 

# Import the list of instances compiled in a .csv file
# you'd have to include the file path as well (eg.) C:\temp\EC2list.csv
# Ensure that there are no trailing spaces in the instance IDs and you'd have to 

$ec2Array = Get-Content -Path $instanceID

foreach ($ec2 in $ec2Array) {

    #create tag object and assign the tagkey and tagvalue params to the object
    $ec2tag = New-Object Amazon.EC2.Model.Tag
    $ec2tag.Key = $tagKey
    $ec2tag.Value = $tagValue

    Write-host "looking up instanceID $ec2"

    #logs all instances that were tagged, new tags and old tags
    Add-Content -Path "C:\\\\temp\\\\EC2_list.txt" -Value "$(Get-Date): Adding tag to instance $($ec2) with tag key: $($ec2tag.Key) and tag value: $($ec2tag.Value)."

    #Added/updated with new tags
    New-EC2Tag -Resource $ec2 -Tag $ec2tag -Region us-east-1
}