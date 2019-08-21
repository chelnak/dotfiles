properties {

}

task default -depends InstallDependencies, InstallApplications, Configure_VSCode, Configure_PowerShell, Configure_AzCli

task InstallDependencies {
    Set-ExecutionPolicy Bypass -Scope Process -Force
    Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
    $env:ChocolateyInstall = Convert-Path "$((Get-Command choco).path)\..\.."
    Import-Module "$env:ChocolateyInstall\helpers\chocolateyProfile.psm1"

    Install-PackageProvider -Name NuGet -MinimumVersion 2.8.5.201 -Force
    Set-PSRepository -Name PSGallery -InstallationPolicy Trusted
}

task InstallApplications {
    choco upgrade googlechrome -fy
    choco upgrade 7zip.install -fy
    choco upgrade git.install -fy
    choco upgrade nodejs.install -fy
    choco upgrade vscode -fy
    choco upgrade kubernetes-cli -fy
    choco upgrade kubernetes-helm -fy
    choco upgrade microsoftazurestorageexplorer -fy
    choco upgrade azure-cli -fy
    choco upgrade azure-data-studio -fy
    choco upgrade dotnetcore-sdk -fy
    choco upgrade powershell-core --install-arguments='"ADD_EXPLORER_CONTEXT_MENU_OPENPOWERSHELL=1"' -fy

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
        "github.vscode-pull-request-github"

    )
    $Extensions | ForEach-Object {
        Write-Host "Installing VSCode extension $_"
        code --install-extension $_
    }
}

task Configure_PowerShell {

    $Modules = @(
        "Az",
        "Pester"
        "PSScriptAnalyzer"
    )

    $Modules | ForEach-Object {
        Write-Host "Installing module $_"
        Install-Module $_ -Scope CurrentUser -Force
    }

    Write-Host "Copying PowerShell Profile"

    $DocumentsPath = "$ENV:USERPROFILE\Documents"

    if ($ENV:OneDrive ) {
        $DocumentsPath = "$ENV:OneDrive\Documents"
    }

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
    Write-Host "Configuring Terminal profile"
    $TerminalAppDataPath = "$ENV:USERPROFILE\AppData\Local\Packages\Microsoft.WindowsTerminal_8wekyb3d8bbwe\RoamingState"
    if (Test-Path -Path $TerminalAppDataPath) {
        Copy-Item -Path $PSScriptRoot\terminal\* -Destination $TerminalAppDataPath -Force -Recurse
    }
}
