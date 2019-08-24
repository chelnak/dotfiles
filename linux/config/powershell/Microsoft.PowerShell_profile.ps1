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

Set-Location -Path $ENV:HOME/code -ErrorAction stop
