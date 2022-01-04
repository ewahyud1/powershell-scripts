### IAM Role Cleanup Script

#### Synopsis
This script can be used to delete multiple IAM roles. For an IAM role to be deleted, any managed or inline policy will first need to be removed/detached. If there is an instance profile associated with it, it will also need to be 
removed first before a role can be deleted.  This script will perform the following in the respective steps:

1. Get the list of IAM roles (with and without path)
2. Checks and delete any inline policy
3. Checks and detach any managed policy
4. Removed the IAM role from the Instance Profile if there is any
5. Finally, deletes the IAM role itself.

Further explanations are added to the script itself as comments.  
