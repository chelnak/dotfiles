# Dotfiles (and more)

A collection of shell and tool configuration files.

![](https://cultofthepartyparrot.com/parrots/hd/laptop_parrot.gif)

## Installation

```PowerShell
Invoke-Expression ((New-Object System.Net.WebClient).DownloadString('https://raw.githubusercontent.com/chelnak/dotfiles/master/install.ps1'))
```

## Configure gpg
```PowerShell
keybase login
keybase pgp export | gpg --import
keybase pgp export --secret --unencrypted | gpg --allow-secret-key-import --import
```
