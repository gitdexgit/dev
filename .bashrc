#
# ~/.bashrc
#

# If not running interactively, don't do anything
[[ $- != *i* ]] && return


# ----- Clipboard -------

alias ]cp=' col -b | xclip -selection clipboard'


# ----- Clipboard END-------
# export PATH="$PATH:$HOME/.local/lib/dart_install/dart-sdk/bin"
alias ]exe='chmod +x'
alias ]cpuinfo='cpupower frequency-info'
export PATH="$PATH:/home/dex/Desktop/ddesk:/home/dex/Desktop/ddesk/[:/home/dex/Desktop/ddesk/]:/home/dex/Desktop/ddesk/]]:/home/dex/Desktop/ddesk/nothing"
export EDITOR=nvim # this is so that visudo works i guess, you can specify any EDITOR or before visudo type EDITOR=.... to like you know change the env var and what not... you got the idea
alias ]o='pacman -Qo'
alias kdex='dex@192.168.11.102'
alias ]st='systemctl status'
alias ]ss='systemctl start'
alias ]sp='systemctl stop'
alias ]se='systemctl enable'
alias ]e.nv='nvim ~/.config/nvim/init.vim'
alias ]show='pacman -Si'
alias ]pac='pacman -Qi'
alias [od='obsidian obsidian://open?vault=Desktop'
alias ]p='pwd'
alias ]w='whoami'
alias ]i='ifconfig'
alias locate='plocate'
alias ]+='pushd .' # damn i couldn't just have the '+' for some reaosn... i believe i tried the escape character like \+ and it didn't work idk
alias ]-='popd'  # damn i could just have '-' for some reason... i believe i tried the escape character like \- and it didn't work idk
alias ..='cd ..'
alias ...='cd ../..'
alias beep='echo -en "\007"'
# alias dir='ls -l' # why do ppl use this i don't get it ?
alias egrep='egrep --color=auto' # I could add -E for default extented regex... btw idk what egrep is
alias fgrep='fgrep --color=auto' # I could add -E for default extended regex... idk what fgrep is tbh
alias grep='grep --color=auto' # I could add -E for default extented regex
alias l='ls -alF'
alias la='ls -la'
alias ll='ls -l'
alias ls-l='ls -l'
alias md='mkdir -p' # this is smart too mkdir --> md
alias o='less'
alias rd='rmdir' # this is smart rmdir --> rd
alias rehash='hash -r'
alias ]in?='sudo pacman -Ss'
alias ]in='sudo pacman -S'
# alias ]sysupdate='sudo pacman -Syu' # I don't usually do system updates right... so yeah who cares about this 
alias ls='ls --color=auto'
# alias ]mixer='pavucontrol' # I don't use this as much but i like the idea for sure... tbh i just alt+F2 and type volum control no big deal
alias c.d='cd ~/Desktop/'
alias c.dd='cd ~/Desktop/ddesk'
alias ]]r='source ~/.bashrc'
alias ]]ev='vim ~/.bashrc'
alias ]]ec='code ~/.bashrc'
alias ]]en='nvim ~/.bashrc'
alias nv='nvim'
alias ]c='clear'
alias c.AUR='cd ~/Downloads/AUR'
alias ]]wc='c.d && read -p "what filename: " fname && echo "Type content, press Ctrl+D when done: " && cat > "$fname.md" '
alias ]]wn='c.d && read -p "what filename: " fname && touch "$fname.md" && nvim "$fname.md"'
# ------- PS1 Playing around -----
#
# PS1='[\u@\h \W]\$ '
# PS1='[\u]~[\W]\$ '
# PS1='[\[\e[96m\]\u\[\e[0m\]]~[\W]\$ '
# PS1='[\[\e[96m\]\u\[\e[0m\]]~[\[\e[32m\]\w\[\e[0m\]]\$ '
PS1='[\[\e[96m\]\u\[\e[0m\]]~[\[\e[96m\]$(path_str=$(printf %s "\w"); IFS=/ read -r -a parts <<< "$path_str"; n=${#parts[@]}; if (( n <= 2 )); then echo "$path_str"; else printf "%s" "${parts[0]}"; printf "/%s" "${parts[n-2]}"; printf "/%s" "${parts[n-1]}"; fi)\[\e[0m\]]\$ '
# PS1="D.exe: "
#
# ------- PS1 Playing around -----
source /usr/share/fzf/key-bindings.bash
source /usr/share/fzf/completion.bash

[ -f ~/.fzf.bash ] && source ~/.fzf.bash

# Generated for envman. Do not edit.
[ -s "$HOME/.config/envman/load.sh" ] && source "$HOME/.config/envman/load.sh"
