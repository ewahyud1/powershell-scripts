
<# 
    ***Require the EMR resource ID instead of their Names
    Compile the list of Resource IDs and place them in the txt file
 #>
$EMRList = get-content -Path "C:\temp\EMRlist.txt"

$Time = Get-Date

#Location of Logs to log the old tags for historical reference
#This location and log file name can be different
$Logs = "C:\Temp\EMR-Tag-logs.txt"

foreach ($EMR in $EMRList) {

    #To obtain EMR Old Tags info and Name
    $oldTags = aws emr describe-cluster --cluster-id $EMR --query Cluster.Tags
    $EMRName = aws emr describe-cluster --cluster-id $EMR --query Cluster.Name
           
    Write-Output $Time $EMRName ($oldTags | Format-Table) | Out-File -FilePath $Logs -Append
    
    #add more tags as needed with this cmdlet @{ Key=”org”; Value=”” }, modify Key/Value pair as necessary
    Add-EMRResourceTag -ResourceId $EMR -Region us-east-1 -Tag @( @{ Key=”Key1”; Value=”Value1” },
                                                                  @{ Key=”Key2”; Value=”Value2” } )

    # You can issue this command to remove particular tag keys; uncomment to use it
    # Remove-EMRResourceTag -ResourceId $EMR -Region us-east-1 -TagKey "Cost Center"
}

