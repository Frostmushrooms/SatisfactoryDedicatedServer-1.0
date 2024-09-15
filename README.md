# SatisfactoryDedicatedServer-1.0   幸福工厂一键启动（含守护）
SatisfactoryDedicatedServer-1.0 Version，One-click start server code

This code is suitable for Windows


Since the release of 1.0, the game server crashes when it is started and cannot be automatically restarted. When the server is detected to be offline, UDP port 7777 is missing. So I wrote a little code to monitor whether UDP port 7777 is online. If it is online, it means that the server is working normally. If it is not online, shut down the current server and restart it.
Detection restart time 60 seconds

# Instructions

Put the SatisfactoryDedicatedServer folder in the C drive directory
First start Game download update file.bat
After the update is completed, there will be an additional GameServers folder in the folder
Finally, start start.bat
That's it

# SatisfactoryDe​​dicatedServer-1.0版本，一键启动服务器代码

此代码适用于Windows

自1.0发布以来，游戏服务器启动时崩溃，无法自动重启，检测到服务器离线时，UDP端口7777丢失。所以我写了一点代码，监控UDP端口7777是否在线，如果在线，说明服务器正常工作，如果不在线，关闭当前服务器并重新启动。
检测重启时间60秒

# 使用说明

将SatisfactoryDedicatedServer文件夹放至C盘目录下
先启动    Game download update file.bat
待更新完成后文件夹内会多出一个GameServers文件夹
最后启动   start.bat
即可
