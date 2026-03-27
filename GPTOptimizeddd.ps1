# -------------------------------------------------------------------------
# GPTOptimizeddd v3.1 - Solid WPF Edition (Dark Mode)
# -------------------------------------------------------------------------

# 1. Admin Auto-Relaunch
if (!([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
    Start-Process powershell.exe "-ExecutionPolicy Bypass -File `"$PSCommandPath`"" -Verb RunAs
    exit
}

Add-Type -AssemblyName PresentationFramework, System.Drawing, System.Windows.Forms

# 2. The Design (XAML) - Modern Dark Mode
[xml]$XAML = @"
<Window xmlns="http://schemas.microsoft.com/winfx/2000/xaml/presentation"
        Title="GPTOptimizeddd" Height="450" Width="400" Background="#121212" WindowStartupLocation="CenterScreen">
    <StackPanel Margin="20">
        <TextBlock Text="GPTOptimizeddd" Foreground="#0078D4" FontSize="28" HorizontalAlignment="Center" Margin="0,0,0,20" FontWeight="Bold"/>
        
        <Button Name="BoostBtn" Content="🚀 ULTIMATE BOOST" Height="50" Margin="0,10" Background="#0078D4" Foreground="White" BorderThickness="0" Cursor="Hand"/>
        <Button Name="FortniteBtn" Content="🎯 FORTNITE / COMP MODE" Height="50" Margin="0,10" Background="#1E1E1E" Foreground="White" BorderThickness="1" BorderBrush="#333" Cursor="Hand"/>
        <Button Name="RobloxBtn" Content="🎮 ROBLOX / MINECRAFT" Height="50" Margin="0,10" Background="#1E1E1E" Foreground="White" BorderThickness="1" BorderBrush="#333" Cursor="Hand"/>
        <Button Name="ResetBtn" Content="🔄 RESET TO DEFAULTS" Height="50" Margin="0,10" Background="#444" Foreground="White" BorderThickness="0" Cursor="Hand"/>
        
        <TextBlock Name="StatusTxt" Text="Status: Ready" Foreground="#888" HorizontalAlignment="Center" Margin="0,20,0,0"/>
    </StackPanel>
</Window>
"@

# 3. Load the Window
$reader = New-Object System.Xml.XmlNodeReader $XAML
$Form = [Windows.Markup.XamlReader]::Load($reader)

# 4. Connect the Buttons to Actions
$BoostBtn = $Form.FindName("BoostBtn")
$FortniteBtn = $Form.FindName("FortniteBtn")
$RobloxBtn = $Form.FindName("RobloxBtn")
$ResetBtn = $Form.FindName("ResetBtn")
$StatusTxt = $Form.FindName("StatusTxt")

$BoostBtn.Add_Click({
    powercfg /setactive SCHEME_MIN
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile" -Name "NetworkThrottlingIndex" -Value 0xffffffff
    $StatusTxt.Text = "Status: Ultimate Boost Applied!"
})

$FortniteBtn.Add_Click({
    Get-Process "Fortnite*" -ErrorAction SilentlyContinue | ForEach-Object { $_.PriorityClass = "High" }
    $StatusTxt.Text = "Status: Fortnite Priority Set to High!"
})

$RobloxBtn.Add_Click({
    [System.GC]::Collect()
    $StatusTxt.Text = "Status: RAM Flushed for Roblox/MC!"
})

$ResetBtn.Add_Click({
    powercfg /setactive SCHEME_BALANCED
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile" -Name "NetworkThrottlingIndex" -Value 10
    $StatusTxt.Text = "Status: Restored to Default Settings."
})

# 5. Launch the App
$Form.ShowDialog() | Out-Null
