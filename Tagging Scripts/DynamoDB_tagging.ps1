<#
    This script tags DynamoDB tables.
    You will need to compile the list of table names (not ARN)
    into a .txt file

    #1. Specify the compiled list (in txt) path
    #2. Ensure to specify the AWS account number <acctNumber>
#>

#1. Specify the compiled list (txt file) in the Path
$DBTableList = get-content -Path "C:\temp\DBTable_List.txt"

# Used for timestamp
$time = get-date

#2. Pre-built the Amazon Resource Name for DynamoDB table, update the <acctNumber> b4 running
$ARNPrefix = "arn:aws:dynamodb:us-east-1:<acct#>:table/"

# Location of log file, update as necessary
$Logs = "C:\temp\DynamoDB_Logs.txt"

foreach ($Table in $DBTableList){

    # Building the full ARN for each DynamoDB Table to be tagged
    $DBTableARN = $ARNPrefix+$Table

    # Query each DB Table existing tag for logging information
    $HistoricalData = Get-DDBResourceTag -ResourceArn $DBTableARN -Region us-east-1
       
    # Logging; include DBTable name($Table), timestamp($time), existing tags($HistoricalData)
    Write-Output $Table $time $HistoricalData | Out-File -FilePath $Logs -Append

    # Adding the tag(s) to respective DB Table; you can add more than 1 tag at a time
    Add-DDBResourceTag -ResourceArn $DBTableARN `
                       -Tag @( @{ Key=”Key01”; Value=”Value01” },
                               @{ Key=”Key02”; Value=”Value02” })

}
    # Use this command to delete existing tag(s); to delete multiple tags, separate -TagKey with commas
    # update the <acctNumber> and <table_name>
    <# 
        Remove-DDBResourceTag -ResourceArn arn:aws:dynamodb:us-east-1:<acctNumber>:table/<table_name> `
                              -TagKey Key01, Key02
    #>
