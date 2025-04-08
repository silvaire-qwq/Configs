notify-send "TIMESHIFT | Btrfs Backup" "正在删除所有快照 并 创建 Btrfs 备份"
sudo timeshift --delete-all
sudo timeshift --create
sudo update-grub
notify-send "TIMESHIFT | Btrfs Backup" "好耶，执行成功了哦!"
