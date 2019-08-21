$SOURCE="https://github.com/chelnak/dotfiles"
$TARGET="$ENV:USERPROFILE\.dotfiles"

if ((Test-Path -Path $TARGET)) {
    Write-Host "Updating dotfiles"
    Set-Location $TARGET
    git pull
} else {
    Write-Host "Installing dotfiles"
    git clone $SOURCE $TARGET

}
