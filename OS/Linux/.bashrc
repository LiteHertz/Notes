# .bashrc

# Source global definitions
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi

# User specific environment
if ! [[ "$PATH" =~ "$HOME/.local/bin:$HOME/bin:" ]]
then
    PATH="$HOME/.local/bin:$HOME/bin:$PATH"
fi
export PATH

# User specific aliases and functions
# Checks if the following directory exists, loops through the files and $rc executes them.
if [ -d ~/.bashrc.d ]; then
	for rc in ~/.bashrc.d/*; do
		if [ -f "$rc" ]; then
			. "$rc"
		fi
	done
fi

# Reads the system's product name from DMI (BIOS/UEFI) data.
if [ -f /sys/class/dmi/id/product_name ]; then
    # Reads the product name, cleans up whitespace, and converts to uppercase
    PC_NAME=$(cat /sys/class/dmi/id/product_name 2>/dev/null | xargs | tr '[:lower:]' '[:upper:]')
else
    # Fallback name if DMI info is not available
    PC_NAME="UNKNOWN_PC"
fi

unset rc
fastfetch
GREEN="\[$(tput setaf 46)\]"
BLUE="\[$(tput setaf 33)\]"
PURPLE="\[$(tput setaf 129)\]"
RESET="\[$(tput sgr0)\]"
alias ls="ls -la"
PS1="${GREEN}\u@{${BLUE}${PC_NAME}${GREEN}}[\w]${RESET}: ${PURPLE}-${BLUE}~${PURPLE}$>${RESET}"