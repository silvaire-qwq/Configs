#!/bin/zsh

# ╭─────────────────────────────────────────────────────────╮
# │                         CONFIGS                         │
# ╰─────────────────────────────────────────────────────────╯

local PLUGINS_FROM_OMZ=(
    git
    thefuck
    starship
    zoxide
)

local LIB_FROM_OMZ=(
    async_prompt
    git
    grep
    clipboard
    completion
    history
    key-bindings
    termsupport
    theme-and-appearance
    prompt_info_functions
    directories
)

local SNIPPET=()

local LIGHT=(
    zdharma-continuum/history-search-multi-word
    zsh-users/zsh-autosuggestions
    zdharma-continuum/fast-syntax-highlighting
    zsh-users/zsh-syntax-highlighting
    zsh-users/zsh-completions
    zsh-users/zsh-history-substring-search
    ael-code/zsh-colored-man-pages
    zerospaces/arch-command-not-found
    # z-shell/zsh-fancy-completions
    # Aloxaf/fzf-tab
)

# List (eza) Default Options
local EZA_DEFAULT_OPTS=(
    '--color=auto'
    '--icons=auto'
    '--sort=type'
    '-M'
    '--time-style=relative'
    '--smart-group'
)

local OPTIONS=(
    'AUTO_CD'
    'AUTO_PUSHD'
    'CDABLE_VARS'
    'PUSHD_IGNORE_DUPS'
    'ALWAYS_TO_END'
    'AUTO_LIST'
    'AUTO_MENU'
    'AUTO_PARAM_KEYS'
    'AUTO_PARAM_SLASH'
    'AUTO_REMOVE_SLASH'
    'HASH_LIST_ALL'
    'LIST_AMBIGUOUS'
    'NO_BAD_PATTERN'
    'EXTENDED_GLOB'
    'UNSET'
    'APPEND_HISTORY'
    'EXTENDED_HISTORY'
    'HIST_EXPIRE_DUPS_FIRST'
    'HIST_FCNTL_LOCK'
    'HIST_FIND_NO_DUPS'
    'HIST_IGNORE_SPACE'
    'HIST_NO_FUNCTIONS'
    'HIST_REDUCE_BLANKS'
    'INC_APPEND_HISTORY_TIME'
    # 'CORRECT'
    'INTERACTIVE_COMMENTS'
    'CHECK_JOBS'
    'CHECK_RUNNING_JOBS'
    'HUP'
)

# ╭─────────────────────────────────────────────────────────╮
# │                       HIGHLIGHTING                      │
# ╰─────────────────────────────────────────────────────────╯

ZSH_HIGHLIGHT_HIGHLIGHTERS=(main cursor)
typeset -gA ZSH_HIGHLIGHT_STYLES=(
    comment                              'fg=#585b70'
    alias                                'fg=#a6e3a1'
    suffix-alias                         'fg=#a6e3a1'
    global-alias                         'fg=#a6e3a1'
    function                             'fg=#a6e3a1'
    command                              'fg=#a6e3a1'
    precommand                           'fg=#a6e3a1,italic'
    autodirectory                        'fg=#fab387,italic'
    single-hyphen-option                 'fg=#fab387'
    double-hyphen-option                 'fg=#fab387'
    back-quoted-argument                 'fg=#cba6f7'
    builtin                              'fg=#a6e3a1'
    reserved-word                        'fg=#a6e3a1'
    hashed-command                       'fg=#a6e3a1'
    commandseparator                     'fg=#f38ba8'
    command-substitution-delimiter       'fg=#cdd6f4'
    command-substitution-delimiter-unquoted 'fg=#cdd6f4'
    process-substitution-delimiter       'fg=#cdd6f4'
    back-quoted-argument-delimiter       'fg=#f38ba8'
    back-double-quoted-argument          'fg=#f38ba8'
    back-dollar-quoted-argument          'fg=#f38ba8'
    command-substitution-quoted          'fg=#f9e2af'
    command-substitution-delimiter-quoted 'fg=#f9e2af'
    single-quoted-argument               'fg=#f9e2af'
    single-quoted-argument-unclosed      'fg=#eba0ac'
    double-quoted-argument               'fg=#f9e2af'
    double-quoted-argument-unclosed      'fg=#eba0ac'
    rc-quote                             'fg=#f9e2af'
    dollar-quoted-argument               'fg=#cdd6f4'
    dollar-quoted-argument-unclosed      'fg=#eba0ac'
    dollar-double-quoted-argument        'fg=#cdd6f4'
    assign                               'fg=#cdd6f4'
    named-fd                             'fg=#cdd6f4'
    numeric-fd                           'fg=#cdd6f4'
    unknown-token                        'fg=#eba0ac'
    path                                 'fg=#cdd6f4,underline'
    path_pathseparator                   'fg=#f38ba8,underline'
    path_prefix                          'fg=#cdd6f4,underline'
    path_prefix_pathseparator            'fg=#f38ba8,underline'
    globbing                             'fg=#cdd6f4'
    history-expansion                    'fg=#cba6f7'
    back-quoted-argument-unclosed        'fg=#eba0ac'
    redirection                          'fg=#cdd6f4'
    arg0                                 'fg=#cdd6f4'
    default                              'fg=#cdd6f4'
    cursor                               'fg=#cdd6f4'
)

