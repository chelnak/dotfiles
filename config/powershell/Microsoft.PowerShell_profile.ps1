Import-Module -Name oh-my-posh
Import-Module -Name posh-git
Import-Module -Name Get-ChildItemColor

$ErrorView = 'ConciseView'

Set-Theme -Name robbyrussell_custom

function Get-EnvironmentVariable {
    Get-Item -Path Env:\
}

Set-Alias -Name env -Value Get-EnvironmentVariable

function Edit-Dofiles {
    & code "$ENV:USERPROFILE/.dotfiles"
}

function Update-Dotfiles {
    Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://raw.githubusercontent.com/chelnak/dotfiles/master/install.ps1'))
}

function Get-DotFilesUpdateStatus {
    $CurrentSha = Get-Content -Path $ENV:USERPROFILE/.dotfiles/.latest
    $Response = Invoke-RestMethod -Method Get -Uri "https://api.github.com/repos/chelnak/dotfiles/compare/$CurrentSha...master"

    if ($Response.status -eq "behind") {
        Write-Host -Message "Your dotfiles configuration is behind by $($Response.behind_by) commit(s)."
        Write-Host -Message "Run Update-DotFiles to get the latest configuration" -ForegroundColor Yellow
    }
}


Get-DotFilesUpdateStatus

if ($ENV:TERM_PROGRAM -ne "vscode") {
    Set-Location -Path $ENV:USERPROFILE/code -ErrorAction stop
}

