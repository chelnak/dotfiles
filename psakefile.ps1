properties {
    $ErrorActionPreference = "Stop"
    $ConfigDirectory = "$PSScriptRoot/config"
    $DocumentsPath = "$ENV:USERPROFILE/Documents"
}

task default -depends init, vscode, powershell, azcli, terminal, git

task init -description "Init" {

    Write-Host -Message "Trusting PSRepository 'PSGallery'"
    Set-PSRepository -Name PSGallery -InstallationPolicy Trusted

}

task install -description "Install applications" {

    if (Get-Command -Name winget -ErrorAction SilentlyContinue) {
        $Apps | Get-Content -Path $ConfigDirectory/apps/apps.json | ConvertFrom-Json
        $Apps | Foreach-Object {
            winget install -e -h $_
        }
    }

    python -m pip install catz
}

task vscode -description "Configure vscode" {

    if (Get-Command -Name code -ErrorAction SilentlyContinue) {
        $Extensions = Get-Content -Path $ConfigDirectory/vscode/plugins.json | ConvertFrom-Json
        $Command = "code $(($Extensions | ForEach-Object {"--install-extension $_"}) -join " ") --force"
        Invoke-Expression -Command $Command

        $null = New-Item -Path "$ENV:APPDATA/Code/User/settings.json" -ItemType SymbolicLink -Value "$ConfigDirectory/vscode/settings.json" -Force
    }

}

task powershell -description "Configure PowerShell" {

    if (!(Get-Module -Name PSDepend -ListAvailable)) {
        Write-Host "Installing PSDepend"
        Install-Module -Name PSDepend -Scope CurrentUser -Force
    }

    Invoke-PSDepend -Path "$ConfigDirectory/powershell/requirements.psd1" -Force

    $null = New-Item -Path "$DocumentsPath/PowerShell/Microsoft.PowerShell_profile.ps1" -ItemType SymbolicLink -Value "$ConfigDirectory/powershell/Microsoft.PowerShell_profile.ps1" -Force
    $null = New-Item -Path "$DocumentsPath/PowerShell/Microsoft.VSCode_profile.ps1" -ItemType SymbolicLink -Value "$ConfigDirectory/powershell/Microsoft.VSCode_profile.ps1" -Force

}

task terminal -description "Configure Windows Terminal" {
    $null = New-Item -Path "$ENV:USERPROFILE/AppData/Local/Packages/Microsoft.WindowsTerminal_8wekyb3d8bbwe/LocalState/settings.json" -ItemType SymbolicLink -Value "$ConfigDirectory/terminal/settings.json" -Force
}

task azcli -description "Configure Azure Cli" {

    $Extensions = Get-Content -Path $ConfigDirectory/az-cli/extensions.json | ConvertFrom-Json
    $InstalledExtensions = @(az extension list -o json --query '[].name' | ConvertFrom-Json)
    $Extensions | ForEach-Object {
        if (!($InstalledExtensions -contains $_)) {
            Write-Host "Adding az-cli extension $_"
            az extension add --name $_ 2>$null
        }
    }

    $null = New-Item -Path "$ENV:USERPROFILE/.azure/config" -ItemType SymbolicLink -Value "$ConfigDirectory/az-cli/config" -Force

}

task git -description "Configure Git" {

    if (!(Test-Path -Path $ENV:USERPROFILE/.gitconfig)) {
        Get-Content -Raw $ConfigDirectory/.gitconfig | keybase pgp decrypt | Set-Content -Path $ENV:USERPROFILE/.gitconfig
    }

    $GPG = Get-Command -Name gpg -ErrorAction SilentlyContinue

    git config --global credential.helper manager
    git config --global gpg.program $GPG.Source
    git config --global core.editor "code -w -n"
    git config --global pull.rebase true
    git config --global core.autocrlf false
    git config --global init.defaultBranch main
}
