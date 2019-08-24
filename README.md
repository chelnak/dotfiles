# Dotfiles (and more)

A collection of shell and tool configuration files.

![](https://cultofthepartyparrot.com/parrots/hd/laptop_parrot.gif)

## Ubuntu (WSL)

```bash
bash -c "`curl -fsSL https://raw.githubusercontent.com/chelnak/dotfiles/master/linux/install.sh`"

cd dotfiles/linux

make
```
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
* Installs `PowerShell` and copies the profile
* Installs `Az` cli
* Installs `Keybase`
* Installs `hub`
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
* Installs the following vscode extensions
```javascript
gitlens
EditorConfig
azure-pipelines
remote-containers
remote-ssh
remote-ssh-edit
remote-ssh-explorer
emote-wsl
vscode-remote-extensionpack
csharp
powershell
vsliveshare
azurerm-vscode-tools
vscode-yaml
vscodeintellicode
vscode-pull-request-github
oderwat.indent-rainbow
```
* Installs the following PowerShell modules
```
Az
posh-git
```
* Adds the PowerShell profile to the core path from [here](linux/config/powershell)
* Adds the following az cli extensions
```
azure-devops
```
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
* [Hub](https://hub.github.com/)
* [Az cli](https://docs.microsoft.com/en-us/cli/azure/install-azure-cli-apt?view=azure-cli-latest)
* [PowerShell](https://docs.microsoft.com/en-us/powershell/scripting/install/installing-powershell-core-on-linux?view=powershell-6)
* [Kubectl](https://kubernetes.io/docs/tasks/tools/install-kubectl/#install-using-native-package-management)
* [Helm](https://helm.sh/docs/using_helm/#from-script)
