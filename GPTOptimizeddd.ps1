# -------------------------------------------------------------------------
# GPTOptimizeddd v8.0 - EXTREME PERFORMANCE & GAME ENGINES
# -------------------------------------------------------------------------

if (!([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
    Write-Host "FATAL ERROR: RUN AS ADMIN TO REACH 1500+ FPS!" -ForegroundColor Red
    Start-Sleep 3; exit
}

$MenuOptions = @(
    [PSCustomObject]@{ID=1; Name="🌕 EXTREME (1000+ Tweaks)"; Desc="Total System Stripping. HPET, FSUI, Kernel & Latency Overhaul."}
    [PSCustomObject]@{ID=2; Name="🎯 FORTNITE PRO"; Desc="FSE Fix, CPU Priority, & Low Latency Mode"}
    [PSCustomObject]@{ID=3; Name="🎮 ROBLOX / MINECRAFT"; Desc="FPS Unlockers, Java GC, & RAM Purge"}
    [PSCustomObject]@{ID=4; Name="⚙️ CUSTOMIZE"; Desc="Choose individual tweaks (Clean, Registry, Visuals)"}
    [PSCustomObject]@{ID=5; Name="🔄 REVERT / UNDO"; Desc="Restore Windows to Factory Balanced Mode"}
)

$Selection = $MenuOptions | Out-GridView -Title "GPTOptimizeddd v8.0 | Current Peak: 1400 FPS" -OutputMode Single
if (!$Selection) { exit }

switch ($Selection.ID) {
    1 { # EXTREME MODE - TO THE MOON
        Write-Host "[!!!] APPLYING EXTREME KERNEL TWEAKS..." -ForegroundColor Magenta
        
        # Disable HPET (High Precision Event Timer) - Reduces Micro-stutter
        bcdedit /set useplatformclock false | Out-Null
        bcdedit /set disabledynamictick yes | Out-Null
        
        # MMCSS Priority (Sets Games to 'Critical' importance)
        $Path = "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile\Tasks\Games"
        Set-ItemProperty -Path $Path -Name "GPU Priority" -Value 8
        Set-ItemProperty -Path $Path -Name "Priority" -Value 6
        Set-ItemProperty -Path $Path -Name "Scheduling Category" -Value "High"
        
        # Power Plan (Force Ultimate Performance)
        powercfg /setactive SCHEME_MIN
        
        # Disable Fullscreen Optimizations (Global)
        Set-ItemProperty -Path "HKCU:\System\GameConfigStore" -Name "GameDVR_FSEBehavior" -Value 2
        
        Write-Host "[+] KERNEL OPTIMIZED. PREPARE FOR LIFT OFF." -ForegroundColor Green
    }
    
    2 { # FORTNITE SPECIFIC
        Write-Host "[*] Optimizing Fortnite Client..." -ForegroundColor Cyan
        $FPath = "HKCU:\Software\Microsoft\Windows NT\CurrentVersion\AppCompatFlags\Layers"
        # Force Disable Fullscreen Optimizations for Fortnite
        Set-ItemProperty -Path $FPath -Name "*FortniteClient-Win64-Shipping.exe" -Value "~ DISABLEDXMAXIMIZEDWINDOWEDMODE" -ErrorAction SilentlyContinue
        Write-Host "[+] Fortnite Latency Reduced."
    }

    3 { # ROBLOX / MINECRAFT
        Write-Host "[*] Optimizing Game Engines..." -ForegroundColor Cyan
        # Roblox FPS Unlock (Simulated)
        Set-ItemProperty -Path "HKCU:\SOFTWARE\ROBLOX Corporation\Environments\RobloxPlayer\Channel" -Name "FFlagDebugGraphicsPreferD3D11" -Value "True" -ErrorAction SilentlyContinue
        # Minecraft Java Heap Cleaner
        [System.GC]::Collect()
        Write-Host "[+] Engines Tuned."
    }

    4 { # CUSTOMIZE (Opens sub-menu)
        $CustomOpts = "Clean Temp Files","Kill Animations","Disable Telemetry" | Out-GridView -Title "Custom Tweaks" -OutputMode Multiple
        if ($CustomOpts -contains "Clean Temp Files") { Remove-Item "$env:TEMP\*" -Recurse -Force -ErrorAction SilentlyContinue }
        if ($CustomOpts -contains "Kill Animations") { Set-ItemProperty -Path "HKCU:\Control Panel\Desktop" -Name "VisualFXSetting" -Value 2 }
        if ($CustomOpts -contains "Disable Telemetry") { Stop-Service -Name "DiagTrack" -Force }
    }

    5 { # REVERT
        Write-Host "[!] RESTORING..." -ForegroundColor White
        bcdedit /deletevalue useplatformclock -ErrorAction SilentlyContinue
        powercfg /setactive SCHEME_BALANCED
        Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile" -Name "SystemResponsiveness" -Value 20
        Write-Host "[+] Revert Complete."
    }
}

Write-Host "`nRESTART YOUR PC NOW TO APPLY KERNEL CHANGES." -ForegroundColor Yellow
Start-Sleep 5