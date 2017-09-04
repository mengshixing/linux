:top
echo %date%;%time%>>d:\log.txt
ping -n 1 10.10.10.151 | findstr . >> d:\log.txt
ping -n 2 127.1 >nul
goto top