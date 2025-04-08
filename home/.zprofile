#!/bin/zsh
if [[ $(echo $TERM | tr -cd "[:alnum:]\"\n") != "linux" ]]; then
    sleep 0
else
    source ~/.startup.sh
fi
