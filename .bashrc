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

# Uncomment the following line if you don't like systemctl's auto-paging feature:
# export SYSTEMD_PAGER=

# User specific aliases and functions
if [ -d ~/.bashrc.d ]; then
	for rc in ~/.bashrc.d/*; do
		if [ -f "$rc" ]; then
			. "$rc"
		fi
	done
fi

unset rc
neofetch
GREEN="\[$(tput setaf 46)\]"
BLUE="\[$(tput setaf 33)\]"
PURPLE="\[$(tput setaf 129)\]"
RESET="\[$(tput sgr0)\]"
alias ls="ls -la"
PS1="${GREEN}\u@{${BLUE}Inspiron${GREEN}}[\w]${RESET}: ${PURPLE}-${BLUE}~${PURPLE}$>${RESET}"
