#!/bin/bash

# Load configuration file
CONFIG_FILE="$(dirname "$0")/../manager.conf"
TMP_CONFIG_FILE="/tmp/manager.conf.tmp"

if [[ ! -f "$CONFIG_FILE" ]]; then
    echo -e "\e[1;33m>>> \e[0;1mConfiguration file not found, so we will create a new one.\e[0m"
    touch "$CONFIG_FILE"
    echo "#!/bin/bash

# Directory where the dotfiles are stored
export DIR=\"$HOME/Dotfiles\"
export BRANCH=\"main\"" >>"$CONFIG_FILE"
fi

source "$CONFIG_FILE"

# Display a styled header
function header() {
    echo -e "\e[1;34m>>> \e[36mDotfiles Manager Configurator\e[0m"
}

# Confirm action with the user
function confirm_action() {
    local message="$1"
    echo -e -n "\e[1;33m>>> $message \e[0;1m[\e[32mY\e[0;1m/\e[31mn\e[0;1m]\e[0m "
    read -n 1 user_choice
    echo
    if [[ "$user_choice" =~ ^[Nn]$ ]]; then
        return 1
    else
        return 0
    fi
}

# Display the main menu
function main_menu() {
    clear
    header

    echo -e "\e[1;32m    1 \e[0mHome \e[90m~\e[0m"
    echo -e "\e[1;32m    2 \e[0mConfigs \e[90m~/.config\e[0m"
    echo -e "\e[1;32m    3 \e[0mEtc \e[90m/etc\e[0m"
    echo -e "\e[1;32m    4 \e[0mExit"
    echo -e "\e[1;32m    5 \e[0mSave Changes"

    echo -n -e "\e[1;33m>>> Enter your choice: \e[0m"
    read -n1 choice
    echo

    case $choice in
    1) configure_list "DOTFILES" "$HOME" ;;
    2) configure_list "CONFIG" "$HOME/.config" ;;
    3) configure_list "ETC" "/etc" ;;
    4) exit 0 ;;
    5) save_changes ;;
    *)
        echo -e "\e[1;31m!!! Invalid choice! Please try again.\e[0m"
        sleep 1
        main_menu
        ;;
    esac
}

