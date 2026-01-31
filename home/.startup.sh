# Clear Screen
clear

# Start Niri
if [ ! -f /tmp/niri.lck ]; then
	sudo touch /tmp/niri/.lck
	niri &>/dev/null
fi
