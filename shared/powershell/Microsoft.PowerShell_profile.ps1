Import-Module -Name oh-my-posh
Import-Module -Name posh-git
Import-Module -Name Get-ChildItemColor

Set-Theme -Name robbyrussell_custom

function Get-EnvironmentVariable {
    Get-Item -Path Env:\
}

Set-Alias -Name env -Value Get-EnvironmentVariable

function Update-Dotfiles {
    if ($ENV:OS -eq "Windows_NT") {
        Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://raw.githubusercontent.com/chelnak/dotfiles/master/windows/install.ps1'))
        $AdminRole = [Security.Principal.WindowsBuiltInRole]::Administrator
        $CurrentRole = [Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()
        if ($CurrentRole.IsInRole($AdminRole)) {
            Invoke-PSake -buildFile $ENV:USERPROFILE/.dotfiles/windows/Psake.ps1
        }
        else {
            Start-Process -FilePath pwsh.exe -ArgumentList '-c Invoke-PSake -buildFile $ENV:USERPROFILE/.dotfiles/windows/Psake.ps1 ; Start-SLeep 20' -Verb RunAs -Wait
        }
    }
    else {
        Write-Host "Running fish: update_dotfiles"
        fish -c 'update_dotfiles'
    }
}

Set-Location -Path $ENV:HOME/code -ErrorAction stop
