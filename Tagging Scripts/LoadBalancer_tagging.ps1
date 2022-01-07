

$ELBs = "arn:aws:elasticloadbalancing:us-east-1:<acct#>:loadbalancer/<name>"

foreach ($elb in $ELBs) {
    
    Write-Host "The Load Balancer name is" $elb
    

    <# For Classic ELB
    Add-ELBResourceTag -LoadBalancerName $name -Tag @{ Key="Key1";Value="Value1" },
                                                    @{ Key="Key2";Value="Value2" }
    #>

    #For Application/Network ELBs
    Add-ELB2Tag -ResourceArn $elb -Tag @{ Key="Key1";Value="Value1" },
                                       @{ Key="Key2";Value="Value2" }
}