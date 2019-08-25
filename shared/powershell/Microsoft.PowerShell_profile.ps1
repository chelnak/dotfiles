Import-Module posh-git

if (Get-Module -Name Az.Profile -ListAvailable) {
    $Host.UI.RawUI.WindowTitle =  "Loading Az ..."
    $SubScriptionName = (Get-AzContext).Subscription.Name
}

function prompt {

    if ($SubScriptionName) {
        $WindowTitle = "pwsh $((Get-Location).path) | Az - [$($SubscriptionName)]"
    } else {
        $WindowTitle = "pwsh $((Get-Location).path)"

    }

    $Host.UI.RawUI.WindowTitle =  $WindowTitle

    $prompt = Write-Prompt "➜ " -ForegroundColor ([ConsoleColor]::Green)

    $prompt += & $GitPromptScriptBlock
    if ($prompt) { "$prompt " } else { " " }
}

function Update-Dotfiles {
    Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://raw.githubusercontent.com/chelnak/dotfiles/master/windows/install.ps1'))
    Invoke-PSake -buildFile $ENV:USERPROFILE/.dotfiles/windows/Psake.ps1
}

Set-Location -Path $ENV:HOME/code -ErrorAction stop
