if [[ -f ~/.config/waybar/var.css ]]; then
	sudo rm -rf ~/.config/waybar/var.css
fi
sudo cp -r ~/.config/hypr/scripts/wpk_tmp/var.css ~/.config/waybar
sudo sed -i "s/BG/$WaybarBG/g" ~/.config/waybar/var.css
sudo sed -i "s/SB/$WaybarSB/g" ~/.config/waybar/var.css
sudo sed -i "s/SC/$WaybarSC/g" ~/.config/waybar/var.css
sudo sed -i "s/MC/#$WaybarMain/g" ~/.config/waybar/var.css
sudo sed -i "s/FT/#$WaybarFont/g" ~/.config/waybar/var.css

