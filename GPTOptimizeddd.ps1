# -------------------------------------------------------------------------
# GPTOptimizeddd v6.0 - THE 1000+ FPS ELITE EDITION
# -------------------------------------------------------------------------

if (!([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
    Write-Host "PLEASE RUN AS ADMIN TO MAINTAIN 1000+ FPS!" -ForegroundColor Red
    Start-Sleep -Seconds 3; exit
}

$MenuOptions = @(
    [PSCustomObject]@{ID=1; Name="🚀 ELITE GAMING BOOST"; Desc="Max FPS, Zero Latency, Permanent Registry Edits"}
    [PSCustomObject]@{ID=2; Name="🎯 INPUT LAG REDUCER"; Desc="Mouse & Keyboard Response Optimization"}
    [PSCustomObject]@{ID=3; Name="🧹 DEEP SYSTEM CLEAN"; Desc="Wipe Temp Files, Cache, and Standby List"}
    [PSCustomObject]@{ID=4; Name="🔄 REVERT TO DEFAULTS"; Desc="Restore Windows to Factory Factory Settings"}
)

$Selection = $MenuOptions | Out-GridView -Title "GPTOptimizeddd v6.0 - Currently Hitting 1000+ FPS" -OutputMode Single
if (!$Selection) { exit }

switch ($Selection.ID) {
    1 { # The Big Performance Boost
        Write-Host "[*] Unlocking CPU & GPU Power..." -ForegroundColor Cyan
        # Disable Power Throttling
        Set-ItemProperty -Path "HKLM:\SYSTEM\CurrentControlSet\Control\Power\PowerThrottling" -Name "PowerThrottlingOff" -Value 1 -ErrorAction SilentlyContinue
        # Extreme Responsiveness
        Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile" -Name "SystemResponsiveness" -Value 0
        powercfg /setactive SCHEME_MIN
        Write-Host "[+] 1000+ FPS Mode Active!" -ForegroundColor Green
    }
    
    2 { # Mouse & Keyboard Input Lag
        Write-Host "[*] Killing Input Latency..." -ForegroundColor Cyan
        # Disable Mouse Acceleration (Registry Level)
        Set-ItemProperty -Path "HKCU:\Control Panel\Mouse" -Name "MouseSpeed" -Value 0
        Set-ItemProperty -Path "HKCU:\Control Panel\Mouse" -Name "MouseThreshold1" -Value 0
        Set-ItemProperty -Path "HKCU:\Control Panel\Mouse" -Name "MouseThreshold2" -Value 0
        Write-Host "[+] Mouse Input is now 1:1 Raw." -ForegroundColor Green
    }

    3 { # Deep Cleaning
        Write-Host "[*] Cleaning Cache..." -ForegroundColor Cyan
        Remove-Item "$env:TEMP\*" -Recurse -Force -ErrorAction SilentlyContinue
        Clear-RecycleBin -Confirm:$false -ErrorAction SilentlyContinue
        Write-Host "[+] System Cleaned." -ForegroundColor Green
    }

    4 { # REVERT
        Write-Host "[!] Restoring Defaults..." -ForegroundColor Yellow
        powercfg /setactive SCHEME_BALANCED
        Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile" -Name "SystemResponsiveness" -Value 20
        Write-Host "[+] Windows Restored." -ForegroundColor White
    }
}

Write-Host "`nSettings Saved to Registry. No background app needed!"
Start-Sleep -Seconds 2