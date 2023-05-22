#requires -Version 3.0
Param (
    [Parameter(Mandatory,ValueFromPipeline)]
    [String[]]$Groups,
    [Parameter(Mandatory)]
    [String[]]$Users,
    [switch]$Passthru
)

Begin {
    Try { Import-Module ActiveDirectory -ErrorAction Stop }
    Catch { Write-Error "Unable to load Active Directory module, is RSAT installed?"; Exit }
    $Result = @()
}

Process {
    ForEach ($Group in $Groups)
    {   Try {
            Add-ADGroupMember $Group -Members $Users -ErrorAction Stop
            $Result += [PSCustomObject]@{
                Group = $Group
                AddMembers = $Users -join ", "
            }
        }
        Catch {
            Write-Error "Error adding members to $Group because $($Error[0])"
            $Result += [PSCustomObject]@{
                Group = $Group
                AddMembers = $Error[0]
            }
        }
    }
}

End {
    If ($Passthru)
    {   $Result
    }
}