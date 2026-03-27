# 1. Force Load Assemblies immediately
Add-Type -AssemblyName PresentationFramework
Add-Type -AssemblyName PresentationCore
Add-Type -AssemblyName WindowsBase

# 2. Admin Auto-Relaunch
if (!([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
    Start-Process powershell.exe "-ExecutionPolicy Bypass -File `"$PSCommandPath`"" -Verb RunAs
    exit
}

# 3. The Design (Clean Dark Mode)
$inputXML = @"
<Window xmlns="http://schemas.microsoft.com/winfx/2000/xaml/presentation"
        Title="GPTOptimizeddd" Height="450" Width="400" Background="#121212" WindowStartupLocation="CenterScreen" ResizeMode="NoResize">
    <StackPanel Margin="20">
        <TextBlock Text="GPTOptimizeddd" Foreground="#0078D4" FontSize="28" HorizontalAlignment="Center" Margin="0,0,0,20" FontWeight="Bold"/>
        
        <Button Name="BoostBtn" Content="🚀 ULTIMATE BOOST" Height="50" Margin="0,10" Background="#0078D4" Foreground="White" BorderThickness="0"/>
        <Button Name="FortniteBtn" Content="🎯 FORTNITE / COMP MODE" Height="50" Margin="0,10" Background="#1E1E1E" Foreground="White" BorderThickness="1" BorderBrush="#333"/>
        <Button Name="RobloxBtn" Content="🎮 ROBLOX / MINECRAFT" Height="50" Margin="0,10" Background="#1E1E1E" Foreground="White" BorderThickness="1" BorderBrush="#333"/>
        <Button Name="ResetBtn" Content="🔄 RESET TO DEFAULTS" Height="50" Margin="0,10" Background="#444" Foreground="White" BorderThickness="0"/>
        
        <TextBlock Name="StatusTxt" Text="Status: Ready" Foreground="#888" HorizontalAlignment="Center" Margin="0,20,0,0"/>
    </StackPanel>
</Window>
"@

# 4. Corrected XAML Loading Logic
$inputXML = $inputXML -replace 'mc:Ignorable="d"','' -replace "x:N",'N' -replace '^<Win.*', '<Window '
[xml]$XAML = $inputXML
$reader = New-Object System.Xml.XmlNodeReader $XAML
try {
    $Form = [Windows.Markup.XamlReader]::Load($reader)
} catch {
    Write-Host "UI Failed to load. Check if your Windows version supports WPF." -ForegroundColor Red
    pause; exit
}

# 5. Connect the UI to PowerShell
$BoostBtn = $Form.FindName("BoostBtn")
$FortniteBtn = $Form.FindName("FortniteBtn")
$RobloxBtn = $Form.FindName("RobloxBtn")
$ResetBtn = $Form.FindName("ResetBtn")
$StatusTxt = $Form.FindName("StatusTxt")

# Action Functions
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
    $StatusTxt.Text = "Status: RAM Flushed!"
})

$ResetBtn.Add_Click({
    powercfg /setactive SCHEME_BALANCED
    Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile" -Name "NetworkThrottlingIndex" -Value 10
    $StatusTxt.Text = "Status: Restored to Defaults."
})

# 6. Show the Window
$Form.ShowDialog() | Out-Null
