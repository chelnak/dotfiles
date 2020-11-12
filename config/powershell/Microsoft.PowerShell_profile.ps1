Import-Module -Name oh-my-posh
Import-Module -Name posh-git
Import-Module -Name PSColor

$ErrorView = 'ConciseView'

function Get-EnvironmentVariable {
    Get-Item -Path Env:\
}

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
        [ValidateSet("core", "vscode", "powershell", "azcli", "terminal", "git")]
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
        $Response = Invoke-RestMethod -Method Get -Uri "https://api.github.com/repos/chelnak/dotfiles/compare/$CurrentSha...master" -TimeoutSec 1
        if ($Response.status -eq "ahead") {
            Write-Host -Message "Your dotfiles configuration is behind by $($Response.ahead_by) commit(s)."
            Write-Host -Message "Run Update-DotFiles to get the latest configuration" -ForegroundColor Yellow
        }
    }
}

function Invoke-AwsVaultExecCmd {
    <#
    .SYNOPSIS
    A wrapper for aws-vault exec

    .DESCRIPTION
    A wrapper for aws-vault exec that enables use with PowerShell. This function assumes that aws-vault.exe is available in $ENV:\PATH

    .PARAMETER Profile
    The name of the profile to use for the command execution

    .PARAMETER Command
    A script block containing the command that will be executed with the given context

    .EXAMPLE
    Invoke-AwsVaultExecCmd -Profile hmpps-sl -Command {aws sts get-caller-identity}

    .EXAMPLE
    Invoke-AwsVaultExecCmd hmpps-sl {aws sts get-caller-identity}

    .EXAMPLE
    awsv hmpps-sl {aws sts get-caller-identity}
#>
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

function Enable-KubernetesPrompt {
    Remove-Item -Path Env:/HIDE_K8S_PROMPT -ErrorAction SilentlyContinue
}

function Get-PublicIPAddress {
    (Invoke-WebRequest ifconfig.me/ip).Content.Trim()
}

function Disable-KubernetesPrompt {
    $ENV:HIDE_K8S_PROMPT = 1
}

Set-PSReadLineOption -PredictionSource HistoryAndPlugin
Set-PSReadLineOption -PredictionViewStyle ListView

Set-Theme -Name chelnak

Set-Alias -Name touch -Value New-Item
Set-Alias -Name env -Value Get-EnvironmentVariable
Set-Alias -Name tf -Value terraform
Set-Alias -Name tg -Value terragrunt
Set-Alias -Name ip -Value Get-PublicIPAddress

Get-DotFilesUpdateStatus
