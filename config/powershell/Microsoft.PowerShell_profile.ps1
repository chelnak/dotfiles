$ENV:STARSHIP_CONFIG = "$HOME/.dotfiles/config/prompt/.starship"
$ErrorView = "ConciseView"
$ProgressPreference = "SilentlyContinue"

# --- Dotfile helpers
function Edit-Dotfiles {
    Param(
        [Switch]$Clean
    )

    if ($Clean.IsPresent) {
        try {
            Remove-Item "$ENV:USERPROFILE/code/dotfiles" -Recurse -Force
            & git clone "https://github.com/chelnak/dotfiles" "$ENV:USERPROFILE/code/dotfiles"
        }
        catch {
            Write-Error -Message "Could not clean dotfiles: $_"
        }
    }

    & code "$ENV:USERPROFILE/code/dotfiles"
}

function Update-Dotfiles {
    Param(
        [Parameter()]
        [ValidateSet("init", "vscode", "powershell", "azcli", "terminal", "git")]
        [String]$Task
    )

    if ($Task) {
        Invoke-Expression "& { $(Invoke-RestMethod 'https://raw.githubusercontent.com/chelnak/dotfiles/master/install.ps1') } -Task $Task"
    }
    else {
        Invoke-Expression "& { $(Invoke-RestMethod 'https://raw.githubusercontent.com/chelnak/dotfiles/master/install.ps1') }"
    }
}

function Get-DotFilesUpdateStatus {
    $CurrentSha = Get-Content -Path $ENV:USERPROFILE/.dotfiles/.latest -ErrorAction SilentlyContinue
    if ($CurrentSha) {
        $Response = Invoke-RestMethod -Method Get -Uri "https://api.github.com/repos/chelnak/dotfiles/compare/$CurrentSha...master" -TimeoutSec 1 -ErrorAction SilentlyContinue
        if ($Response.status -eq "ahead") {
            Write-Host -Message "Your dotfiles configuration is behind by $($Response.ahead_by) commit(s)."
        }

        $Response.status -eq "ahead" ? $true : $false
    }
}

function Get-EnvironmentVariable {
    Get-Item -Path Env:\
}

# --- Helper functions
function Invoke-AwsVaultExecCmd {

    [CmdletBinding()]
    [Alias("awsv")]
    param(
        [Parameter(Position = 0, Mandatory = $True)]
        [String]$Profile,
        [Parameter(Position = 1, Mandatory = $True)]
        [ScriptBlock]$Command
    )

    try {

        $CurentLocation = Get-Location
        & aws-vault exec $Profile -- pwsh -WorkingDirectory $CurentLocation.Path -Command $Command.ToString()

    }
    catch {
        Write-Error -Message "$_"
    }
}

function Get-PublicIPAddress {
    (Invoke-WebRequest ifconfig.me/ip).Content.Trim()
}

function Select-AzContextConsole {
    Get-AzContext -ListAvailable |
    Out-ConsoleGridView -Title "Select-AzContextConsole" |
    Select-AzContext
}

function Remove-AzContextConsole {
    Get-AzContext -ListAvailable |
    Out-ConsoleGridView -Title "Remove-AzContextConsole" |
    Remove-AzContext
}

# --- PSReadLine config
Set-PSReadLineOption -PredictionSource HistoryAndPlugin
Set-PSReadLineOption -PredictionViewStyle ListView

# --- Alias config
Set-Alias -Name touch -Value New-Item
Set-Alias -Name env -Value Get-EnvironmentVariable
Set-Alias -Name tf -Value terraform
Set-Alias -Name tg -Value terragrunt
Set-Alias -Name ip -Value Get-PublicIPAddress
Set-Alias -Name cat -Value catz -Force


if (Get-DotFilesUpdateStatus) {
    $updateJob = Start-ThreadJob -ScriptBlock {
        Invoke-Expression "& { $(Invoke-RestMethod 'https://raw.githubusercontent.com/chelnak/dotfiles/master/install.ps1') }" 6>$null
    }

    $eventJob = Register-ObjectEvent -InputObject $updateJob -EventName StateChanged -Action {
        if($Event.Sender.State -eq [System.Management.Automation.JobState]::Completed) {
            Get-EventSubscriber $eventJob.Name | Unregister-Event
            Remove-Job $eventJob -ErrorAction SilentlyContinue
            Receive-Job $updateJob -Wait -AutoRemoveJob -ErrorAction SilentlyContinue
        }
    }
}

# --- Init
Invoke-Expression (&starship init powershell)
