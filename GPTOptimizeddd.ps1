# -------------------------------------------------------------------------
# GPTOptimizeddd v3.0 - Modern Web UI Edition
# -------------------------------------------------------------------------

# 1. Admin Check
if (!([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] "Administrator")) {
    powershell -Command "Start-Process powershell -ArgumentList '-ExecutionPolicy Bypass -File ""$PSCommandPath""' -Verb RunAs"
    exit
}

# 2. Add required Assemblies for the UI
Add-Type -AssemblyName System.Windows.Forms
Add-Type -AssemblyName System.Drawing

# 3. The HTML/CSS Design (Modern Dark Theme)
$HTML = @"
<!DOCTYPE html>
<html>
<head>
    <style>
        body { 
            background: #0f0f0f; color: white; font-family: 'Segoe UI', sans-serif; 
            display: flex; flex-direction: column; align-items: center; justify-content: center; height: 100vh; margin: 0;
        }
        .container { 
            background: rgba(255, 255, 255, 0.05); backdrop-filter: blur(10px);
            padding: 30px; border-radius: 15px; border: 1px solid rgba(255, 255, 255, 0.1);
            text-align: center; width: 350px; box-shadow: 0 10px 30px rgba(0,0,0,0.5);
        }
        h1 { color: #0078d4; margin-bottom: 20px; font-weight: 300; }
        .btn {
            background: #0078d4; border: none; color: white; padding: 12px 20px;
            margin: 10px 0; width: 100%; border-radius: 8px; cursor: pointer;
            transition: 0.3s; font-size: 14px;
        }
        .btn:hover { background: #005a9e; transform: scale(1.02); }
        .btn-reset { background: #444; }
        .btn-reset:hover { background: #666; }
        .status { font-size: 12px; color: #888; margin-top: 15px; }
    </style>
</head>
<body>
    <div class="container">
        <h1>GPTOptimizeddd</h1>
        <button class="btn" onclick="window.chrome.webview.postMessage('Boost')">🚀 ULTIMATE BOOST</button>
        <button class="btn" onclick="window.chrome.webview.postMessage('Fortnite')">🎯 FORTNITE MODE</button>
        <button class="btn btn-reset" onclick="window.chrome.webview.postMessage('Reset')">🔄 RESET DEFAULTS</button>
        <div class="status" id="status">Status: Ready to Optimize</div>
    </div>
    <script>
        window.chrome.webview.addEventListener('message', arg => {
            document.getElementById('status').innerText = 'Status: ' + arg.data;
        });
    </script>
</body>
</html>
"@

# 4. Create the Windows Form to hold the Web View
$Form = New-Object System.Windows.Forms.Form
$Form.Text = "GPTOptimizeddd Control Panel"
$Form.Size = New-Object System.Drawing.Size(420, 500)
$Form.StartPosition = "CenterScreen"
$Form.BackColor = [System.Drawing.Color]::FromArgb(15, 15, 15)

$WebView = New-Object Microsoft.Web.WebView2.WinForms.WebView2
$WebView.Dock = "Fill"
$Form.Controls.Add($WebView)

# 5. Handle Communication between Web UI and PowerShell
$Action = {
    param($sender, $e)
    $msg = $e.WebMessageAsJson.Replace('"','')
    
    switch ($msg) {
        "Boost" {
            powercfg /setactive SCHEME_MIN
            Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile" -Name "NetworkThrottlingIndex" -Value 0xffffffff
            $WebView.CoreWebView2.PostWebMessageAsString("System Boosted!")
        }
        "Fortnite" {
            Get-Process "Fortnite*" -ErrorAction SilentlyContinue | ForEach-Object { $_.PriorityClass = "High" }
            $WebView.CoreWebView2.PostWebMessageAsString("Fortnite Optimized!")
        }
        "Reset" {
            powercfg /setactive SCHEME_BALANCED
            Set-ItemProperty -Path "HKLM:\SOFTWARE\Microsoft\Windows NT\CurrentVersion\Multimedia\SystemProfile" -Name "NetworkThrottlingIndex" -Value 10
            $WebView.CoreWebView2.PostWebMessageAsString("Reset to Defaults!")
        }
    }
}

# 6. Initialize and Launch
$asyncInit = $WebView.EnsureCoreWebView2Async()
$WebView.Add_CoreWebView2InitializationCompleted({
    $WebView.NavigateToString($HTML)
    $WebView.Add_WebMessageReceived($Action)
})

$Form.ShowDialog()
