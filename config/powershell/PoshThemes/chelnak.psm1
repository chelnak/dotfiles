#requires -Version 2 -Modules posh-git

function Get-Terraform {

    $Files = Get-ChildItem -Path $PWD -Filter "*.tf" -File -ErrorAction SilentlyContinue
    $Bin = Get-Command -Name terraform -ErrorAction SilentlyContinue

    if ($Files -and $Bin) {
        $Version = (terraform version).Split(" ")[1]
        return $Version
    }
}

function Get-CustomGitStatus {
    param(
        [PSCustomObject]$Status
    )

    $BranchSymbol = $ThemeSettings.GitSymbols.BranchSymbol
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

    return "$BranchSymbol $BranchName $($BehindSymbol)$($AheadSymbol)$($IdenticalSymbol)".TrimEnd()
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
        $FullPath = (Get-FullPath -dir $pwd).Remove(0,3)
        $Drive = "$($Sl.PromptSymbols.HomeSymbol) $FullPath"
    }
    $Prompt += Write-Prompt -Object $Drive -ForegroundColor $Sl.Colors.DriveForegroundColor

    $Status = Get-VCSStatus
    if ($Status) {
        $Prompt += Write-Prompt -Object " [" -ForegroundColor $Sl.Colors.PromptHighlightColor
        $prompt += Write-Prompt -Object (Get-CustomGitStatus -Status $Status) -ForegroundColor $Sl.Colors.GitDefaultColor
        $prompt += Write-Prompt -Object "]" -ForegroundColor $sl.Colors.PromptHighlightColor
    }

    if (Test-VirtualEnv) {
        $Prompt += Write-Prompt -Object " [" -ForegroundColor $sl.Colors.PromptHighlightColor
        $Prompt += Write-Prompt -Object "$($Sl.PromptSymbols.VirtualEnvSymbol)" -ForegroundColor $Sl.Colors.VirtualEnvForegroundColor
        $Prompt += Write-Prompt -Object " $(Get-VirtualEnvName)" -ForegroundColor $Sl.Colors.VirtualEnvForegroundColor
        $Prompt += Write-Prompt -Object "]" -ForegroundColor $sl.Colors.PromptHighlightColor
    }

    $TerraformVersion = Get-Terraform
    if ($TerraformVersion) {
        $Prompt += Write-Prompt -Object " [" -ForegroundColor $sl.Colors.PromptHighlightColor
        $Prompt += Write-Prompt -Object "$($Sl.PromptSymbols.TerraformSymbol)" -ForegroundColor $sl.Colors.PromptForegroundColor
        $Prompt += Write-Prompt -Object " $TerraformVersion" -ForegroundColor $sl.Colors.PromptForegroundColor
        $Prompt += Write-Prompt -Object "]" -ForegroundColor $sl.Colors.PromptHighlightColor
    }

    $TimeStamp = Get-Date -Format T
    $Prompt += Set-CursorForRightBlockWrite -TextLength $Timestamp.Length
    $Prompt += Write-Prompt $TimeStamp -ForegroundColor [ConsoleColor]::DarkGray

    $Prompt += Set-Newline
    $Prompt += Write-Prompt -Object $Sl.PromptSymbols.PromptIndicator -ForegroundColor $PromtSymbolColor

    if ($ENV:TERM_PROGRAM -eq "vscode"){
        $Prompt += "  "
    } else {
        $Prompt += " "
    }

    $Prompt
}

$Sl = $GLOBAL:ThemeSettings #local settings

# # General
$Sl.PromptSymbols.PromptIndicator = [char]::ConvertFromUtf32(0x279C) #[char]::ConvertFromUtf32(0x26A1)
$Sl.PromptSymbols.HomeSymbol = '🏠'

# $Sl.Colors.PromptForegroundColor = [ConsoleColor]::DarkYellow
$Sl.Colors.PromptSymbolColor = [ConsoleColor]::Green
$Sl.Colors.PromptHighlightColor = [ConsoleColor]::Blue
$Sl.Colors.DriveForegroundColor = [ConsoleColor]::Cyan
$Sl.Colors.WithForegroundColor = [ConsoleColor]::Red

# # Git
$Sl.PromptSymbols.GitDirtyIndicator = [char]::ConvertFromUtf32(10007)
$Sl.Colors.GitDefaultColor = [ConsoleColor]::DarkYellow

# # Virtual Env
$Sl.Colors.VirtualEnvForegroundColor = [ConsoleColor]::DarkYellow

# Terraform
$Sl.PromptSymbols.TerraformSymbol = [char]::ConvertFromUtf32(0xf668)
