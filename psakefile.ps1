properties {
    $ErrorActionPreference = "Stop"
    $ConfigDirectory = "$PSScriptRoot\config"
}

task default -depends core, vscode, powershell, azcli, terminal, git, jcat

task core -description "Configure core services" {

    Write-Host -Message "Trusting PSRepository 'PSGallery'"
    Set-PSRepository -Name PSGallery -InstallationPolicy Trusted

    Write-Host -Message "Setting global editorconfig"
    cmd /c mklink "$ENV:USERPROFILE\.editorconfig" "$PSScriptRoot\.editorconfig"

}

task install -description "Install applications" {

    $Apps | Get-Content -Path $ConfigDirectory/apps/apps.json | ConvertFrom-Json
    $Apps | Foreach-Object {
        winget install -e -h $_
    }

}

task wsl -description "Configure WSL" {

    $Features = @(
        "Microsoft-Windows-Subsystem-Linux",
        "VirtualMachinePlatform"
    )
    Enable-WindowsOptionalFeature -Online -FeatureName $Features
    # Invoke-WebRequest -Uri "https://aka.ms/wsl-ubuntu-1804" -OutFile "$ENV:TEMP\Ubuntu.appx" -UseBasicParsing
    wsl --set-default-version 2
    Add-AppxPackage -Path "$ENV:TEMP\Ubuntu.appx" -Confirm:$false
}

task vscode -description "Configure vscode" {

    $Extensions = Get-Content -Path $ConfigDirectory/vscode/plugins.json | ConvertFrom-Json
    $Extensions | ForEach-Object {
        code --install-extension $_ --force
    }
}

task powershell -description "Configure PowerShell" {

    $Modules =  Get-Content -Path $ConfigDirectory/powershell/modules.json | ConvertFrom-Json
    Write-Host -Message "Installing/updating $($Modules.Count) module(s)"
    $Modules | ForEach-Object {
        [bool]$PreRelease = $_.prerelease

        pwsh -NoProfile -Command "& {
            if (Get-Module -Name $($_.name) -ListAvailable) {
                Write-Host '    -> Updating module [$($_.name)]'
                Update-Module -Name $($_.name) -AllowPrerelease:`$PreRelease -Scope CurrentUser -Confirm:`$False
            } else {
                Write-Host '    -> Installing module [$($_.name)]'
                Install-Module $($_.name) -AllowPrerelease:`$PreRelease -Scope CurrentUser -Confirm:`$False -AllowClobber
            }
        }"

    }

    Write-Host "Configuring PowerShell Profile"
    $DocumentsPath = "$ENV:USERPROFILE\Documents"
    Remove-Item -Path "$DocumentsPath\PowerShell\Microsoft.PowerShell_profile.ps1" -Force -ErrorAction SilentlyContinue
    Remove-Item -Path "$DocumentsPath\\PowerShell\Microsoft.VSCode_profile.ps1" -Force -ErrorAction SilentlyContinue
    Remove-Item -Path "$DocumentsPath\\PowerShell\PoshThemes" -Recurse -Force -ErrorAction SilentlyContinue
    cmd /c mklink "$DocumentsPath\PowerShell\Microsoft.PowerShell_profile.ps1" "$ConfigDirectory\powershell\Microsoft.PowerShell_profile.ps1"
    cmd /c mklink "$DocumentsPath\PowerShell\Microsoft.VSCode_profile.ps1" "$ConfigDirectory\powershell\Microsoft.VSCode_profile.ps1"
    cmd /c mklink /D "$DocumentsPath\\PowerShell\PoshThemes" "$ConfigDirectory\powershell\PoshThemes"

    . $PROFILE
}

task azcli -description "Configure Azure Cli" {

    $Extensions =  Get-Content -Path $ConfigDirectory/az-cli/extensions.json | ConvertFrom-Json
    $Extensions | ForEach-Object {
        Write-Host "Adding az-cli extension $_"
        az extension add --name $_
    }
    Remove-Item -Path "$ENV:USERPROFILE\.azure\config" -Force -ErrorAction SilentlyContinue
    cmd /c mklink "$ENV:USERPROFILE\.azure\config" "$ConfigDirectory\az-cli\config"
}

task terminal -description "Configure Windows Terminal" {

    $TerminalAppDataPath = "$ENV:USERPROFILE\AppData\Local\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState"
    Write-Host "Configuring Terminal profile"
    Remove-Item -Path $TerminalAppDataPath\* -Force -Recurse -ErrorAction SilentlyContinue
    cmd /c mklink "$ENV:USERPROFILE\AppData\Local\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState\settings.json" "$ConfigDirectory\terminal\settings.json"
    cmd /c mklink "$ENV:USERPROFILE\AppData\Local\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\LocalState\party_parrot.json" "$ConfigDirectory\terminal\party_parrot.json"
}

task keybase -description "Configure gpg" {

    keybase login
    keybase pgp export | gpg --import
    keybase pgp export --secret --unencrypted | gpg --allow-secret-key-import --import
}

task git -description "Configure Git" {

    Get-Content -Raw $ConfigDirectory\.gitconfig | keybase pgp decrypt | Set-Content -Path $ENV:USERPROFILE\.gitconfig
    git config --global credential.helper manager
    git config --global gpg.program "C:/Program Files (x86)/GnuPG/bin/gpg.exe"
    git config --global core.editor "code -w -n"
}

task jcat -description "Configure jcat" {

    $JcatPath = "$ENV:USERPROFILE\AppData\Local\Programs\jcat"
    $ENV:PATH="$ENV:PATH;$JcatPath"

    $LatestRelease = Invoke-RestMethod -Method Get -Uri "https://api.github.com/repos/chelnak/jcat/releases/latest"
    $LatestAsset = $LatestRelease.assets.Where{$_.name -Like "*.msi"}

    Invoke-RestMethod -Method Get -Uri $LatestAsset.browser_download_url -OutFile $ENV:TEMP/$LatestAsset.name -FollowRelLink

    & msiexec /i $ENV:TEMP\$LatestAsset.name /passive
}
