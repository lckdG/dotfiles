$prompt = ""
function Invoke-Starship-PreCommand {
    $current_location = $executionContext.SessionState.Path.CurrentLocation
        if ($current_location.Provider.Name -eq "FileSystem") {
            $ansi_escape = [char]27
                $provider_path = $current_location.ProviderPath -replace "\\", "/"
                $prompt = "$ansi_escape]7;file://${env:COMPUTERNAME}/${provider_path}$ansi_escape\"
        }
    $host.ui.Write($prompt)
}

Invoke-Expression (&starship init powershell)

function PyEnv {
    param (
        [string]$Name
    )

    $filePath = "D:\pyenv\{0}\Scripts\Activate.ps1" -f $Name
    & $filePath
}

Set-Alias -Name pe -Value PyEnv
Set-Alias -Name lg -Value lazygit
Set-Alias -Name sdh -Value Stop-Computer
Set-Alias -Name sdr -Value Restart-Computer

