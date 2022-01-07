
Set-AWSCredential -AccessKey "" `
                  -SecretKey "" `
                  -SessionToken ""


<# This is what HashTable looks like !!!
$tags = @{
     key1 = "value1"
     key2 = "value2"
}
#>

#Compile the list of CW Log Group names
$CompiledLogs = get-content -Path "C:\...\logs.txt"
    
foreach ($log in $CompiledLogs) {

  Write-Host $log -ForegroundColor DarkYellow
  
                                                        # Tags uses HashTable format
  Add-CWLLogGroupTag -LogGroupName log_group_name -Region us-east-1 -Tag @{
                                                                        key1 = "value1"
                                                                        key2 = "value2"
                                                                        keyN = "valueN"
                                                                       }
  
  #Verify each Log Group now has the necessary tags
  Get-CWLLogGroupTag -LogGroupName log_group_name -Region us-east-1
}