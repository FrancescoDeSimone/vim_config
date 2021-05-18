#!/usr/bin/expect -f
set timeout -1 
spawn nvim
send -- ":UpdateRemotePlugins\r"
expect "Press ENTER or type command to continue\r"
send "\n\r"
expect eof
