# Configs

A collection of shell and tool configuration files.


# Wsl

* Create `/etc/wsl.conf` from [wsl.conf](linux/etx/wsl.conf)
* Restart WSL with `wsl --shutdown` for these settings to take effect

# Fish

## Install

```bash
# Install shell
sudo apt install fish

# Make it default
chsh -s /usr/bin/fish

# Install fisher
curl https://git.io/fisher --create-dirs -sLo ~/.config/fish/functions/fisher.fish

# Add a theme
fisher add oh-my-fish/theme-robbyrussell
```

# Pwsh

Add the PowerShell core profile to:

``` PowerSHell
/home/$USER/.config/powershell/Microsoft.PowerShell_profile.ps1
```

# Terminal

The Windows Terminal profile [here](windows/terminal/profile.json) has a custom theme based on the [Dracula](https://github.com/dracula/iterm) iterm2 theme.

Add the profile and associated `party_parrot.png` image to:

``` PowerShell
$ENV:LOCALAPPDATA/Packages/Microsoft.WindowsTerminal_8wekyb3d8bbwe/RoamingState
```

# Ubuntu settings

## Add me to the docker group
```bash
sudo usermod -aG docker $USER
```

## Az cli
```bash
curl -sL https://aka.ms/InstallAzureCLIDeb | sudo bash
```

## PowerShell
```bash
sudo apt-get install -y powershell
```

## Keybase
```bash
curl --remote-name https://prerelease.keybase.io/keybase_amd64.deb
sudo apt install ./keybase_amd64.deb
run_keybase
```

## Hub
```bash
# Install
sudo add-apt-repository ppa:cpick/hub
sudo apt update
sudo apt install hub

# Use https
git config --global hub.protocol https
```

# Sources

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
