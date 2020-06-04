Import-Module -Name oh-my-posh
Import-Module -Name posh-git
Import-Module -Name Get-ChildItemColor

$ErrorView = 'ConciseView'

function Get-EnvironmentVariable {
    Get-Item -Path Env:\
}

function Edit-Dofiles {
    & code "$ENV:USERPROFILE/.dotfiles"
}

function Update-Dotfiles {
    Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://raw.githubusercontent.com/chelnak/dotfiles/master/install.ps1'))
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

        & aws-vault exec $Profile -- pwsh -Command $Command.ToString()

    } catch {
        Write-Error -Message "$_"
    }
}

$ENV:PATH="$ENV:PATH;$ENV:USERPROFILE\AppData\Local\Programs\jcat"

Set-Theme -Name robbyrussell_custom

Set-Alias -Name touch -Value New-Item
Set-Alias -Name env -Value Get-EnvironmentVariable
Set-Alias -Name tf -Value terraform

Get-DotFilesUpdateStatus
