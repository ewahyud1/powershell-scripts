<#
    This script can add/remove tags for RedShift clusters in specific account
    Tag can be added one at a time and adding new tags do not overwrite the existing ones.
    ***Before use, update account number in (Section #2) - <acctNumber>
    If a resource does not have existing tag; it will not be logged at all
#>

<#
    Use this block to manually list clusters
    $clusternames = "cluster_01", 
                    "cluster_02", 
                    "cluster_03"
#>

# compile the list of clusternames instead of the ARNs
$clusternames = Get-Content -Path "C:\temp\RSClusterList.txt"

#(Section #1) location of historical logs
$logs = "C:\temp\RedShift_log.txt"

#(Section #2) Build the ARN Prefix structure for resources; update acctNumber before running
$ARNPrefix = "arn:aws:redshift:us-east-1:<acctNumber>:cluster:"

$time = Get-Date

foreach ($cluster in $clusternames) { 
    
    #Build the full ARN resource names
    $RS = $ARNPrefix+$cluster
        
    # update the <acctNumber> in (Section #2) before querying against clusters in different account.
    $oldTags = aws redshift describe-tags --resource-name $RS

    Write-Output $time"`nCluster Name: "$cluster $oldTags `n | Out-File -FilePath $logs -Append

    # Cmd to add tags; you can add multiple
    New-RSResourceTag -ResourceName $RS `
                      -Tag @( @{ Key=”Key1”; Value=”Value1” }, `
                              @{ Key=”Key2”; Value=”Value2” } ) ` 
                      -Region us-east-1
    
    <#
        Use this cmd to remove tag(s). Replace the $cluster with the cluster name 
        to address individual cluster
        Remove-RSResourceTag -TagKey Key1, Key2, `
                             -ResourceName arn:aws:redshift:us-east-1:<acct_number>:cluster:$cluster `
                             -Region us-east-1
    #>
        
}
