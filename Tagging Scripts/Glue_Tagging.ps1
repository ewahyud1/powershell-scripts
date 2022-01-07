<#
    AWS Glue Tagging Script
    Compile the list of crawlers' names into a simple txt file
    ensure there is NO trailing spaces before/after each name.
#>

$crawlers = get-content -Path "C:\temp\Glue_list.txt"

#Use the cmd below to list/hard code the crawlers manually
#$crawlers = "Test_OECD", "Test_Weather"

$logs = "C:\temp\Glue_Logs.txt"

#Pre-built ARN prefix, update the acctNumber with the AWS Acct#
# You can tag deVEndpoint, Job, Trigger and mlTransform; replace crawler with the resource type
# use this arn:aws:glue:us-east-1:<acct#>:devEndpoint/<endpont_name> for devEnpoint
$ARNPrefix = "arn:aws:glue:us-east-1:<acct#>:job/<job_name>"

$time = Get-Date

foreach($crawler in $crawlers) {
    
    #ARN for each Glue Crawler
    $glue = $ARNPrefix+$crawler

    #Querying crawlers names for historical logging
    $history = aws glue get-tags --resource-arn $glue    
    
    #Logging historical/existing tags includes the timestamp, name of crawler and existing tags
    Write-Output $time $crawler $history | Out-File -FilePath $logs -Append
    
    #Add tag(s) to the respective crawler
    Add-GLUEResourceTag `
        -ResourceArn $glue `
        -TagsToAdd @{ 
                        key1 = "value1"
                        key2 = "value2"
                    }    
}

# Use the following cmd to remove tag(s); ensure you specify the acctNumber and crawlerName; and uncomment
#aws glue untag-resource --resource-arn arn:aws:glue:us-east-1:<acctNumber>:crawler/<crawlerName> --tags-to-remove "tagkey1" "tagKey2" "tagKey3"
