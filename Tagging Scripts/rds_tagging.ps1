
<# 
   This script add/edit/remove tags on RDS instance resources.
   To edit, add the same tag key with different values as it overwrites the existing tag(s).
#>

#compile the list of RDS DB Instance Names
$RDSclusters = get-content -Path "C:\...\rdslist.txt"

$Time = Get-Date

#Location of Logs - this will be created when the script runs 
#to log old tags for histrocial reference.
$Logs = "C:\Temp\rds-logs.txt"

# Change the account number as necessary before running the script
$ARNPrefix = "arn:aws:rds:us-east-1:<acctNumber>:db:"

foreach ($cluster in $RDSclusters) {

    #Building the Full DB ARN
    $DB = $ARNPrefix+$cluster

    #To obtain RDS Instance Old(existing) Tags info for historical log
    $oldTags = Get-RDSTagForResource -ResourceName $DB -Region us-east-1
              
    Write-Output $Time"`n"$cluster $oldTags | Out-File -FilePath $Logs -Append
    
    #Tags that will be added to the RDS Instances
    Add-RDSTagsToResource -ResourceName $DB -Region us-east-1 -Tag @( @{ Key="Key1";Value="Value1" },
                                                                      @{ Key="Key2";Value="Value2" } )
                                      
}
    
    <#
    This command deletes any tag(s) listed in the -Tagkey parameter
    Remove-RDSTagFromResource -ResourceName $DB -Region us-east-1 -Tagkey "Key1",
                                                                          "Key2"
    #>                                                                                                                        