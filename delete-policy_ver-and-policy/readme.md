#### Script to delete customer-managed policies

1.  Compile the list of policies that need to be deleted in a file (.txt for simplicity)
2.  Specify the path where the file is stored in the script; in the **Get-Content -Path**
3.  Specify a location where you'd like to log what have been deleted 
4.  Run the script
    - This will go through each of the policies to remove the policy versions and then delete the policy itself.
