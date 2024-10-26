#region Include
[Reflection.Assembly]::LoadWithPartialName("System.Windows.Forms")
[Reflection.Assembly]::LoadWithPartialName("System.Drawing")
#endregion 这个给 VSCode 看的

#region WindowCreate
$app=[System.Windows.Forms.Application]

$window = New-Object System.Windows.Forms.Form
$window.Text = "CHUNITHM NEW!! - Luminous PLUS - Launcher"
$window.AutoSize = $true
$window.Icon = [System.Drawing.Icon]::ExtractAssociatedIcon("./Configure/chusanLauncher/clicon.ico")
#endregion

# ICO 已经准备好了，在 ./clicon.ico.

#region CommandOutput
Clear-Host

function Write-Log { # Write-Log 输出 LOG
    param (
        [string]$message,
        [int]$type
    )
    if ($type -eq 1) {
        Write-Host "[INFO] " -NoNewline -ForegroundColor Blue
        Write-Host $message
    } elseif ($type -eq 2) {
        Write-Host "[ERROR] " -NoNewline -ForegroundColor Red
        Write-Host $message
    } elseif ($type -eq 3) {
        Write-Host "[WARNING] " -NoNewline -ForegroundColor Yellow
        Write-Host $message
    }
}
Write-Output " "

Write-Output "CHUNITHM NEW!! - Luminous PLUS - Launcher"

if (Test-Path "./Configure/chusanLauncher/chusanconfig.clconfig") { # 检查配置文件是否存在
    Write-Log "chusanLauncher config exist." 1
} else {
    Write-Log "chusan Launcher config not exist." 2
    Write-Log "Please check chusanLauncher config." 2
    exit # 不存在就退出
}

#region ConfigRead
$scriptconfig = Get-Content -Path "./Configure/chusanLauncher/chusanconfig.clconfig" -Raw # clconfig = chusanLauncherConfig 读取配置文件
$cthis = ConvertFrom-Json -InputObject $scriptconfig # 转换 JSON
#endregion

Write-Output " "
Write-Log "Librarys include." 1
Write-Log "chusanLauncher Config Read." 1
Write-Log "chusanLauncher Version: $($cthis.version)" 1

#endregion

#region UI
$title = New-Object System.Windows.Forms.Label # 标题
$title.Text = " CHUNITHM NEW!! - Luminous PLUS - Launcher "
$title.Font = New-Object Drawing.Font("Microsoft YaHei", 12, [Drawing.FontStyle]::Bold)
$title.AutoSize = $true
$title.Location = New-Object Drawing.Point(10,15)
$window.Controls.Add($title)

$launch = New-Object System.Windows.Forms.Button # 选择 aime 按钮
$launch.Text = "Next >>>>"
$launch.Font = New-Object Drawing.Font("Microsoft YaHei", 12, [Drawing.FontStyle]::Bold)
$launch.Width = $window.Width - 55
$launch.Height = 30
$launch.Location = New-Object Drawing.Point(18, 50)
$launch.FlatStyle = [System.Windows.Forms.FlatStyle]::Flat
$borderColor = [System.Drawing.Color]::FromArgb(0, 119, 214) # 0077d6
$launch.FlatAppearance.BorderColor = $borderColor
$launch.BackColor = $borderColor
$launch.ForeColor = "White"

$launch_Click = {
    # 启动 ./clmodule_AccountChange.ps1 并关闭该窗口
    Start-Process -FilePath "powershell.exe" -ArgumentList "-ExecutionPolicy Bypass -File .\Core\clmodule_AccountChange.ps1" -NoNewWindow
    $window.Close()
} # 启动事件，单独分开来写，方便调试

$launch.Add_Click($launch_Click)
$window.Controls.Add($launch)

$exit = New-Object System.Windows.Forms.Button # 退出
$exit.Text = "Exit"
$exit.Font = New-Object Drawing.Font("Microsoft YaHei", 12, [Drawing.FontStyle]::Bold)
$exit.Width = $window.Width - 55
$exit.Height = 30
$exit.Location = New-Object Drawing.Point(18,90)
$exit.FlatStyle = [System.Windows.Forms.FlatStyle]::Flat
$exit.FlatAppearance.BorderColor = $borderColor
$exit.BackColor = $borderColor
$exit.ForeColor = "White"
$exit.Add_Click({
    $window.Close() # 这个就不用分开来写了，麻烦
})
$window.Controls.Add($exit)

#endregion

#region Run
$app::Run($window) # 启动

Write-Log "Window terminated." 3 # 结束
#endregion