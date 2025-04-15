sudo rm -rf /home/arch/.config/hypr/source/dpi-set.conf
sudo ln -s /home/arch/.config/hypr/source/dpi/96.conf /home/arch/.config/hypr/source/dpi-set.conf
sudo sed -i 's/true/false/g' /home/arch/.config/hypr/source/xwayland.conf
