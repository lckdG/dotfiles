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

Invoke-Expression (& { (zoxide init powershell | Out-String) })

function PyEnv {
    param (
        [string]$Name
    )

    $filePath = "D:\pyenv\{0}\Scripts\Activate.ps1" -f $Name
    & $filePath
}

function yz {
	$tmp = (New-TemporaryFile).FullName
	yazi.exe @args --cwd-file="$tmp"
	$cwd = Get-Content -Path $tmp -Encoding UTF8
	if ($cwd -and $cwd -ne $PWD.Path -and (Test-Path -LiteralPath $cwd -PathType Container)) {
		Set-Location -LiteralPath (Resolve-Path -LiteralPath $cwd).Path
	}
	Remove-Item -Path $tmp
}

Set-Alias -Name pe -Value PyEnv
Set-Alias -Name lg -Value lazygit
Set-Alias -Name sdh -Value Stop-Computer
Set-Alias -Name sdr -Value Restart-Computer