# ╭─────────────────────────────────────────────────────────╮
# │                      PLUGIN MANAGER                     │
# ╰─────────────────────────────────────────────────────────╯

autoload -Uz compinit
autoload -Uz _zinit
(( ${+_comps} )) && _comps[zinit]=_zinit
compinit -D

if [[ ! -f $HOME/.local/share/zinit/zinit.git/zinit.zsh ]]; then
    print -P "%F{33} %F{220}Installing %F{33}ZDHARMA-CONTINUUM%F{220} Initiative Plugin Manager (%F{33}zdharma-continuum/zinit%F{220})…%f"
    command mkdir -p "$HOME/.local/share/zinit"
	command chmod g-rwX "$HOME/.local/share/zinit"
    command git clone https://github.com/zdharma-continuum/zinit "$HOME/.local/share/zinit/zinit.git" && \
        print -P "%F{33} %F{34}Installation successful.%f%b" || \
        print -P "%F{160} The clone has failed.%f%b"
fi

source "$HOME/.local/share/zinit/zinit.git/zinit.zsh"

zinit ice lucid wait='0'
zinit ice lucid wait='0' atload='_zsh_autosuggest_start'

for zinit_temp ("${PLUGINS_FROM_OMZ[@]}") {
    zinit snippet OMZ::plugins/"$zinit_temp"/"$zinit_temp".plugin.zsh
}
unset zinit_temp

for zinit_temp ("${LIB_FROM_OMZ[@]}") {
    zinit snippet OMZ::lib/"$zinit_temp".zsh
}
unset zinit_temp

for zinit_temp ("${SNIPPET[@]}") {
    zinit snippet "$zinit_temp"
}
unset zinit_temp

for zinit_temp ("${LIGHT[@]}") {
    zinit light "$zinit_temp"
}
unset zinit_temp


# ╭─────────────────────────────────────────────────────────╮
# │                       COMPLETIONS                       │
# ╰─────────────────────────────────────────────────────────╯

if [[ ! -d $HOME/.local/share/argc-completions ]]; then
    print -P "%F{33} %F{220}Installing %F{33}argc-completions%F{220}…%f"
    command mkdir -p "$HOME/.local/share/argc-completions"
	command chmod g-rwX "$HOME/.local/share/argc-completions"
    command git clone https://github.com/sigoden/argc-completions.git "$HOME/.local/share/argc-completions" 
    command sudo zsh -c "$HOME/.local/share/argc-completions/scripts/download-tools.sh" && \
        print -P "%F{33} %F{34}Installation successful.%f%b" || \
        print -P "%F{160} The init has failed.%f%b"

    # Init
fi

# argc-completions
export ARGC_COMPLETIONS_ROOT="$HOME/.local/share/argc-completions"
export ARGC_COMPLETIONS_PATH="$ARGC_COMPLETIONS_ROOT/completions/linux:$ARGC_COMPLETIONS_ROOT/completions"
export PATH="$ARGC_COMPLETIONS_ROOT/bin:$PATH"
# To add completions for only the specified command, modify next line e.g. argc_scripts=( cargo git )
argc_scripts=( $(ls -p -1 "$ARGC_COMPLETIONS_ROOT/completions/linux" "$ARGC_COMPLETIONS_ROOT/completions" | sed -n 's/\.sh$//p') )
source <(argc --argc-completions zsh $argc_scripts)

