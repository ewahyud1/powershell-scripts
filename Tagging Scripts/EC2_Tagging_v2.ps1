
Set-AWSCredential -AccessKey "" `
                  -SecretKey "" `
                  -SessionToken ""
                  
                   
$tag = New-Object Amazon.EC2.Model.Tag
$tag.Key = "Key1"
$tag.Value = "Value1"

$snapshots = get-content -Path "C:\<path>\list.txt"


foreach ($snapshot in $snapshots) {

    New-EC2Tag -Resource $snapshot -Tag $tag
    #Remove-EC2Tag -Resource $snapshot -Tag $tag -Force
}