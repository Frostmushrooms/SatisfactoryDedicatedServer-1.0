# SatisfactoryDedicatedServer-1.0
SatisfactoryDedicatedServer-1.0 Version，One-click start server code


Since the release of 1.0, the game server crashes when it is started and cannot be automatically restarted. When the server is detected to be offline, UDP port 7777 is missing. So I wrote a little code to monitor whether UDP port 7777 is online. If it is online, it means that the server is working normally. If it is not online, shut down the current server and restart it.

Welcome all masters to modify the program. I am a novice and wrote it randomly. There is a cmd pop-up window that will not close.
