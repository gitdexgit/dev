# ~/.zprofile

export PAGER="nvim -R"
export EDITOR="nvim"
export VISUAL="nvim"


export PATH="$HOME/.local/bin:$PATH"

if [[ -z $DISPLAY ]] && [[ $(tty) = /dev/tty1 ]]; then
    exec startx
fi
