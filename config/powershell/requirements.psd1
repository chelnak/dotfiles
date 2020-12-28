@{
    PSDependOptions = @{
        Target = 'CurrentUser'
        Parameters = @{
            Repository = 'PSGallery'
        }
    }

    'Az' = 'latest'
    'psreadline' = @{
        AllowPreRelease = $true
    }
    'Microsoft.PowerShell.ConsoleGuiTools'  = 'latest'
}
