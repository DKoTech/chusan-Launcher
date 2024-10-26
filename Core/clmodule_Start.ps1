# 读取需要的 aime.txt 和 segatools.ini
$AimePath = "./Configure/aime_cards/selected_aime.txt"
$SegaToolsPath = "./Configure/segatools_configures/selected_segatools.ini"

# 读取配置文件
$AimeConfig = Get-Content -Path $AimePath
$SegaToolsConfig = Get-Content -Path $SegaToolsPath

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

if (Test-Path "./Configure/chusanLauncher/chusanconfig.clconfig") { # 检查配置文件是否存在
    Write-Log "chusanLauncher config exist." 1
} else {
    Write-Log "chusan Launcher config not exist." 2
    Write-Log "Please check chusanLauncher config." 2
    exit # 不存在就退出
}

$scriptconfig = Get-Content -Path "./Configure/chusanLauncher/chusanconfig.clconfig" -Raw # clconfig = chusanLauncherConfig 读取配置文件
$cthis = ConvertFrom-Json -InputObject $scriptconfig # 转换 JSON

# 替换 aime
$ReplaceAimePath = "$($cthis.bin)\DEVICE\aime.txt"
Set-Content -Path $ReplaceAimePath -Value $AimeConfig

# 替换 segatools
$ReplaceSegaToolsPath = "$($cthis.bin)\segatools.ini"
Set-Content -Path $ReplaceSegaToolsPath -Value $SegaToolsConfig

Write-Log "Replace Success." 1
Write-Log "Starting Game." 1

# {
#    "version": "1.0.0",
#    "startscript": "F:\\Chuni\\bin\\start.bat",
#    "needbrokenithm": true,
#    "brokenithm": "F:\\Chuni\\bin\\手台配置\\Brokenithm For Android\\start_brokenithm.bat",
#    "icon": ".\\Configure\\chusanLauncher\\clicon.ico",
#    "bin": "F:\\Chuni\\bin\\"
#}

$quotation_marks = '"'
Start-Process -FilePath cmd.exe -ArgumentList "/k $($quotation_marks)$($cthis.startscript)$($quotation_marks)"
if ($cthis.needbrokenithm) {
    Start-Process -FilePath cmd.exe -ArgumentList "/k $($quotation_marks)$($cthis.brokenithm)$($quotation_marks)"
}

Write-Log "Game Start." 1