mcpid=`pidof java`

echo $* > /proc/$mcpid/fd/0