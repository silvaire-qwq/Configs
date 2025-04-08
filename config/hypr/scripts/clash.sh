#!/bin/bash
case $1 in
    "close")
        sudo pkill clash-meta
        notify-send "Clash" "Clash 已关闭。"
    ;;
    "open")
        notify-send "Clash" "Clash 已启动。"
        sudo clash-meta -d /etc/clash-meta &
        xdg-open http://127.0.0.1:9090/ui &
    ;;
esac




