# Clear Screen
clear

# Start Hyprland
if [ ! -f /tmp/hyprland.lck ]; then
	sudo touch /tmp/hyprland.lck
	Hyprland &>/dev/null
fi
