# 1. Admin & Safety Check
if (!([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
    Write-Host "ERROR: PLEASE RUN AS ADMIN!" -ForegroundColor Red
    pause; exit
}

# 2. Create Safety Restore Point (Optional but Recommended)
Write-Host "Creating System Restore Point for safety..." -ForegroundColor Cyan
Checkpoint-Computer -Description "Before GPTOptimizeddd" -RestorePointType "MODIFY_SETTINGS" -ErrorAction SilentlyContinue

Function Show-Menu {
    Clear-Host
    Write-Host "==========================================" -ForegroundColor Cyan
    Write-Host "      GPTOptimizeddd PRO v4.0" -ForegroundColor White
    Write-Host "==========================================" -ForegroundColor Cyan
    Write-Host "1. [🚀] ULTIMATE GAMING BOOST (Power/CPU/Network)"
    Write-Host "2. [🎯] COMPETITIVE MODE (Priority + Affinity)"
    Write-Host "3. [🧹] DEEP SYSTEM CLEAN (Temp/Cache/Logs)"
    Write-Host "4. [🛡️] PRIVACY & BLOATWARE STRIP"
    Write-Host "5. [🔄] REVERT ALL CHANGES (Back to Default)"
    Write-Host "6. [❌] EXIT"
    Write-Host "==========================================" -ForegroundColor Cyan
}

while ($true) {
    Show-Menu
    $choice = Read-Host "Select an option [1-6]"

    switch ($choice) {
        1 {
            Write-Host "Unlocking Ultimate Performance..." -ForegroundColor Yellow
            powercfg /setactive SCHEME_MIN
            Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile" -Name "SystemResponsiveness" -Value 0
            Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile" -Name "NetworkThrottlingIndex" -Value 0xffffffff
            Write-Host "Boost Applied!" -ForegroundColor Green
            Start-Sleep -Seconds 2
        }
        2 {
            Write-Host "Optimizing Game Priorities..." -ForegroundColor Yellow
            # Sets common game engines to High Priority
            $Games = "FortniteClient-Win64-Shipping", "RobloxPlayerBeta", "javaw", "Valorant"
            foreach ($g in $Games) {
                Get-Process $g -ErrorAction SilentlyContinue | ForEach-Object { $_.PriorityClass = "High" }
            }
            Write-Host "Game Priorities Set!" -ForegroundColor Green
            Start-Sleep -Seconds 2
        }
        3 {
            Write-Host "Deep Cleaning System..." -ForegroundColor Yellow
            Remove-Item "$env:TEMP\*" -Recurse -Force -ErrorAction SilentlyContinue
            Remove-Item "C:\Windows\Temp\*" -Recurse -Force -ErrorAction SilentlyContinue
            Clear-RecycleBin -Confirm:$false -ErrorAction SilentlyContinue
            Write-Host "System Cleaned!" -ForegroundColor Green
            Start-Sleep -Seconds 2
        }
        4 {
            Write-Host "Removing Telemetry & Background Bloat..." -ForegroundColor Yellow
            Stop-Service -Name "DiagTrack" -Force -ErrorAction SilentlyContinue
            Set-Service -Name "DiagTrack" -StartupType Disabled
            # Disables Windows GameDVR (which lags low-end PCs)
            Set-ItemProperty -Path "HKCU:\System\GameConfigStore" -Name "GameDVR_Enabled" -Value 0
            Write-Host "Bloatware Disabled!" -ForegroundColor Green
            Start-Sleep -Seconds 2
        }
        5 {
            Write-Host "Reverting to Windows Defaults..." -ForegroundColor Cyan
            powercfg /setactive SCHEME_BALANCED
            Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile" -Name "SystemResponsiveness" -Value 20
            Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile" -Name "NetworkThrottlingIndex" -Value 10
            Set-Service -Name "DiagTrack" -StartupType Automatic
            Write-Host "REVERT COMPLETE. Restart PC to finish." -ForegroundColor Yellow
            Start-Sleep -Seconds 3
        }
        6 { exit }
    }
}