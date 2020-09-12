#requires -Version 2 -Modules posh-git

function Get-Terraform {

    $Files = Get-ChildItem -Path $PWD -Filter "*.tf" -File -ErrorAction SilentlyContinue
    $Bin = Get-Command -Name terraform -ErrorAction SilentlyContinue

    if ($Files -and $Bin) {
        $Version = (terraform version).Split(" ")[1]

        if (!$Version.StartsWith("v")){
            $Version = "$((terraform version)[3].Split(" ")[1]) $($Sl.GitSymbols.BranchBehindStatusSymbol)"
        }

        return $Version
    }
}

function Get-CustomGitStatus {
    param(
        [PSCustomObject]$Status
    )

    $BranchName = $Status.Branch

    if ($Status.BehindBy -gt 0) {
        $BehindSymbol = $ThemeSettings.GitSymbols.BranchBehindStatusSymbol
    }

    if ($Status.AheadBy -gt 0){
        $AheadSymbol = $ThemeSettings.GitSymbols.BranchAheadStatusSymbol
    }

    if (($Status.AheadBy -eq 0) -and ($Status.BehindBy -eq 0)) {
        $IdenticalSymbol = $ThemeSettings.GitSymbols.BranchIdenticalStatusToSymbol
    }

    return "$BranchName $($BehindSymbol)$($AheadSymbol)$($IdenticalSymbol)".TrimEnd()
}

function Get-Kubernetes {
    $Bin = Get-Command -Name "kubectl" -ErrorAction SilentlyContinue

    if ($Bin) {
        $Namespace = kubectl config view --output 'jsonpath={..namespace}'
        return $Namespace
    }
}

function New-Block {
    Param(
        [Parameter()]
        [string]$Icon,
        [Parameter()]
        [Object]$IconForegroudColor = $Sl.Colors.PromptForegroundColor,
        [Parameter()]
        [string]$Content,
        [Parameter()]
        [Object]$ContentForegroundColor = $Sl.Colors.PromptForegroundColor
    )

    $Block += Write-Prompt -Object " [" -ForegroundColor $Sl.Colors.PromptHighlightColor
    $Block += Write-Prompt -Object "$($Icon)" -ForegroundColor $IconForegroudColor
    $Block += Write-Prompt -Object " $($Content)" -ForegroundColor $ContentForegroundColor
    $Block += Write-Prompt -Object "]" -ForegroundColor $Sl.Colors.PromptHighlightColor

    return $Block
}

function Get-PromptSpacing {
    if ($ENV:TERM_PROGRAM -eq "vscode"){
        $Spacing = "  "
    } else {
        $Spacing = " "
    }

    return $Spacing
}

function Write-Theme {
    param(
        [bool]$LastCommandFailed,
        [string]$With
    )

    $ENV:VIRTUAL_ENV_DISABLE_PROMPT = 1

    $PromtSymbolColor = $Sl.Colors.PromptSymbolColor
    if ($LastCommandFailed) {
        $PromtSymbolColor = $Sl.Colors.WithForegroundColor
    }

    # Writes the drive portion
    $Drive = "$($Sl.PromptSymbols.HomeSymbol) home"
    if ($Pwd.Path -ne $HOME) {
        $FullPath = (Get-FullPath -dir $pwd).Trim("$($Sl.PromptSymbols.HomeSymbol)$([System.IO.Path]::DirectorySeparatorChar)")
        $Drive = "$($Sl.PromptSymbols.HomeSymbol) $FullPath"
    }

    $Prompt += Write-Prompt -Object $Drive -ForegroundColor $Sl.Colors.DriveForegroundColor

    $Status = Get-VCSStatus
    if ($Status) {
        $Prompt += New-Block -Icon $Sl.GitSymbols.BranchSymbol -Content (Get-CustomGitStatus -Status $Status)
    }

    if (Test-VirtualEnv) {
        $Prompt += New-Block -Icon $Sl.PromptSymbols.VirtualEnvSymbol -Content (Get-VirtualEnvName)
    }

    $TerraformVersion = Get-Terraform
    if ($TerraformVersion) {
        $Prompt += New-Block -Icon $Sl.PromptSymbols.TerraformSymbol -Content $TerraformVersion
    }

    $Kubernetes = Get-Kubernetes
    if ($Kubernetes) {
        $Prompt += New-Block -Icon $Sl.PromptSymbols.KubernetesSymbol -Content $Kubernetes
    }

    $TimeStamp = Get-Date -Format T
    $Prompt += Set-CursorForRightBlockWrite -TextLength $Timestamp.Length
    $Prompt += Write-Prompt $TimeStamp -ForegroundColor $Sl.Colors.PromptTimeColor

    $Prompt += Set-Newline
    $Prompt += Write-Prompt -Object $Sl.PromptSymbols.PromptIndicator -ForegroundColor $PromtSymbolColor

    $Prompt += Get-PromptSpacing

    $Prompt
}

$Sl = $GLOBAL:ThemeSettings

# --- General
$Sl.PromptSymbols.PromptIndicator = [char]::ConvertFromUtf32(0x279C)
$Sl.PromptSymbols.HomeSymbol = "💀"
$Sl.Colors.PromptTimeColor = [ConsoleColor]::Gray

$Sl.Colors.PromptForegroundColor = [ConsoleColor]::DarkYellow
$Sl.Colors.PromptSymbolColor = [ConsoleColor]::Green
$Sl.Colors.PromptHighlightColor = [ConsoleColor]::Blue
$Sl.Colors.DriveForegroundColor = [ConsoleColor]::Cyan
$Sl.Colors.WithForegroundColor = [ConsoleColor]::Red

# --- Git
$Sl.PromptSymbols.GitDirtyIndicator = [char]::ConvertFromUtf32(10007)
$Sl.Colors.GitDefaultColor = [ConsoleColor]::DarkYellow

# --- Virtual Env
$Sl.Colors.VirtualEnvForegroundColor = [ConsoleColor]::DarkYellow

# ---Terraform
$Sl.PromptSymbols.TerraformSymbol = [char]::ConvertFromUtf32(0xe5fc)
$SL.Colors.TerraformForegroundColor = [ConsoleColor]::DarkYellow

$Sl.PromptSymbols.KubernetesSymbol = [char]::ConvertFromUtf32(0xfd31)
$Sl.Colors.KubernetesSymbolForegroundColor = [ConsoleColor]::White
$Sl.Colors.KubernetesSymbolBackgroundColor = [ConsoleColor]::Blue
$SL.Colors.KubernetesForegroundColor = [ConsoleColor]::DarkYellow
