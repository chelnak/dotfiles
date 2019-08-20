$CurrentTitle = $Host.UI.RawUI.WindowTitle
$Host.UI.RawUI.WindowTitle =  "Loading Az ..."

$SubScriptionName = (Get-AzContext).Subscription.Name

if ($SubScriptionName) {
    $WindowTitle = "PowerShell | Az - [$($SubscriptionName)]"
} else {
    $WindowTitle = $CurrentTitle
}

$Host.UI.RawUI.WindowTitle =  $WindowTitle

function Prompt {

    $IsElevated = ([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")
    if ($IsElevated) {
        Write-Host "$([char]9788) " -ForegroundColor Red -NoNewline
    }else {
        Write-Host "$([char]9788) " -ForegroundColor Yellow -NoNewline
    }
    Write-Host 'Craig ' -ForegroundColor Green -NoNewline
    Write-Host "[$((Get-Location).path)]" -NoNewline
    Write-Host
    Write-Output '# ' 

}

Set-Location -Path $ENV:USERPROFILE/code -ErrorAction stop
