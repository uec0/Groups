$Groups = 'gp-u-EDAV_SAS_NCBDDD_OP', 'gp-u-EDAV_SAS_NCBDDD_DBD_OP', 'gp-u-EDAV_SAS_NCBDDD_DBDID_SETNET_OP', 'gp-u-EDAV_SAS_Users_OP'
$Users =  'DGX1', 'OGC4', 'PJU4', 'QMQ4', 'QPD2', 'QRM4', 'VCT2'

ForEach ($Group in $Groups)
        { Add-ADGroupMember -Identity $Group -Members $Users -Server cdc.gov -ErrorAction Stop
         
        }
## Double Check Membership
$Members = Get-ADGroupMember -Identity $Group -Server cdc.gov | Select Samaccountname