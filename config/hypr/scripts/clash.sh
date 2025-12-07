#!/bin/bash
case $1 in
"close")
	sudo pkill clash-verge
	notify-send "Clash Verge" "Clash disabled."
	;;
"open")
	notify-send "Clash Verge" "Clash enabled."
	clash-verge
	# sudo clash-meta -d /etc/clash-meta &
	# xdg-open http://127.0.0.1:9090/ui &
	;;
esac
