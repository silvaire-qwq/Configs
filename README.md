# ✨ Silvaire's Dotfiles

> [!NOTE]
> I use Silvaire's Dotfiles Manager btw

## 💻 HOSTS

| ITEMS  | VALUES                               |
| ------ | ------------------------------------ |
| Kernel | 6.12.7-rt-x64v3-xanmod1                          |
| System | Arch Linux |
| CPU    | 12th Gen Intel(R) Core(TM) i3-1215U                            |
| GPU    | Intel Corporation Alder Lake-UP3 GT1 [UHD Graphics] (rev 0c) |
| Memory | 7.44 GB                         |



## 🤔 Dotfiles Manager
How can I use this dotfiles manager?

> [!CAUTION]
> This script is only allowed to run on Arch Linux.

0. Install `git` and `bash`
1. Clone this repository.
2. Remove config, env, etc, and home folders.
3. Edit manager.conf or run `manager --config` to configure your dotfiles.
4. Run `manager -i` to initialize the git repository.
5. Run `manager -p` to copy your dotfiles and push your changes.

> [!TIP]
> You can use `manager --config` to open the configurator.


## ⚙️ PACKAGES

| CONFIG        | ETC          | HOME        |
| ------------- | ------------ | ----------- |
| ags           | pacman.conf  | .zshrc      |
| cava          | makepkg.conf | .zprofile   |
| fastfetch     | locale.gen   | .startup.sh |
| hypr          | hosts        | .Xresources |
| neofetch      | locale.conf  |             |
| nvim          |              |             |
| oh-my-posh    |              |             |
| rofi          |              |             |
| wezterm       |              |             |
| waybar        |              |             |
| starship.toml |              |             |
