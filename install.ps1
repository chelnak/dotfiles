
$ErrorActionPreference = "Stop"
$TempFile = New-TemporaryFile
$Uri = "https://github.com/chelnak/dotfiles/archive/master.zip"
$DotFilesPath = "$ENV:USERPROFILE/.dotfiles"

try {

    Write-Host -Message " -> Downloading master repository.."
    Invoke-RestMethod -Method Get -Uri $Uri -OutFile $TempFile.FullName
    Remove-Item -Path $DotFilesPath -Recurse -Force -ErrorAction SilentlyContinue
    Expand-Archive -Path $TempFile.FullName -DestinationPath $DotFilesPath

    Move-Item -Path $DotFilesPath/dotfiles-master/* -Destination $DotFilesPath
    Remove-Item -Path $DotFilesPath/dotfiles-master -Force

    Write-Host -Message " -> Installing Psake.."
    Install-Module -Name Psake -Scope CurrentUser -Force

    Invoke-Psake -NoLogo -buildFile $DotFilesPath/psakefile.ps1

} catch {
    Write-Error -Message $_
}
