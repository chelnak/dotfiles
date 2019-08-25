properties {

}

task default -depends InstallDependencies, InstallApplications, Configure_VSCode, Configure_PowerShell, Configure_AzCli, Configure_Keybase, Configure_Git

task InstallDependencies {
    Set-ExecutionPolicy Bypass -Scope Process -Force
    Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
    $env:ChocolateyInstall = Convert-Path "$((Get-Command choco).path)\..\.."
    Import-Module "$env:ChocolateyInstall\helpers\chocolateyProfile.psm1"

    Install-PackageProvider -Name NuGet -MinimumVersion 2.8.5.201 -Force
    Set-PSRepository -Name PSGallery -InstallationPolicy Trusted
}

task InstallApplications {
    choco upgrade googlechrome -y
    choco upgrade 7zip.install -y
    choco upgrade git.install -y
    choco upgrade hub -y
    choco upgrade git-credential-manager-for-windows -y
    choco upgrade nodejs.install -y
    choco upgrade vscode -y
    choco upgrade kubernetes-cli -y
    choco upgrade kubernetes-helm -y
    choco upgrade microsoftazurestorageexplorer -y
    choco upgrade azure-cli -y
    choco upgrade azure-data-studio -y
    choco upgrade dotnetcore-sdk -y
    choco upgrade powershell-core --install-arguments='"ADD_EXPLORER_CONTEXT_MENU_OPENPOWERSHELL=1"' -y
    choco upgrade gpg4win-vanilla -y
    choco install keybase -y

    refreshenv
}

task Configure_VSCode {

    $Extensions = @(

        "eamodio.gitlens",
        "EditorConfig.EditorConfig",
        "ms-azure-devops.azure-pipelines",
        "ms-vscode-remote.remote-containers",
        "ms-vscode-remote.remote-ssh",
        "ms-vscode-remote.remote-ssh-edit",
        "ms-vscode-remote.remote-ssh-explorer",
        "ms-vscode-remote.remote-wsl",
        "ms-vscode-remote.vscode-remote-extensionpack",
        "ms-vscode.csharp",
        "ms-vscode.powershell",
        "ms-vsliveshare.vsliveshare",
        "msazurermtools.azurerm-vscode-tools",
        "redhat.vscode-yaml",
        "VisualStudioExptTeam.vscodeintellicode",
        "github.vscode-pull-request-github",
        "oderwat.indent-rainbow"

    )
    $Extensions | ForEach-Object {
        Write-Host "Installing VSCode extension $_"
        code --install-extension $_
    }
}

task Configure_PowerShell {

    if (!$ENV:HOMESHARE) {
        pwsh -Command Install-Module posh-git -AllowPrerelease -Scope CurrentUser -Force -Verbose
        pwsh -Command Install-Module Az -Scope CurrentUser -Force -Verbose
    }

    Write-Host "Copying PowerShell Profile"
    $DocumentsPath = "$ENV:USERPROFILE\Documents"

    Copy-Item -Path "$PSScriptRoot\..\linux\config\powershell\Microsoft.PowerShell_profile.ps1" -Destination "$DocumentsPath\PowerShell\Microsoft.PowerShell_profile.ps1" -Force
}

task Configure_AzCli {

    $Extensions = @(
        "azure-devops"
    )

    $Extensions | ForEach-Object {
        Write-Host "Adding az-cli extension $_"
        az extension add --name $_
    }

}

task Configure_Terminal {
    $TerminalAppDataPath = "$ENV:USERPROFILE\AppData\Local\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\RoamingState"
    if (Test-Path -Path $TerminalAppDataPath) {
        Write-Host "Configuring Terminal profile"
        Copy-Item -Path $PSScriptRoot\terminal\* -Destination $TerminalAppDataPath -Force -Recurse
    }
}

task Configure_Keybase {
    refreshenv
    keybase login
    keybase pgp export | gpg --import
    keybase pgp export --secret --unencrypted | gpg --allow-secret-key-import --import
}

task Configure_git {
    Get-Content -Raw $PSScriptRoot\..\linux\.gitconfig | keybase pgp decrypt | Set-Content -Path $ENV:USERPROFILE\.gitconfig
    git config --global credential.helper manager
    git config --global gpg.program "C:/Program Files (x86)/GNU/GnuPG/pub/gpg.exe"
}
