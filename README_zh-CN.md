<center><h1>chusanLauncher - CHUNITHM 启动器</h1></center>

> [!Caution]
>
> 众所周知，CHUNTIHM 是 SEGA 开发的一款音乐游戏。因此版权属于 SEGA.
> 这个启动器仅用于学习与交流谢谢（？

<center>
<img src="https://img.shields.io/badge/LICENSE-MIT-green">
<img src="https://img.shields.io/badge/Coding-PowerShell-blue">
</center>

## 简介
chusanLauncher 可以启动 <strong><font color="yellow">CHUNITHM NEW!!</font> - <font color="pink">CHUNITHM Luminous PLUS</font></strong>.

并且可以在启动时修改 segatools.ini 和 AIME 卡号。如果你不想改的话就可以把这两项设为 false.

    "needChangeUser": false,
    "needChangeSegatools": false

修改完后打开启动器，就不会提示让你修改这俩玩意了。

## 配置

Config 在 './Configure/chusanLauncher/chusanconfig.clconfig'.

这是个 JSON 文件. 你要修改这几个项目： <strong>startscript, needBrokenithm, brokenithm (path) 还有 bin</strong> （挺麻烦的.

icon 按你自己喜好配置，默认填空就没有。

## 启动

启动前要装 dotnet，版本≤6.0。

<strong>start.bat: </strong>点个双击六六六.

## 提个醒
目前这个还没发布 release，因此会有 bug，有 bug 请随时提 issue （其实这破玩意本来是我自己用的）。

人话：这玩意还没成熟，欢迎当~~小白鼠~~测试人员。