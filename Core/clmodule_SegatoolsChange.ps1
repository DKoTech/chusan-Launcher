#region Include
[Reflection.Assembly]::LoadWithPartialName("System.Windows.Forms")
[Reflection.Assembly]::LoadWithPartialName("System.Drawing")
#endregion 这个给 VSCode 看的

#region WindowCreate
$app=[System.Windows.Forms.Application]

$window = New-Object System.Windows.Forms.Form
$window.Text = "CHUNITHM NEW!! - Luminous PLUS - Select segatools.ini"
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

Write-Output "CHUNITHM NEW!! - Luminous PLUS - Select segatools.ini"

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
$borderColor = [System.Drawing.Color]::FromArgb(0, 119, 214) # 0077d6
$title = New-Object System.Windows.Forms.Label # 标题
$title.Text = " CHUNITHM NEW!! - Luminous PLUS - Select segatools.ini"
$title.Font = New-Object Drawing.Font("Microsoft YaHei", 12, [Drawing.FontStyle]::Bold)
$title.AutoSize = $true
$title.Location = New-Object Drawing.Point(10,15)
$window.Controls.Add($title)

# 循环遍历 ./Configure/aime_cards，生成 List 内对象，先创建 LIST
$list = New-Object System.Windows.Forms.ListBox
$list.Width = $window.Width - 55
$list.Height = 50
$list.Location = New-Object Drawing.Point(18,50)
$list.Font = New-Object Drawing.Font("Microsoft YaHei", 12, [Drawing.FontStyle]::Bold)
$list.SelectionMode = [System.Windows.Forms.SelectionMode]::One
$list.BackColor = $borderColor
$list.ForeColor = "White"
$list.BorderStyle = [System.Windows.Forms.BorderStyle]::FixedSingle
$list.AutoSize = $true
$list.Items.Clear()

# 循环遍历 ./Configure/aime_cards，生成 List 内对象
Get-ChildItem -Path "./Configure/segatools_configures" | ForEach-Object {
    if ($_.Name -ne "selected_segatools.ini") {
        $list.Items.Add($_.Name) # 添加到 List
    }
}
$window.Controls.Add($list)

# 选择按钮
$button = New-Object System.Windows.Forms.Button # 选择
$button.Text = "Select"
$button.Font = New-Object Drawing.Font("Microsoft YaHei", 12, [Drawing.FontStyle]::Bold)
$button.Width = $window.Width - 55
$button.Height = 30
$button.Location = New-Object Drawing.Point(18,140)
$button.FlatStyle = [System.Windows.Forms.FlatStyle]::Flat
$button.FlatAppearance.BorderColor = $borderColor
$button.BackColor = $borderColor
$button.ForeColor = "White"
$button.Add_Click({
    if ($list.SelectedItem -eq $null) {
        Write-Log "Please select segatools.ini." 2
    } else {
        $segatools = Get-Content -Path "./Configure/segatools_configures/$($list.SelectedItem.ToString())" -Force
        Set-Content -Path ".\Configure\segatools_configures\selected_segatools.ini" -Value $segatools
        Write-Log "Segatools selected: $($list.SelectedItem.ToString())" 1
        Start-Process -FilePath "powershell.exe" -ArgumentList "-ExecutionPolicy Bypass -File .\Core\clmodule_Start.ps1" -NoNewWindow
        $window.Close()
    }
})
$window.Controls.Add($button)


$exit = New-Object System.Windows.Forms.Button # 退出
$exit.Text = "Exit"
$exit.Font = New-Object Drawing.Font("Microsoft YaHei", 12, [Drawing.FontStyle]::Bold)
$exit.Width = $window.Width - 55
$exit.Height = 30
$exit.Location = New-Object Drawing.Point(18,170)
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