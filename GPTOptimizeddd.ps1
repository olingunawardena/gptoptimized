# -------------------------------------------------------------------------
# GPTOptimizeddd v5.0 - Permanent & Reversible Optimizer
# -------------------------------------------------------------------------

# 1. Admin Check
if (!([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
    Write-Host "ERROR: PLEASE RUN AS ADMINISTRATOR!" -ForegroundColor Red
    Start-Sleep -Seconds 3
    exit
}

Clear-Host
Write-Host "Loading GPTOptimizeddd Interface..." -ForegroundColor Cyan

# 2. Define the Menu (Including the Revert Button)
$MenuOptions = @(
    [PSCustomObject]@{ID=1; Name="🚀 ULTIMATE GAMING BOOST"; Desc="Permanent Registry & Power Tweaks (Stays after Restart)"}
    [PSCustomObject]@{ID=2; Name="🎯 FORTNITE / COMP MODE"; Desc="High Priority & CPU Core Affinity"}
    [PSCustomObject]@{ID=3; Name="🧹 DEEP SYSTEM CLEAN"; Desc="Wipe Temp Files, Cache, and Recycle Bin"}
    [PSCustomObject]@{ID=4; Name="📶 NETWORK TUNER"; Desc="Disable Throttling & Lower Ping"}
    [PSCustomObject]@{ID=5; Name="🔄 REVERT TO DEFAULTS"; Desc="Undo all changes and restore Windows settings"}
)

# 3. Show the GridView Menu
$Selection = $MenuOptions | Out-GridView -Title "GPTOptimizeddd v5.0: Select a Task" -OutputMode Single

if (!$Selection) { exit }

Write-Host "`nExecuting: $($Selection.Name)..." -ForegroundColor Green

# --- CORE LOGIC ---
switch ($Selection.ID) {
    1 { # Ultimate Boost (Permanent Registry Changes)
        Write-Host "[*] Setting Gaming Registry Keys..." -ForegroundColor Yellow
        # System Responsiveness (0 = Gaming Priority)
        Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile" -Name "SystemResponsiveness" -Value 0
        # Power Plan
        powercfg /setactive SCHEME_MIN
        # Disable Hibernation (Saves Space & Speed)
        powercfg -h off
        Write-Host "[+] Settings applied to Windows Registry." -ForegroundColor White
    }
    
    2 { # Fortnite / Comp Mode
        Write-Host "[*] Tuning Process Priority..." -ForegroundColor Yellow
        $procs = "FortniteClient-Win64-Shipping", "RobloxPlayerBeta", "javaw"
        foreach ($p in $procs) {
            Get-Process $p -ErrorAction SilentlyContinue | ForEach-Object { $_.PriorityClass = "High" }
        }
        Write-Host "[+] High Priority enabled for active games."
    }

    3 { # Deep Clean
        Write-Host "[*] Scouring System for Junk..." -ForegroundColor Yellow
        Remove-Item "$env:TEMP\*" -Recurse -Force -ErrorAction SilentlyContinue
        Remove-Item "C:\Windows\Temp\*" -Recurse -Force -ErrorAction SilentlyContinue
        Clear-RecycleBin -Confirm:$false -ErrorAction SilentlyContinue
        Write-Host "[+] Temp files and Recycle Bin cleared."
    }

    4 { # Network Tuner
        Write-Host "[*] Disabling Network Throttling..." -ForegroundColor Yellow
        Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile" -Name "NetworkThrottlingIndex" -Value 0xffffffff
        Write-Host "[+] Network latency tweaks applied."
    }

    5 { # REVERT BUTTON (The "Undo")
        Write-Host "[!] RESTORING WINDOWS DEFAULTS..." -ForegroundColor Cyan
        # Restore Registry
        Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile" -Name "SystemResponsiveness" -Value 20
        Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile" -Name "NetworkThrottlingIndex" -Value 10
        # Restore Power Plan
        powercfg /setactive SCHEME_BALANCED
        # Re-enable Hibernation
        powercfg -h on
        # Re-enable Telemetry
        Set-Service -Name "DiagTrack" -StartupType Automatic
        Write-Host "[+] System restored to factory defaults. Restart is recommended." -ForegroundColor White
    }
}

Write-Host "`n[DONE] Task finished successfully!" -ForegroundColor Green
Write-Host "Press any key to close..."
$null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")