# ╭─────────────────────────────────────────────────────────╮
# │                       ENVIRONMENTS                      │
# ╰─────────────────────────────────────────────────────────╯

# Set Options
setopt $OPTIONS

# More Histories
export HISTSIZE=65535
export SAVEHIST=65535

# Create a function
omz_urlencode(){}

# Source Profiles & Envs
. /etc/profile
. /etc/environment
. /etc/locale.conf

# Atuin init
eval "$(atuin init zsh)"

# LS_COLORS init
# export LS_COLORS="$(vivid generate catppuccin-mocha)"

# hide EOL sign ('%')
export PROMPT_EOL_MARK=""

# FZF Default Opts
export FZF_DEFAULT_OPTS="\
--color=bg+:#1e1e2e,bg:#1e1e2e,spinner:#f5e0dc,hl:#f38ba8 \
--color=fg:#9399b2,header:#f38ba8,info:#b4befe,pointer:#b4befe \
--color=marker:#b4befe,fg+:#cdd6f4,prompt:#b4befe,hl+:#b4befe \
--color=selected-bg:#1e1e2e \
--color 'border:#45475a,label:#7f849c' \
--multi \
--height=50% --border --header-lines 0 --tac --tiebreak=begin \
--delimiter : \
--no-scrollbar --border-label "Search" \
"

# ╭─────────────────────────────────────────────────────────╮
# │                         ALIASES                         │
# ╰─────────────────────────────────────────────────────────╯

if [[ -x $(command -v pacman) ]]; then
    alias 'banner'='sudo pacman -Rscn'
    alias 'ban'='sudo pacman -R'
    alias 'pacman'='sudo pacman'
fi

if [[ -x $(command -v yay) ]]; then
    alias 'sync'='yay'
    alias 'clean'='ccache -C && sudo rm -rf ~/.cache/yay && sudo rm -rf ~/.cache/paru && sudo rm -rf ~/.local/share/pikaur && sudo pacman -Sc && echo "OK!"'
fi

if [[ -x $(command -v timeshift) ]]; then
    alias 'shotlist'='sudo timeshift --list'
    alias 'snapshot'='sudo timeshift --create && sudo update-grub'
    alias 'banshot'='sudo timeshift --delete && sudo update-grub'
    alias 'clearshot'='sudo timeshift --delete-all && sudo update-grub'
    alias 'backup'='sudo timeshift --delete-all && sudo timeshift --create && sudo update-grub'
fi

if [[ -f ~/.config/wezterm/wezterm.lua ]]; then
    alias 'weztermrc'='sudo nvim ~/.config/wezterm/wezterm.lua'
fi

# if [[ -x $(command -v eza) ]]; then
    # alias 'l'="eza -lha $EZA_DEFAULT_OPTS"
    # alias 'ls'="eza -lh $EZA_DEFAULT_OPTS"
    # alias 'la'="eza -lha $EZA_DEFAULT_OPTS"
    # alias 'll'="eza -lha $EZA_DEFAULT_OPTS"
# fi

[[ ! -x $(command -v zoxide) ]] || alias "cd"="z"
[[ ! -d ~/.config/hypr ]] || alias 'hypr'='cd ~/.config/hypr'
[[ ! -x $(command -v cava) ]] || alias 'c'='cava'

# Force Alias
if [[ 1 -eq 1 ]]; then
    alias 'sd'='shutdown 0'
    alias '.zshrc'='nvim ~/.zshrc'
    alias 'please'='sudo'
fi

if [[ $(command -v nu) ]]; then
    unalias {ls,la,l,ll}
    function ls(){ nu -c 'source ~/.config/nushell/config.nu; ls '"$@" }
    function la(){ nu -c 'source ~/.config/nushell/config.nu; ls -a '"$@" }
    function l(){ nu -c 'source ~/.config/nushell/config.nu; ls -a '"$@" }
    function ll(){ nu -c 'source ~/.config/nushell/config.nu; ls -a '"$@" }
fi
