# Start transcript
Start-Transcript -Path C:\Temp\Add-ADUsers-Multi.log -Append

# Import AD Module
Import-Module ActiveDirectory

# Import the data from CSV file and assign it to variable
$List = Import-Csv "C:\Temp\testusers.csv"

foreach ($User in $List) {
    # Retrieve UserSamAccountName and ADGroup
    $UserSam = $User.SamAccountName
    $Groups = $User.Group

    # Retrieve SamAccountName and ADGroup
    $ADUser = Get-ADUser -Server cdc.gov -Filter "SamAccountName -eq "$UserSam"" | Select-Object SamAccountName
    $ADGroups = Get-ADGroup -Filter * | Select-Object DistinguishedName, SamAccountName

    # User does not exist in AD
    if ($ADUser -eq $null) {
        Write-Host "$UserSam" does not exist in AD" -ForegroundColor Red
        Continue
    }
    # User does not have a group specified in CSV file
    if ($Groups -eq $null) {
        Write-Host "$UserSam" has no group specified in CSV file" -ForegroundColor Yellow
        Continue
    }
    # Retrieve AD user group membership
    $ExistingGroups = Get-ADPrincipalGroupMembership $UserSam | Select-Object DistinguishedName, SamAccountName

    foreach ($Group in $Groups.Split(';')) {
        # Group does not exist in AD
        if ($ADGroups.SamAccountName -notcontains $Group) {
            Write-Host "$Group" does not exist in AD" -ForegroundColor Red
            Continue
        }
        # User already member of group
        if ($ExistingGroups.SamAccountName -eq $Group) {
            Write-Host "$UserSam" already exists in group $Group" -ForeGroundColor Yellow
        } 
        else {
            # Add user to group
            Add-ADGroupMember -Identity $Group -Members $UserSam
            Write-Host "Added "$UserSam" to "$Group"" -ForeGroundColor Green
        }
    }
}
Stop-Transcript