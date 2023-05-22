$Cent = Get-ADUser -Server cdc.gov -Filter * -SearchBase "OU=CENT, OU=Users, OU=RES, DC=cdc, DC=gov" | Select-Object SamAccountName, Name, Enabled
$RFS = Get-ADUser -Server cdc.gov -Filter * -SearchBase "OU=RFS, OU=Users, OU=RES, DC=cdc, DC=gov" | Select-Object SamAccountName, Name, Enabled
$KOGR = Get-ADUser -Server cdc.gov -Filter * -SearchBase "OU=KOGR, OU=Users ,OU=RES, DC=cdc, DC=gov" | Select-Object SamAccountName, Name, Enabled
$CHAM = Get-ADUser -Server cdc.gov -Filter * -SearchBase "OU=CHAM, OU=Users, OU=RES, DC=cdc,DC=gov" | Select-Object SamAccountName, Name, Enabled
$SYNC = Get-ADUser -Server cdc.gov -Filter * -SearchBase "OU=Sync, OU=KOGR, OU=Users, OU=RES, DC=cdc, DC=gov" | Select-Object SamAccountName, Name, Enabled
$CORP = Get-ADUser -Server cdc.gov -Filter * -SearchBase "OU=CORP, OU=Users, OU=RES, DC=cdc, DC=gov" | Select-Object SamAccountName, Name, Enabled
$CLFT = Get-ADUser -Server cdc.gov -Filter * -SearchBase 'OU=CLFT, OU=Users, OU=RES, DC=cdc, DC=gov' | Select-Object SamAccountName, Name, Enabled

$Cent | Out-GridView -Title CENT-Users
$RFS  | Out-GridView -Title RFS-Users
$KOGR | Out-GridView -Title KOGR-Users
$CHAM | Out-GridView -Title CHAM-Users
$SYNC | Out-GridView -Title SYNC-Users
$CORP | Out-GridView -Title CORP-Users
$CLFT | Out-GridView -Title CLFT-Users