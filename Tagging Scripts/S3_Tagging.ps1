<#
    This script will overwrite existing tags on the S3 buckets; if you're adding new tags,
    you will need to add the existing tags in addition to the new tags to have them all
    $bucketList can be a list of individually listed bucket names or it can be a list from a file.

#>

<#
    You can use this block if you have a handful of buckets
    that you can list out manually; uncomment before using
#>
$bucketList = "bucket01", "bucket02"


# use this block if you have a list in a txt file
#$bucketList = Get-Content -Path "C:\Temp\S3buckets.txt"

$Time = Get-Date

#Location of Logs - aftermath
$Logs = "C:\Temp\S3-Tag-logs.txt"

foreach ($bucket in $bucketList) {

    #To obtain the Bucket Names for logging purpose
    $s3 = Get-S3Bucket -BucketName $bucket

    #To obtain Bucket Old Tags info
    $oldTags = Get-S3BucketTagging -BucketName $bucket
    
       
    Write-Output $Time $s3.BucketName ($oldTags | Format-Table) | Out-File -FilePath $Logs -Append
    
    Write-S3BucketTagging -BucketName $bucket -TagSet @( @{ Key=”Key1”; Value=”Value1” },
                                                         @{ Key=”Key2”; Value=”Value2” } )   
    
}