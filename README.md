# SatisfactoryDedicatedServer-1.0
SatisfactoryDedicatedServer-1.0 Version，One-click start server code


Since the release of 1.0, the game server crashed and could not automatically restart the server. When the server was detected to be offline, UDP port 7777 disappeared. So I wrote a little code to monitor whether UDP port 7777 is online. If it is online, it means the server is working normally. If it is not online, shut down the current server and restart it.
