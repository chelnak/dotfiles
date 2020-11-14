$ENV:STARSHIP_CONFIG = "$HOME/.dotfiles/config/prompt/.starship"
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

Set-PSReadLineOption -PredictionSource HistoryAndPlugin
Set-PSReadLineOption -PredictionViewStyle ListView

Set-Alias -Name touch -Value New-Item
Set-Alias -Name env -Value Get-EnvironmentVariable
Set-Alias -Name tf -Value terraform
Set-Alias -Name tg -Value terragrunt
Set-Alias -Name ip -Value Get-PublicIPAddress

Invoke-Expression (&starship init powershell)

Get-DotFilesUpdateStatus
