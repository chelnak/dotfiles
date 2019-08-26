properties {

}

task default -depends core, vscode, powershell, azcli, terminal,keybase, git

task core {

    Set-ExecutionPolicy Bypass -Scope Process -Force

    if (!(Get-Command -Name choco)) {
        Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
    }

    $env:ChocolateyInstall = Convert-Path "$((Get-Command choco).path)\..\.."
    Import-Module "$env:ChocolateyInstall\helpers\chocolateyProfile.psm1"

    if (!(Get-PackageProvider -Name Nuget -ErrorAction SilentlyContinue)){
        Install-PackageProvider -Name NuGet -Force
    }

    Set-PSRepository -Name PSGallery -InstallationPolicy Trusted

    choco upgrade googlechrome -y
    choco upgrade 7zip.install -y
    choco upgrade nodejs.install -y
    choco upgrade kubernetes-cli -y
    choco upgrade kubernetes-helm -y
    choco upgrade microsoftazurestorageexplorer -y
    choco upgrade azure-data-studio -y
    choco upgrade dotnetcore-sdk -y
    choco upgrade gpg4win-vanilla -y

    refreshenv
}

task wsl {

    $Features = @(
        "Microsoft-Windows-Subsystem-Linux",
        "VirtualMachinePlatform"
    )
    Enable-WindowsOptionalFeature -Online -FeatureName $Features
    # Invoke-WebRequest -Uri "https://aka.ms/wsl-ubuntu-1804" -OutFile "$ENV:TEMP\Ubuntu.appx" -UseBasicParsing
    wsl --set-default-version 2
    Add-AppxPackage -Path "$ENV:TEMP\Ubuntu.appx" -Confirm:$false
}

task vscode {

    choco upgrade vscode -y
    $Extensions = Get-Content -Path $PSScriptRoot/../shared/vscode/plugins.json | ConvertFrom-Json
    $Extensions | ForEach-Object {
        Write-Host "Installing VSCode extension $_"
        code --install-extension $_
    }
}

task powershell {

    if (!$ENV:HOMESHARE) {
        choco upgrade powershell-core --install-arguments='"ADD_EXPLORER_CONTEXT_MENU_OPENPOWERSHELL=1"' -y
        $Modules =  Get-Content -Path $PSScriptRoot/../shared/powershell/modules.json | ConvertFrom-Json
        $Modules | ForEach-Object {
            [bool]$PreRelease = $_.prerelease
            pwsh -Command Install-Module $_.name -AllowPrerelease:`$$PreRelease -Scope CurrentUser -Confirm:`$$False -Verbose
            PowerShell -Command Install-Module $_.name -AllowPrerelease:`$$PreRelease -Scope CurrentUser -Confirm:`$$False -Verbose
        }
    }

    Write-Host "Copying PowerShell Profile"
    $DocumentsPath = "$ENV:USERPROFILE\Documents"
    Remove-Item -Path "$DocumentsPath\PowerShell\Microsoft.PowerShell_profile.ps1" -Force -ErrorAction SilentlyContinue
    Remove-Item -Path "$DocumentsPath\\WindowsPowerShell\Microsoft.PowerShell_profile.ps1" -Force -ErrorAction SilentlyContinue
    cmd /c mklink "$DocumentsPath\PowerShell\Microsoft.PowerShell_profile.ps1" "$PSScriptRoot\..\shared\powershell\Microsoft.PowerShell_profile.ps1"
    cmd /c mklink "$DocumentsPath\\WindowsPowerShell\Microsoft.PowerShell_profile.ps1" "$PSScriptRoot\..\shared\powershell\Microsoft.PowerShell_profile.ps1"
}

task azcli {

    choco upgrade azure-cli -y
    $Extensions =  Get-Content -Path $PSScriptRoot/../shared/az-cli/extensions.json | ConvertFrom-Json
    $Extensions | ForEach-Object {
        Write-Host "Adding az-cli extension $_"
        az extension add --name $_
    }
    Remove-Item -Path "$ENV:USERPROFILE\.azure\config" -Force -ErrorAction SilentlyContinue
    cmd /c mklink "$ENV:USERPROFILE\.azure\config" "$PSScriptRoot\..\shared\az-cli\config"
}

task terminal {

    $TerminalAppDataPath = "$ENV:USERPROFILE\AppData\Local\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\RoamingState"
    Write-Host "Configuring Terminal profile"
    Remove-Item -Path $TerminalAppDataPath -Force -Recurse -ErrorAction SilentlyContinue
    cmd /c mklink /D "$ENV:USERPROFILE\AppData\Local\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\RoamingState" "$PSScriptRoot\terminal"
}

task keybase {

    choco install keybase -y
    refreshenv
    keybase login
    keybase pgp export | gpg --import
    keybase pgp export --secret --unencrypted | gpg --allow-secret-key-import --import
}

task git {

    choco upgrade git.install -y
    choco upgrade hub -y
    choco upgrade git-credential-manager-for-windows -y

    Get-Content -Raw $PSScriptRoot\..\shared\.gitconfig | keybase pgp decrypt | Set-Content -Path $ENV:USERPROFILE\.gitconfig
    git config --global credential.helper manager
    git config --global gpg.program "C:/Program Files (x86)/GNU/GnuPG/pub/gpg.exe"
}
