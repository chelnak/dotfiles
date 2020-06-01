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

$ENV:PATH="$ENV:PATH;$ENV:USERPROFILE/.dotfiles/util"

Set-Theme -Name robbyrussell_custom

Set-Alias -Name touch -Value New-Item
Set-Alias -Name env -Value Get-EnvironmentVariable
Set-Alias -Name tf -Value terraform

Get-DotFilesUpdateStatus

if ($ENV:TERM_PROGRAM -ne "vscode") {
    Set-Location -Path $ENV:USERPROFILE/code -ErrorAction stop
}

