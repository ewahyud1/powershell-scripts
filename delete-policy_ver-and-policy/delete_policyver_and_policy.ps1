
Set-AWSCredential -AccessKey "" `
                  -SecretKey "" `
                  -SessionToken ""


#Get the list of IAM POlicies
$PolicyList = get-content -Path "C:\<path_to>\Orphaned_Policies.txt"

#Logs the policies that will be deleted
$LogLocation = "C:\<path_to>\Policy.txt"

foreach ($Policy in $PolicyList) {
        
        #ARN - Update the AWS Account Number before running
        $ARN = "arn:aws:iam::<acct_number>:policy/"

        $PolicyARN = $ARN+$Policy

        # Get all Versions of Policy
        #$pol = Get-IAMPolicy -PolicyArn $PolicyARN

        #Deleting All versions of Policy before the policy can be deleted
        Get-IAMPolicyVersions -PolicyArn $PolicyARN | where {-not $_.IsDefaultVersion} | Remove-IAMPolicyVersion -PolicyArn $PolicyARN -force -ErrorAction SilentlyContinue
        
        Write-Host "Deleting IAM Policy: " $Policy -ForegroundColor Cyan
        $Policy | Out-File -FilePath $LogLocation -Append
        
        #Deleting Policy
        Remove-IAMPolicy -PolicyArn $PolicyARN -force
}
