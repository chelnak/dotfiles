if ($ENV:OS -eq "Windows_NT"){
    . "$($ENV:USERPROFILE)/Documents/PowerShell/Microsoft.PowerShell_profile.ps1"
} else {
    . "$($ENV:HOME)/.config/powershell/Microsoft.PowerShell_profile.ps1"
}
