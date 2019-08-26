# Dotfiles (and more)

A collection of shell and tool configuration files.

![](https://cultofthepartyparrot.com/parrots/hd/laptop_parrot.gif)

## Ubuntu

```bash
curl -fsSL -H 'Cache-Control: no-cache' https://raw.githubusercontent.com/chelnak/dotfiles/master/linux/install.sh | bash
cd ~/.dotfiles/linux
make
```
* Supports setup of WSL and standard Ubuntu
* Don't run as `sudo`
* Enter your password when asked

### Requires
* git
* make
* rsync

### Things that the Makefile does
* Attempts to run a dist-upgrade
* Adds $USER to the `docker` group
* Installs `kubectl`
* Installs `helm`
* Installs `fish`, sets it as the default shell, adds `oh-my-fish/theme-robbyrussell` and syncs fish config
* Installs `PowerShell` and these [modules](shared/powershell/modules.json)
* Installs `VSCode` and these [plugins](shared/vscode/plugins.json)
* Installs `Az` cli and these [extensions](shared/az-cli/extensions.json)
* Installs `Keybase`
* Installs `hub` and configures git with pgp key
* Adds a `wsl.conf` to `/etc/wsl.conf`

## Windows

```PowerShell
Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://raw.githubusercontent.com/chelnak/dotfiles/master/windows/install.ps1'))

Set-Location $ENV:USERPROFILE\.dotfiles\windows

Invoke-PSake .\PSake.ps1

```

* Run in an elevated PowerShell session
* Does not support PowerShell Core (but it configures it)

### Requires
* git
* Psake

### Things that the PSake file does
* Installs the following applications
```
git
hub
chrome
7zip
nodejs
vscode
kubectl
helm
azure storage explorer
azure cli
azure data studio
dotnetcore sdk
powershell core
gpg4win
keybase
```
* Installs these [vscode extensions](shared/vscode/plugins.json)
* Installs these [PowerShell modules](shared/powershell/modules.json)
* Adds the PowerShell profile to the core path from [here](shared/powershell/Microsoft.PowerShell_profile.ps1)
* Adds the following az cli extensions from [here](shared/az-cli/extensions.json)
* Configures the Windows Terminal profile
* Configures git with windows cred manager and gpg

## Sources

* [WSL.conf](https://devblogs.microsoft.com/commandline/automatically-configuring-wsl/)
* [Fish shell](https://github.com/fish-shell/fish-shell)
* [Fisher](https://github.com/jorgebucaran/fisher)
* [Oh-my-fish theme](https://github.com/oh-my-fish/theme-robbyrussell)
* [Dracula iTerm](https://github.com/dracula/iterm)
* [Dracula Windows Terminal](https://github.com/dracula/windows-terminal)
* [Keybase Linux](https://keybase.io/docs/the_app/install_linux)
* [Keybase/GitHub setup](https://github.com/pstadler/keybase-gpg-github)
* [Hub](https://hub.github.com/)
* [Az cli](https://docs.microsoft.com/en-us/cli/azure/install-azure-cli-apt?view=azure-cli-latest)
* [PowerShell](https://docs.microsoft.com/en-us/powershell/scripting/install/installing-powershell-core-on-linux?view=powershell-6)
* [Kubectl](https://kubernetes.io/docs/tasks/tools/install-kubectl/#install-using-native-package-management)
* [Helm](https://helm.sh/docs/using_helm/#from-script)
