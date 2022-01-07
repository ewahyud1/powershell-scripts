<#
    This script adds/removes tags from Elastic File System
    You will need to compile the list of EFS FileSystem ID
#>

# Compile the list of EFS (File System ID) here
$EFSList = get-content -Path "C:\temp\EFSList.txt"

# Logs file created to log existing tags on EFS
$Logs = "C:\temp\EFS_Logs.txt"

$time = Get-Date

foreach ($efs in $EFSList) {

    #Query existing tags on EFS
    $oldTags = Get-EFSTag -FileSystemId $efs -Region us-east-1

    #Logs existing tags on EFS
    Write-Output $time $efs($oldTags | Format-Table)| Out-File -FilePath $Logs -Append

    #Adds new tags to EFS resource(s); you can add more than 1 tag  -Key/Value at a time
    New-EFSTag -FileSystemId $efs -Tag @( @{ Key=”Key1”; Value=”Value1” }, `
                                          @{ Key=”Key2”; Value=”Value2” } ) `
                                  -Region us-east-1

    #This command removes tags from the EFS resources; uncomment to use
    #Remove-EFSTag -FileSystemId $efs -TagKey Key1, Key2 -Region us-east-1
}