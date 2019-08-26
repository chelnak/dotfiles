Import-Module posh-git
$GitPromptSettings.WindowTitle = $false

if (Get-Module -Name Az.Profile -ListAvailable) {
    $Host.UI.RawUI.WindowTitle = "Loading Az ..."
    $SubScriptionName = (Get-AzContext).Subscription.Name
}

function prompt {
    if ($SubScriptionName) {
        $WindowTitle = "pwsh $((Get-Location).path) | Az - [$($SubscriptionName)]"
    }
    else {
        $WindowTitle = "pwsh $((Get-Location).path)"
    }
    $Host.UI.RawUI.WindowTitle = $WindowTitle

    $Prompt = Write-Prompt "›  " -ForegroundColor ([ConsoleColor]::Green)
    $GitPromptSettings.DefaultPromptPath.Text = "$(Split-Path (Get-Location).Path -Leaf)"
    $GitPromptSettings.DefaultPromptPath.ForegroundColor = "Cyan"
    $GitPromptSettings.DefaultPromptSuffix = ''
    $Prompt += & $GitPromptScriptBlock
    if ($Prompt) { "$Prompt " } else { " " }
}

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
