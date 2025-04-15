# config.nu
#
# This file is used to override default Nushell settings, define
# (or import) custom commands, or run any other startup tasks.
# See https://www.nushell.sh/book/configuration.html
#
# This file is loaded after env.nu and before login.nu
# 
# You can open this file in your default editor using:
# config nu
#
# To pretty-print a sample config.nu with documentation, run:
# config nu --sample | nu-highlight | less -R
#
# To pretty-print the default configuration values, run:
# config nu --default | nu-highlight | less -R
#
# You can remove these comments if you want or leave
# them for future reference.

# ╭─────────────────────────────────────────────────────╮
# │                       THEME                         │
# ╰─────────────────────────────────────────────────────╯

# Catppuccin Mocha
source ~/.config/nushell/src/themes/catppuccin-mocha.nu

# Starship
source ~/.config/nushell/src/themes/starship.nu

# ╭─────────────────────────────────────────────────────╮
# │                    COMPLETIONS                      │
# ╰─────────────────────────────────────────────────────╯

# Git
source ~/.config/nushell/src/completions/git.nu

# Pacman
source ~/.config/nushell/src/completions/pacman.nu

# ╭─────────────────────────────────────────────────────╮
# │                      CONFIGS                        │
# ╰─────────────────────────────────────────────────────╯

$env.config = {
  buffer_editor: "nvim"
  show_banner: false
}

# ╭─────────────────────────────────────────────────────╮
# │                      ALIASES                        │
# ╰─────────────────────────────────────────────────────╯

# Aliases for "ls" command
alias l = ls -lha
alias la = ls -lha
alias ll = ls -lha

# Pacman + sudo
alias pacman = sudo pacman

# AUR helper
alias sync = yay

# Change directory quickly
alias hypr = cd ~/.config/hypr

# Wezterm
alias weztermrc = nvim ~/.config/wezterm/wezterm.lua