# Configure the list (add or remove items)
function configure_list() {
    local list_name="$1"
    local target_dir="$2"
    local current_list
    eval "current_list=(\"\${${list_name}[@]}\")"

    while true; do
        clear
        header
        echo -e "\e[1;33m>>> Configuring $list_name:\e[0m"

        echo -e "\e[1;36m--- Current items:\e[0m"
        for item in "${current_list[@]}"; do
            echo -e "    \e[1;32m*\e[0m $item"
        done

        echo -e "\e[1;36m--- Available items in $target_dir:\e[0m"
        local items=()
        local file_count=0

        # Generate file list
        for item in "$target_dir"/* "$target_dir"/.*; do
            [[ -e "$item" && "$(basename "$item")" != "." && "$(basename "$item")" != ".." ]] || continue
            items+=("$(basename "$item")")
            ((file_count++))
        done

        # If too many files, prompt for manual input
        if ((file_count > 1000)); then
            echo -e "\e[1;31m!!! Too many files ($file_count). Please enter the file name manually.\e[0m"
            echo -n -e "\e[1;33m>>> Enter the file name: \e[0m"
            read manual_input
            if [[ -n "$manual_input" ]]; then
                items=("$manual_input")
            else
                echo -e "\e[1;31m!!! No input provided. Returning to the menu.\e[0m"
                sleep 2
                main_menu
                return
            fi
        fi

        # Display file list with permissions
        for i in "${!items[@]}"; do
            local permissions
            permissions=$(stat -c "%a" "$target_dir/${items[$i]}")
            if [[ " ${current_list[*]} " =~ " ${items[$i]} " ]]; then
                echo -e "    \e[1;31m$i\e[0m ${items[$i]} \e[2;90m$permissions\e[0m"
            else
                echo -e "    \e[1;32m$i\e[0m ${items[$i]} \e[2;90m$permissions\e[0m"
            fi
        done

        echo -n -e "\e[1;33m>>> Enter the numbers or names of items to add/remove (space-separated): \e[0m"
        read -a inputs

        local indices=()
        for input in "${inputs[@]}"; do
            if [[ "$input" =~ ^[0-9]+$ ]]; then
                if ((input < 0 || input >= ${#items[@]})); then
                    echo -e "\e[1;31m!!! Invalid index: $input. Please try again.\e[0m"
                    sleep 2
                    continue 2
                fi
                indices+=("$input")
            else
                local found=false
                for j in "${!items[@]}"; do
                    if [[ "${items[$j]}" == "$input" ]]; then
                        indices+=("$j")
                        found=true
                        break
                    fi
                done
                if [[ $found == false ]]; then
                    echo -e "\e[1;31m!!! Invalid name: $input. Please try again.\e[0m"
                    sleep 2
                    continue 2
                fi
            fi
        done

        local new_list=("${current_list[@]}")
        for index in "${indices[@]}"; do
            local item="${items[$index]}"
            if [[ " ${new_list[*]} " =~ " $item " ]]; then
                confirm_action "Remove $item?"
                if [[ $? -eq 0 ]]; then
                    new_list=("${new_list[@]/$item/}")
                    echo -e "\e[1;32m>>> Removed: $item\e[0m"
                else
                    echo -e "\e[1;33m>>> Skipped removal of: $item\e[0m"
                fi
            else
                confirm_action "Add $item?"
                if [[ $? -eq 0 ]]; then
                    new_list+=("$item")
                    echo -e "\e[1;32m>>> Added: $item\e[0m"
                else
                    echo -e "\e[1;33m>>> Skipped addition of: $item\e[0m"
                fi
            fi
        done
        eval "$list_name=(\"\${new_list[@]}\")"
        save_to_tmp
        break
    done
    main_menu
}

# Save changes to a temporary file
function save_to_tmp() {
    {
        echo "#!/bin/bash"
        echo ""
        echo "# Directory where the dotfiles are stored"
        echo "export DIR=\"$DIR\""
        echo "export BRANCH=\"$BRANCH\""
        echo ""
        echo "# ~ (like .bashrc, .zshrc, etc.)"
        echo "export DOTFILES=("
        for item in "${DOTFILES[@]}"; do
            echo "    \"$item\""
        done
        echo ")"
        echo ""
        echo "# ~/.config (like neofetch, startship.toml, etc.)"
        echo "export CONFIG=("
        for item in "${CONFIG[@]}"; do
            echo "    \"$item\""
        done
        echo ")"
        echo ""
        echo "# /etc (like pacman.d, makepkg.conf, etc.)"
        echo "export ETC=("
        for item in "${ETC[@]}"; do
            echo "    \"$item\""
        done
        echo ")"
    } >"$TMP_CONFIG_FILE"
    echo -e "\e[1;32m>>> Changes saved to temporary file: $TMP_CONFIG_FILE\e[0m"
    sleep 1
}

# Save changes to the original configuration file
function save_changes() {
    if [[ ! -f "$TMP_CONFIG_FILE" ]]; then
        echo -e "\e[1;31m!!! No changes to save.\e[0m"
        sleep 2
        main_menu
        return
    fi

    echo -e "\e[1;33m>>> Preview of changes:\e[0m"
    cat "$TMP_CONFIG_FILE"

    confirm_action "Save changes to $CONFIG_FILE?"
    if [[ $? -eq 0 ]]; then
        mv "$TMP_CONFIG_FILE" "$CONFIG_FILE"
        echo -e "\e[1;32m>>> Changes saved to $CONFIG_FILE\e[0m"
    else
        echo -e "\e[1;33m>>> Save canceled. Temporary file retained: $TMP_CONFIG_FILE\e[0m"
    fi
    sleep 2
    main_menu
}

# Start the main menu
main_menu
