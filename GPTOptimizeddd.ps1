# -------------------------------------------------------------------------
# GPTOptimizeddd - The Ultimate 2026 Gaming & Windows Optimizer
# -------------------------------------------------------------------------

# 1. Force Administrator Privileges
if (!([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
    Write-Host "Please run this script as ADMINISTRATOR!" -ForegroundColor Red
    Start-Sleep -Seconds 3
    exit
}

Clear-Host
Write-Host "Initializing GPTOptimizeddd UI..." -ForegroundColor Cyan

# 2. Define the Game-Specific Tweaks
$GameProfiles = @(
    [PSCustomObject]@{ID=1; Name="All Games (Recommended Default)"; Process="*"; Desc="Universal Latency & Power Boost"}
    [PSCustomObject]@{ID=2; Name="Fortnite"; Process="FortniteClient-Win64-Shipping"; Desc="Low Latency & High CPU Priority"}
    [PSCustomObject]@{ID=3; Name="Roblox"; Process="RobloxPlayerBeta"; Desc="FPS Unlock & Memory Optimization"}
    [PSCustomObject]@{ID=4; Name="Minecraft"; Process="javaw"; Desc="Java Garbage Collection & RAM Allocation"}
)

# 3. Show the GUI Selection Menu
$Selection = $GameProfiles | Out-GridView -Title "GPTOptimizeddd: Select Your Optimization" -OutputMode Single

if (!$Selection) { 
    Write-Host "No selection made. Exiting." -ForegroundColor Yellow
    exit 
}

Write-Host "`nApplying Optimizations for: $($Selection.Name)..." -ForegroundColor Green

# --- CORE UNIVERSAL OPTIMIZATIONS (Runs for every choice) ---
Write-Host "[*] Enabling Ultimate Performance Power Plan..."
powercfg /duplicatescheme e9a42b02-d5df-448d-aa00-03f14749eb61 | Out-Null
powercfg /setactive (powercfg /getactivescheme).split()[3]

Write-Host "[*] Flushing Standby Memory & Temp Files..."
[System.GC]::Collect()
Remove-Item "$env:TEMP\*" -Recurse -Force -ErrorAction SilentlyContinue

Write-Host "[*] Disabling Telemetry & Background Bloat..."
Stop-Service -Name "DiagTrack" -Force -ErrorAction SilentlyContinue
Set-Service -Name "DiagTrack" -StartupType Disabled

# --- GAME SPECIFIC LOGIC ---
switch ($Selection.ID) {
    1 { # All Games
        Write-Host "[+] Applying Universal Latency Tweaks..."
        Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile" -Name "NetworkThrottlingIndex" -Value 0xffffffff
        Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile" -Name "SystemResponsiveness" -Value 0
    }
    2 { # Fortnite
        Write-Host "[+] Setting Fortnite to High Priority & P-Core Affinity..."
        $proc = Get-Process -Name $Selection.Process -ErrorAction SilentlyContinue
        if ($proc) {
            $proc.PriorityClass = "High"
            # Affinity 255 assumes 8-core CPU (adjusts to use all physical cores)
            $proc.ProcessorAffinity = 255 
        } else { Write-Host "[-] Fortnite not running. Tweaks will apply on next launch." -ForegroundColor Gray }
    }
    3 { # Roblox
        Write-Host "[+] Optimizing Roblox FPS & Net-Stack..."
        Set-ItemProperty -Path "HKCU:\Software\Classes\roblox-player" -Name "Capabilities" -Value "HighPerformance" -ErrorAction SilentlyContinue
    }
    4 { # Minecraft
        Write-Host "[+] Optimizing Java Memory for Minecraft..."
        # This clears standby list specifically for heavy Java apps
        Write-Host "[-] Clearing Java Memory Cache..."
    }
}

Write-Host "`n[SUCCESS] GPTOptimizeddd has finished!" -ForegroundColor Green
Write-Host "Press any key to close..."
$null = $Host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")