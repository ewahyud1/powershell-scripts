 <#
    This script remediate Kinesis stream tags base on the stream names
    Adding tags does not overwrite existing tags
 #>

# compile a list of Kinesis streams names into a txt file; no trailing spaces
$StreamList = get-content -Path "C:\temp\StreamList.txt"

$Time = Get-Date

#Location of log files for historical data
$Logs = "C:\temp\Kinesis_logs.txt"

foreach ($stream in $StreamList) {

     # List Kinesis existing Tags
     $oldTags = aws kinesis list-tags-for-stream --stream-name $stream

     #Logs existing tags before adding/deleting
     Write-Output $Time "Resource Name:" $stream "`nOld Tags:"$oldTags | Out-File -FilePath $Logs -Append
     
     # Add tag(s) to Kinesis. (eg.) TagKey=TageValue - blc=1460
     # can add multiple tags (up to 10 pairs at once), separate with commas
     aws kinesis add-tags-to-stream --stream-name $stream --tags Key1=Value1,Key2=Value2

     # Remove tag(s) to Kinesis - uncomment to use cmd
     #aws kinesis remove-tags-from-stream --stream-name $stream --tag-keys env


 }