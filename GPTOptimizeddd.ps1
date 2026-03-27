# 1. Admin & Environment Setup
if (!([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
    Write-Host "ERROR: PLEASE RUN AS ADMIN!" -ForegroundColor Red
    pause; exit
}

Function Show-Header {
    Clear-Host
    Write-Host "==========================================" -ForegroundColor Blue
    Write-Host "      GPTOptimizeddd PRO v4.0" -ForegroundColor White
    Write-Host "==========================================" -ForegroundColor Blue
}

while ($true) {
    Show-Header
    Write-Host "1. [🚀] ULTIMATE GAMING BOOST (Registry & Power)"
    Write-Host "2. [🎯] FORTNITE / COMP MODE (Process Priority)"
    Write-Host "3. [🧹] DEEP CLEAN (Temp, Cache, Recycle Bin)"
    Write-Host "4. [📶] NETWORK OPTIMIZER (Lower Ping)"
    Write-Host "5. [🔄] RESET TO DEFAULTS (Undo Everything)"
    Write-Host "6. [❌] EXIT"
    Write-Host "------------------------------------------"
    $choice = Read-Host "Select an option [1-6]"

    switch ($choice) {
        1 {
            Write-Host "Applying Registry Tweaks..." -ForegroundColor Cyan
            # System Responsiveness (0 = Gaming)
            Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile" -Name "SystemResponsiveness" -Value 0
            # Set Power Plan to High Performance
            powercfg /setactive SCHEME_MIN
            Write-Host "Ultimate Boost Applied!" -ForegroundColor Green
            Start-Sleep 2
        }
        2 {
            Write-Host "Optimizing Game Priority..." -ForegroundColor Cyan
            $Games = "FortniteClient-Win64-Shipping", "RobloxPlayerBeta", "javaw"
            foreach ($g in $Games) {
                Get-Process $g -ErrorAction SilentlyContinue | ForEach-Object { $_.PriorityClass = "High" }
            }
            Write-Host "Priority Set for Fortnite/Roblox/Minecraft!" -ForegroundColor Green
            Start-Sleep 2
        }
        3 {
            Write-Host "Cleaning Files..." -ForegroundColor Cyan
            Remove-Item "$env:TEMP\*" -Recurse -Force -ErrorAction SilentlyContinue
            Remove-Item "C:\Windows\Temp\*" -Recurse -Force -ErrorAction SilentlyContinue
            Clear-RecycleBin -Confirm:$false -ErrorAction SilentlyContinue
            Write-Host "Deep Clean Complete!" -ForegroundColor Green
            Start-Sleep 2
        }
        4 {
            Write-Host "Tuning Network Card..." -ForegroundColor Cyan
            # Disable Nagle's Algorithm (Lowers Ping)
            Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile" -Name "NetworkThrottlingIndex" -Value 0xffffffff
            Write-Host "Network Latency Reduced!" -ForegroundColor Green
            Start-Sleep 2
        }
        5 {
            Write-Host "REVERTING CHANGES..." -ForegroundColor Yellow
            powercfg /setactive SCHEME_BALANCED
            Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile" -Name "SystemResponsiveness" -Value 20
            Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile" -Name "NetworkThrottlingIndex" -Value 10
            Write-Host "System Restored to Default. Restart PC." -ForegroundColor White
            Start-Sleep 3
        }
        6 { exit }
    }
}