
$ErrorActionPreference = "Stop"
$TempFile = New-TemporaryFile
$Uri = "https://github.com/chelnak/dotfiles/archive/master.zip"
$ApiUri = "https://api.github.com/repos/chelnak/dotfiles/commits/master"
$DotFilesPath = "$ENV:USERPROFILE/.dotfiles"

try {

    Write-Host -Message " -> Downloading master repository.."
    Invoke-RestMethod -Method Get -Uri $Uri -OutFile $TempFile.FullName
    Remove-Item -Path $DotFilesPath -Recurse -Force -ErrorAction SilentlyContinue
    Expand-Archive -Path $TempFile.FullName -DestinationPath $DotFilesPath

    Move-Item -Path $DotFilesPath/dotfiles-master/* -Destination $DotFilesPath -Force
    Remove-Item -Path $DotFilesPath/dotfiles-master -Force

    Write-Host -Message " -> Installing Psake.."
    Install-Module -Name Psake -Scope CurrentUser -Force

    $LatestCommit = Invoke-RestMethod -Method Get -Uri $ApiUri
    $LatestCommit.sha | Set-Content -Path $DotFilesPath/.latest -Force

    Invoke-Psake -NoLogo -buildFile $DotFilesPath/psakefile.ps1

    Write-Host -Message "Set latest sha to: $($LatestCommit.sha)"

} catch {
    Write-Error -Message $_
}
