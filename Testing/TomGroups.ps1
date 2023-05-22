Cls
$ougroups = "OU=EDAV,OU=RES,DC=hce,DC=cdc,DC=gov"
$OUusers = @( "OU=CLFT,OU=Users,OU=RES,DC=cdc,DC=gov",
               "OU=CENT,OU=Users,OU=RES,DC=cdc,DC=gov",
               "OU=RFS,OU=Users,OU=RES,DC=cdc,DC=gov",
               "OU=KOGR,OU=Users,OU=RES,DC=cdc,DC=gov",
               "OU=CHAM,OU=Users,OU=RES,DC=cdc,DC=gov",
               "OU=SYNC,OU=KOGR,OU=Users,OU=RES,DC=cdc,DC=gov",
               "OU=CORP,OU=Users,OU=RES,DC=cdc,DC=gov" )

# $userName = Read-Host -Prompt "Enter the users SamAccountname, exp: uec0 "

                                                 
$selectedGroups = For-Each (Get-ADGroup -Server 'cdc.gov' -Filter * -SearchBase $ougroups | Select-Object Name) { Out-GridView -Title "CHOOSE YOUR GROUPS, hold down the CTRL Key if selecting more than one." -OutputMode Multiple}
$selecteddUsers = For-Each (Get-ADUser -Server 'cdc.gov' -Filter * -SearchBase $ouusers | Select-Object Name) {Out-GridView -Title "CHOOSE ONE OR MORE USERS to add to the group, hold down the CTRL Key to select more than one." -OutputMode Multiple} 

$groupName = #Read-Host -Prompt "Enter the group name"
$userName = Read-Host -Prompt "Enter the username"

try {
    Add-ADGroupMember -Identity $groupName -Members $userName
    Write-Host "User $userName added to group $groupName" -ForegroundColor Green
} catch {
    Write-Host "An error occurred: $_" -ForegroundColor Red
}


$groupName = "YourGroupName"
$groupMembers = Get-ADGroupMember -Identity $groupName | Select-Object Name

$groupName = "YourGroupName"
$userName = "YourUserName"
Add-ADGroupMember -Identity $groupName -Members $userName