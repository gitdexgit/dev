# --- [SPACE FIX] ---
[[ -n "$TMUX" ]] && echo ""

# --- [0] AUTO-TMUX STARTUP ---
if [[ -z "$TMUX" ]] && [[ $- == *i* ]] && command -v tmux >/dev/null 2>&1; then
    tmux new-session
fi

# 1. CORE PATHS & LIBRARY LOADING
fpath=($HOME/.config/zsh/completions $HOME/.config/zsh/functions $fpath)
autoload -Uz compinit add-zsh-hook vcs_info

# 2. INSTANT COMPLETION SYSTEM
export ZSH_COMPDUMP="$HOME/.cache/zcompdump"
() {
  local dump="$ZSH_COMPDUMP"
  if [[ -f $dump && -n $dump(#qN.m-1) ]]; then
    compinit -C -d "$dump"
  else
    compinit -d "$dump"
  fi
}

# 3. DEFERRED PLUGINS
[[ -f ~/zsh-defer/zsh-defer.plugin.zsh ]] && source ~/zsh-defer/zsh-defer.plugin.zsh

ZSH_CUSTOM="$HOME/.oh-my-zsh/custom"

load_heavy_stuff() {
    # FZF Tab
    [[ -f "$ZSH_CUSTOM/plugins/fzf-tab/fzf-tab.plugin.zsh" ]] && \
        source "$ZSH_CUSTOM/plugins/fzf-tab/fzf-tab.plugin.zsh"

    # Autosuggestions — try Arch path first, fall back to Debian/Kali
    local _as=/usr/share/zsh/plugins/zsh-autosuggestions/zsh-autosuggestions.zsh
    [[ -f $_as ]] || _as=/usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh
    [[ -f $_as ]] && source "$_as"
    ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=#999'

    # Syntax Highlighting — source then set ALL styles, fully deferred
    local _sh=/usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
    [[ -f $_sh ]] || _sh=/usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
    if [[ -f $_sh ]]; then
        source "$_sh"
        ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets pattern)
        ZSH_HIGHLIGHT_STYLES[default]=none
        ZSH_HIGHLIGHT_STYLES[unknown-token]=underline
        ZSH_HIGHLIGHT_STYLES[reserved-word]=fg=cyan,bold
        ZSH_HIGHLIGHT_STYLES[suffix-alias]=fg=green,underline
        ZSH_HIGHLIGHT_STYLES[global-alias]=fg=green,bold
        ZSH_HIGHLIGHT_STYLES[precommand]=fg=green,underline
        ZSH_HIGHLIGHT_STYLES[commandseparator]=fg=blue,bold
        ZSH_HIGHLIGHT_STYLES[autodirectory]=fg=green,underline
        ZSH_HIGHLIGHT_STYLES[path]=bold
        ZSH_HIGHLIGHT_STYLES[path_pathseparator]=
        ZSH_HIGHLIGHT_STYLES[path_prefix_pathseparator]=
        ZSH_HIGHLIGHT_STYLES[globbing]=fg=blue,bold
        ZSH_HIGHLIGHT_STYLES[history-expansion]=fg=blue,bold
        ZSH_HIGHLIGHT_STYLES[command-substitution]=none
        ZSH_HIGHLIGHT_STYLES[command-substitution-delimiter]=fg=magenta,bold
        ZSH_HIGHLIGHT_STYLES[process-substitution]=none
        ZSH_HIGHLIGHT_STYLES[process-substitution-delimiter]=fg=magenta,bold
        ZSH_HIGHLIGHT_STYLES[single-hyphen-option]=fg=green
        ZSH_HIGHLIGHT_STYLES[double-hyphen-option]=fg=green
        ZSH_HIGHLIGHT_STYLES[back-quoted-argument]=none
        ZSH_HIGHLIGHT_STYLES[back-quoted-argument-delimiter]=fg=blue,bold
        ZSH_HIGHLIGHT_STYLES[single-quoted-argument]=fg=yellow
        ZSH_HIGHLIGHT_STYLES[double-quoted-argument]=fg=yellow
        ZSH_HIGHLIGHT_STYLES[dollar-quoted-argument]=fg=yellow
        ZSH_HIGHLIGHT_STYLES[rc-quote]=fg=magenta
        ZSH_HIGHLIGHT_STYLES[dollar-double-quoted-argument]=fg=magenta,bold
        ZSH_HIGHLIGHT_STYLES[back-double-quoted-argument]=fg=magenta,bold
        ZSH_HIGHLIGHT_STYLES[back-dollar-quoted-argument]=fg=magenta,bold
        ZSH_HIGHLIGHT_STYLES[assign]=none
        ZSH_HIGHLIGHT_STYLES[redirection]=fg=blue,bold
        ZSH_HIGHLIGHT_STYLES[named-fd]=none
        ZSH_HIGHLIGHT_STYLES[numeric-fd]=none
        ZSH_HIGHLIGHT_STYLES[arg0]=fg=cyan
        ZSH_HIGHLIGHT_STYLES[bracket-error]=fg=red,bold
        ZSH_HIGHLIGHT_STYLES[bracket-level-1]=fg=blue,bold
        ZSH_HIGHLIGHT_STYLES[bracket-level-2]=fg=green,bold
        ZSH_HIGHLIGHT_STYLES[bracket-level-3]=fg=magenta,bold
        ZSH_HIGHLIGHT_STYLES[bracket-level-4]=fg=yellow,bold
        ZSH_HIGHLIGHT_STYLES[bracket-level-5]=fg=cyan,bold
        ZSH_HIGHLIGHT_STYLES[cursor-matchingbracket]=standout
        ZSH_HIGHLIGHT_STYLES[comment]=fg=#FFFFFF,bold
    fi

    # Broot launcher — deferred, only if installed
    [[ -f /home/dex/.config/broot/launcher/bash/br ]] && \
        source /home/dex/.config/broot/launcher/bash/br
}
zsh-defer load_heavy_stuff

# 4. CACHED BINARIES

# Zoxide
if [[ -f ~/.cache/zoxide.zsh ]]; then
    source ~/.cache/zoxide.zsh
elif command -v zoxide >/dev/null; then
    zoxide init zsh > ~/.cache/zoxide.zsh && source ~/.cache/zoxide.zsh
fi

# dircolors
if [[ -f ~/.cache/dircolors ]]; then
    eval "$(< ~/.cache/dircolors)"
elif command -v dircolors >/dev/null; then
    dircolors -b > ~/.cache/dircolors && eval "$(< ~/.cache/dircolors)"
fi


# Restore fzf's ** completion trigger after fzf-tab overwrites it
bindkey '^I' fzf-tab-complete 2>/dev/null || true
zstyle ':fzf-tab:*' continuous-trigger '/'

# Keychain — deferred, single biggest potential bottleneck
zsh-defer -c '[[ -z "$SSH_AUTH_SOCK" ]] && command -v keychain >/dev/null && eval $(keychain --eval --quiet --noask ~/.ssh/githubarch 2>/dev/null)'

# 5. OPTIONS
export KEYTIMEOUT=1
bindkey -e
unsetopt vi
HISTFILE=~/.zsh_history
HISTSIZE=50000
SAVEHIST=50000
setopt appendhistory sharehistory histignorealldups histignorespace
setopt incappendhistory autocd interactivecomments notify
setopt numericglobsort promptsubst nonomatch magicequalsubst HIST_FCNTL_LOCK
export ZSH_DISABLE_COMPFIX=true
PROMPT_EOL_MARK=""

stty ixon

# 6. KEY BINDINGS

# Arrows and Navigation
bindkey '\e[A' up-line-or-history
bindkey '\e[B' down-line-or-history
bindkey '\e[C' forward-char
bindkey '\e[D' backward-char
bindkey '\e[H' beginning-of-line
bindkey '\e[F' end-of-line
bindkey '\e[1~' beginning-of-line
bindkey '\e[4~' end-of-line

# Editing
bindkey '^U' backward-kill-line
bindkey '^K' kill-line
bindkey '^[[3;5~' kill-word
bindkey '^[[1;5C' forward-word
bindkey '^[[1;5D' backward-word
bindkey '^H' backward-delete-char
bindkey "^[[3~" delete-char
bindkey '^[[Z' undo
bindkey '^Y' yank
bindkey '^J' self-insert
bindkey ' ' magic-space
bindkey '^@' expand-or-complete

# Custom Widgets
fg-widget() { BUFFER="fg"; zle accept-line; }
zle -N fg-widget
bindkey '^[z' fg-widget

autoload -Uz edit-command-line
zle -N edit-command-line
bindkey '\en' edit-command-line

# History search
# bindkey -r -M viins '^R'
# bindkey -r -M vicmd '^R'
# bindkey -M vicmd '^R' redo

# bindkey -M viins '\er' fzf-history-widget
# bindkey -M vicmd '\er' fzf-history-widget
# 1. Fix History: Move FZF history to Alt+R
bindkey '^[r' redo



# Application Shortcuts
bindkey '^G' autosuggest-toggle
bindkey -s '\et' "tmux-sessionizer\r"
bindkey -s 's' "scratchpad-sessionizer"


# The siient ones, has potential but for now the usage is very minimal and isn't as good atm. I don't use these much. but keep them:
# _tm4() { tmux-sessionizer -s 4; zle reset-prompt }; zle -N _tm4; bindkey '\ey' _tm4
# _tm1() { tmux-sessionizer -s 1; zle reset-prompt }; zle -N _tm1; bindkey '\el' _tm1
# _tm3() { tmux-sessionizer -s 3; zle reset-prompt }; zle -N _tm3; bindkey '\eb' _tm3
# _tm0() { tmux-sessionizer -s 0; zle reset-prompt }; zle -N _tm0; bindkey '\eh' _tm0

# 7. PROMPT CONFIGURATION

zstyle ':vcs_info:*' check-for-changes false
zstyle ':vcs_info:git:*' formats ' %F{yellow}git:(%b)%f'
zstyle ':vcs_info:git:*' actionformats ' %F{yellow}git:(%b|%a)%f'
add-zsh-hook precmd vcs_info

PROMPT_ALTERNATIVE=oneline
NEWLINE_BEFORE_PROMPT=yes

configure_prompt() {
    local git_info='${vcs_info_msg_0_}'
    case "$PROMPT_ALTERNATIVE" in
        twoline)
            PROMPT=$'%F{%(#.blue.green)}┌──${debian_chroot:+($debian_chroot)─}${VIRTUAL_ENV:+($(basename $VIRTUAL_ENV))─}(%B%F{%(#.red.blue)}%n%b%F{%(#.blue.green)})-[%B%F{reset}%(6~.%-1~/…/%4~.%5~)%b%F{%(#.blue.green)}]'
            PROMPT+="$git_info"
            PROMPT+=$'\n└─%B${PROMPT_INDICATOR}%(#.%F{red}#.%F{blue}$)%b%F{reset} '
            ;;
        oneline)
            PROMPT=$'%F{green}→%f %F{cyan}%1.%f'"$git_info"$' %F{white}×%f '
            ;;
    esac
}

toggle_oneline_prompt() {
    [[ "$PROMPT_ALTERNATIVE" == "oneline" ]] && PROMPT_ALTERNATIVE=twoline || PROMPT_ALTERNATIVE=oneline
    configure_prompt
    zle reset-prompt
}
zle -N toggle_oneline_prompt
bindkey '^P' toggle_oneline_prompt

case "$TERM" in
xterm*|rxvt*|Eterm|aterm|kterm|gnome*|alacritty|kitty)
    TERM_TITLE=$'\e]0;${debian_chroot:+($debian_chroot)}${VIRTUAL_ENV:+($(basename $VIRTUAL_ENV))}%n@%m: %~\a'
    ;;
esac

_zsh_precmd_actions() {
    print -Pnr -- "$TERM_TITLE"
    if [[ "$NEWLINE_BEFORE_PROMPT" == yes ]]; then
        [[ -z "$_NEW_LINE_BEFORE_PROMPT" ]] && _NEW_LINE_BEFORE_PROMPT=1 || print ""
    fi
}
add-zsh-hook precmd _zsh_precmd_actions

configure_prompt

# Alacritty dynamic title
if [[ "$TERM" == "alacritty" ]]; then
    alacritty_preexec() { print -Pn "\e]0;$1\a" }
    alacritty_precmd()  { print -Pn "\e]0;%~\a" }
    add-zsh-hook preexec alacritty_preexec
    add-zsh-hook precmd  alacritty_precmd
fi











####-------------------------------------------------------------------
#### ALIASES & FUNCTIONS
####-------------------------------------------------------------------

# Must have on every OS
alias ll='ls -alhF'
alias la='ls -AlhF'
alias l='ls -CF'
alias ls='ls --color=auto'
alias diff='diff --color=auto'
alias grep='grep --color=auto'
alias fgrep='grep -F --color=auto'
alias egrep='grep -E --color=auto'

# nvim is better than vim. If only vim then just use vi instead.
alias -g vim='nvim'

# frequently used
alias t='task'
alias j='jobs'
alias f='fg'
alias d='date'
alias tt='timew'

# maintainance
alias nvrc='nvim ~/.zshrc'
alias nvenv='nvim ~/.zshenv'
alias nvnv='cd ~/.config/nvim/ ; nvim .'

# Also Afeh and AFEH are in ~/.local/bin/ as binaries for dmenu availability
alias Afeh='cd ~/tmpshot ; feh -R 5 -S mtime --reverse --geometry 3286x1080+0+0 --borderless --info "echo %F" .'
alias AFEH='cd ~/tmpshot ; feh -R 5 -S mtime --reverse --geometry 3286x1080+0+0 --borderless'



alias mpvg='mpv --player-operation-mode=pseudo-gui'
alias mpvyt='mpv --ytdl-format='
alias streamlink='streamlink --player mpv'

# Toggle laptop on and restart Gromit
alias laptop-on='xrandr --output eDP-1 --auto --right-of HDMI-1 && pkill gromit-mpx 2>/dev/null; sleep 1; gromit-mpx >/dev/null 2>&1 &!'

# Toggle laptop off and restart Gromit
alias laptop-off='xrandr --output eDP-1 --off && pkill gromit-mpx; sleep 1; gromit-mpx >/dev/null 2>&1 &!'



alias refresh_urxvt='xrdb -merge ~/.Xresources && killall urxvtd && echo "URxvt Refreshed!"'
alias define='sdcv'

alias -g ]]r='source ~/.zshrc ; source ~/.zshenv'
alias md='mkdir -p'
alias history="history 0"



alias mydocs='kiwix-serve --library --port 8080 ~/KiwixLibrary/library.xml'


alias p='ps aux | grep'
alias m='mpv * --loop-playlist'
alias sudo='sudo '
alias py='python'
alias msgbox='zenity'
alias o='less'
alias wireshark-dark='QT_STYLE_OVERRIDE=kvantum-dark wireshark'
alias obo='~/scripts/ddesk/obsidian/run-obsidian-script.sh'

alias \00.='setxkbmap -layout us'
alias \01.='setxkbmap -layout fr'
alias \02.='setxkbmap -layout ara'
alias \04.='setxkbmap us_rpd'

alias cdd='cd $(dirname "$(fp)")'
alias cdfp='cd $(dirname "$(fp)")'
alias ob='obsidian-cli'

alias nh='ssh nh'
alias termux='ssh termux'
alias dell='ssh dell'
alias ads='adb shell'

alias ip='ip --color=auto'
alias -g xc='| col -b | xclip -selection clipboard'


alias s='cd ~/scripts'
alias a='cd ~/archive_fossil/'
alias wo='cd ~/work'
alias wi='cd ~/wiki'
alias cu='cd ~/work/current_struggles/'

# For phone quick echo "<text>" | ca
alias ca='DISPLAY=:0 copyq copy -'


alias so='cd ~/work/sources/'


alias acal='while true; do cal -w ; sleep 300; clear; done'




alias zkc='file=$(find ~/work/current_struggles -type f | fzf --delimiter / --with-nth -1 --layout=default --preview-window="up:65%:wrap" --preview "bat --color=always --style=numbers --line-range=:500 {}" --bind "alt-w:toggle-wrap,alt-j:preview-page-down,alt-k:preview-page-up,alt-J:preview-down,alt-K:preview-up") && [ -n "$file" ] && nvim "$file"'
alias zks='file=$(find ~/work/sources -type f | fzf --delimiter / --with-nth -1 --layout=default --preview-window="up:65%:wrap" --preview "bat --color=always --style=numbers --line-range=:500 {}" --bind "alt-w:toggle-wrap,alt-j:preview-page-down,alt-k:preview-page-up,alt-J:preview-down,alt-K:preview-up") && [ -n "$file" ] && nvim "$file"'


alias zkw='file=$(find ~/wiki/ \( -name .git -o -name .zk \) -prune -o -type f -name "*.md" -print | fzf --delimiter / --with-nth -1 --layout=default --preview-window="up:65%:wrap" --preview "bat --color=always --style=numbers --line-range=:500 {}" --bind "alt-w:toggle-wrap,alt-j:preview-page-down,alt-k:preview-page-up,alt-J:preview-down,alt-K:preview-up") && [ -n "$file" ] && nvim "$file"'

alias zka='file=$(find ~/archive_fossil/ \( -name .git -o -name .zk \) -prune -o -type f -print | fzf --delimiter / --with-nth -1 --layout=default --preview-window="up:65%:wrap" --preview "bat --color=always --style=numbers --line-range=:500 {}" --bind "alt-w:toggle-wrap,alt-j:preview-page-down,alt-k:preview-page-up,alt-J:preview-down,alt-K:preview-up") && [ -n "$file" ] && nvim "$file"'

alias scratch='tmux new-session -d -s scratch 2>/dev/null; tmux switch-client -t scratch || tmux attach-session -t scratch'
alias scr='tmux new-session -d -s scratch 2>/dev/null; tmux switch-client -t scratch || tmux attach-session -t scratch'
alias uvim='UVIM_MODE=true nvim'
alias lag='lazygit'
alias ff='fastfetch'
alias neofetch='fastfetch'
alias c='clear; _NEW_LINE_BEFORE_PROMPT=1'

alias ws='watson start'
alias wss='watson status'
alias wp='watson stop'
alias wl='watson log --day'
alias wll='watson log --all | tac | bat'
alias wlll='watson log --all | tac | bat'
alias wr='watson report --day'
alias wre='watson restart'
alias we='watson edit'
alias watson-yesterday='watson report --from $(date -d "yesterday" +%F) --to $(date -d "yesterday" +%F)'

alias ptask='cd ~/watson && ./p && cd -'
alias pt='cd ~/watson && ./p && cd -'
alias -g P='cd ~/watson && ./p && cd -'
alias stask='cd ~/watson && ./s && cd -'
alias st='cd ~/watson && ./s && cd -'
alias -g S='cd ~/watson && ./s && cd -'

alias e='exit'
alias ee='exit'
alias eee='exit'
alias eeee='exit'

alias i='hostname -i'
alias I='hostname -I'
alias II='ip addr show | grep "inet " | grep -v 127.0.0.1'
alias h='whoami'

alias mon-on='xrandr --output HDMI-1 --auto --primary --output eDP-1 --auto --right-of HDMI-1'
alias mon-off='xrandr --output eDP-1 --off --output HDMI-1 --auto --primary'


alias c.d='cd ~/Desktop'
alias c.dd='cd ~/Downloads'
alias c.doc='cd ~/Documents'
alias c.f='cd ~/fleet'
alias c.s='cd ~/scripts'
alias c.v='cd ~/fleet/vaults'
alias c.ps='~/Pictures/Screenshots'
alias c.p='~/Pictures'

alias q='qalc'
alias ]timer='_my_timer_func'
alias timer='_my_timer_func'
















###-----------------
### functions
###-----------------



# xo() { xdg-open "$@" }
open() { xdg-open "$@" }

lg()  { [[ -z "$1" ]] && lsd -l --color=always || lsd -la --color=always | grep "$1" }
lsg() { lg "$@" }

ollama-stop() {
  curl -sd "{\"model\": \"$1\", \"keep_alive\": 0}" http://localhost:11434/api/generate > /dev/null
  echo "Unloaded model: $1"
}


ipinfo() {
    if [[ -z "$1" ]]; then
        echo "\nhere is curl ipinfo.io:\n"; curl ipinfo.io
        echo "\n\nIn case ipinfo.io is down, here is curl icanhazip.com:\n"; curl icanhazip.com
        echo "\nTIP: similar to 'whois', you can also type 'ipinfo <give_an_ip>'"
    else
        curl ipinfo.io/"$1"
    fi
}

# This is when I want to copy images to clipboard from terminal. You can't do that with just xc
xxc() {
    [[ -z "$1" ]] && { echo "Usage: xxc <file_path>" >&2; return 1 }
    [[ ! -f "$1" ]] && { echo "Error: File not found: '$1'" >&2; return 1 }
    local filepath="$1" ext mimetype
    ext=$(echo "${filepath##*.}" | tr '[:upper:]' '[:lower:]')
    case "$ext" in
        png)      mimetype="image/png" ;;
        jpg|jpeg) mimetype="image/jpeg" ;;
        gif)      mimetype="image/gif" ;;
        webp)     mimetype="image/webp" ;;
        svg)      mimetype="image/svg+xml" ;;
        bmp)      mimetype="image/bmp" ;;
        *)        mimetype="text/plain" ;;
    esac
    if [[ -n "$WAYLAND_DISPLAY" ]]; then
        command -v wl-copy &>/dev/null || { echo "Error: 'wl-copy' not found." >&2; return 1 }
        [[ "$mimetype" == "text/plain" ]] && wl-copy < "$filepath" || wl-copy -t "$mimetype" < "$filepath"
        echo "Copied '$filepath' to Wayland clipboard as '$mimetype'."
    else
        command -v xclip &>/dev/null || { echo "Error: 'xclip' not found." >&2; return 1 }
        [[ "$mimetype" == "text/plain" ]] && xclip -selection clipboard < "$filepath" \
            || xclip -selection clipboard -t "$mimetype" < "$filepath"
        echo "Copied '$filepath' to X11 clipboard as '$mimetype'."
    fi
}

xkill() {
    case "$1" in
        -p|--pause)
            echo "Click on the window to PAUSE..."
            local pid=$(xprop _NET_WM_PID | awk '{print $3}')
            [[ -n "$pid" ]] && kill -STOP "$pid" && echo "Process PID $pid paused." || echo "No window selected."
            ;;
        -c|--continue)
            echo "Click on the window to CONTINUE..."
            local pid=$(xprop _NET_WM_PID | awk '{print $3}')
            [[ -n "$pid" ]] && kill -CONT "$pid" && echo "Process PID $pid continued." || echo "No window selected."
            ;;
        *)
            command xkill "$@"
            ;;
    esac
}

_my_timer_func() {
    date "+%T %a, %d-%m"; echo ""
    local start=$(date +%s) last_mins=-1
    while true; do
        local elapsed=$(( $(date +%s) - start ))
        local hours=$(( elapsed / 3600 )) mins=$(( (elapsed / 60) % 60 ))
        [[ "$mins" -ne "$last_mins" ]] && { printf "\r%02d:%02d" $hours $mins; last_mins=$mins }
        sleep 1
    done
}

# keep this one
# service() {
#     [[ "$2" == "status" ]] && systemctl status "$1" || sudo systemctl "$2" "$1"
# }

phoneWakeup() {
    local dev=$(adb devices | grep '192.168.11.118:' | awk '{print $1}')
    [[ -z "$dev" ]] && { echo "Error: Phone not found."; return 1 }
    echo "Waking up device: $dev"
    adb -s "$dev" shell input keyevent KEYCODE_WAKEUP
}

phoneSleep() {
    local dev=$(adb devices | grep '192.168.11.118:' | awk '{print $1}')
    [[ -z "$dev" ]] && { echo "Error: Phone not found."; return 1 }
    echo "Putting device to sleep: $dev"
    adb -s "$dev" shell input keyevent KEYCODE_SLEEP
}


# Keep these comments
# rr() {
#     echo "Please select the window or region you want to stream..."
#     local selection=$(slop -f "%x %y %w %h")
#     [[ -z "$selection" ]] && { echo "No region selected."; return 1 }
#     read -r x y w h <<< "$selection"
#     ffplay -fflags nobuffer -flags low_delay -framedrop -hwaccel vaapi \
#            -f x11grab -framerate 30 -video_size "${w}x${h}" -i ":0.0+${x},${y}" \
#            -noborder -alwaysontop -window_title "Spy Cam"
# }
#
# rr_medium() {
#     local selection=$(slop -f "%x %y %w %h")
#     [[ -z "$selection" ]] && { echo "No region selected."; return 1 }
#     read -r x y w h <<< "$selection"
#     ffplay -f x11grab -video_size ${w}x${h} -i ":0.0+${x},${y}" \
#            -fflags nobuffer -flags low_delay -framedrop -framerate 30 \
#            -noborder -alwaysontop -window_title "Live Preview"
# }
#
# rr_light() {
#     local selection=$(slop -f "%x %y %w %h")
#     [[ -z "$selection" ]] && { echo "No region selected."; return 1 }
#     read -r x y w h <<< "$selection"
#     ffplay -f x11grab -video_size ${w}x${h} -i ":0.0+${x},${y}" \
#            -framerate 8 -noborder -alwaysontop -window_title "Light Preview" -x ${w} -y ${h}
# }

weather() { curl -s "wttr.in/$1" }

Ecat() {
    local files=(**/*(.))
    for f in "${files[@]}"; do
        [[ $(file -b --mime-type "$f") == text/* ]] && cat "$f"
    done | xclip -selection clipboard
}

function y() {
    local tmp="$(mktemp -t "yazi-cwd.XXXXXX")" cwd
    command yazi "$@" --cwd-file="$tmp"
    IFS= read -r -d '' cwd < "$tmp"
    [[ "$cwd" != "$PWD" && -d "$cwd" ]] && builtin cd -- "$cwd"
    rm -f -- "$tmp"
}

# Zoxide interactive with previews
if command -v zoxide >/dev/null; then
    zi() {
        local fzf_opts
        local common="--layout=default --preview-window='up:65%:wrap' --bind 'alt-j:preview-page-down,ctrl-f:preview-page-down,alt-k:preview-page-up,ctrl-b:preview-page-up,alt-J:preview-down,alt-K:preview-up'"
        case "$1" in
            -l)      fzf_opts="$common --preview=\"(echo '{2..}:'; echo; eza --long --color=always {2..})\""; shift ;;
            -lt|-tl) fzf_opts="$common --preview='eza --long --tree --level=1 --color=always {2..}'"; shift ;;
            -t)      fzf_opts="$common --preview='eza --tree --level=1 --color=always {2..}'"; shift ;;
            -la|-al) fzf_opts="$common --preview=\"(echo '{2..}:'; echo; eza --long --all --color=always {2..})\""; shift ;;
            -lag|-lga|-alg|-agl|alg) fzf_opts="$common --preview=\"(echo '{2..}:'; echo; eza -g --long --all --color=always {2..})\""; shift ;;
            -g)      fzf_opts="$common --preview=\"(echo '{2..}:'; echo; eza -g --color=always {2..})\""; shift ;;
            -ga|-ag) fzf_opts="$common --preview=\"(echo '{2..}:'; echo; eza -g --all --color=always {2..})\""; shift ;;
            -lg|-gl) fzf_opts="$common --preview=\"(echo '{2..}:'; echo; eza -g --long --color=always {2..})\""; shift ;;
            -a)      fzf_opts="$common --preview=\"(echo '{2..}:'; echo; eza --all --color=always {2..})\""; shift ;;
            *)       fzf_opts="$common --preview=\"(echo '{2..}:'; echo; eza --tree --level=1 --color=always {2..})\"" ;;
        esac
        _ZO_FZF_OPTS="$fzf_opts" __zoxide_zi "$@"
    }
fi


ssleep() {
    # Convert units to seconds (handles 30m, 1h, etc.)
    local sec=$(echo "$1" | sed 's/s//; s/m/*60/; s/h/*3600/; s/d/*86400/' | bc)
    for ((i=0; i<sec; i++)); do
        sleep 1
    done
}


# -------------------------------------------------------------------
# COLOR & COMPLETION STYLES
# -------------------------------------------------------------------

if [[ -x /usr/bin/dircolors ]]; then
    export LESS_TERMCAP_mb=$'\E[1;31m'
    export LESS_TERMCAP_md=$'\E[1;36m'
    export LESS_TERMCAP_me=$'\E[0m'
    export LESS_TERMCAP_so=$'\E[01;33m'
    export LESS_TERMCAP_se=$'\E[0m'
    export LESS_TERMCAP_us=$'\E[1;32m'
    export LESS_TERMCAP_ue=$'\E[0m'
    zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
    zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'
fi

[[ -f /usr/share/doc/pkgfile/command-not-found.zsh ]] && source /usr/share/doc/pkgfile/command-not-found.zsh
[[ -f /usr/share/pkgfile/command-not-found.zsh ]]     && source /usr/share/pkgfile/command-not-found.zsh

if [[ -x /usr/bin/lesspipe ]]; then
    export LESSOPEN="| /usr/bin/lesspipe %s"
    export LESSCLOSE="/usr/bin/lesspipe %s %s"
fi

zstyle ':completion:*:git-checkout:*' sort false
zstyle ':completion:*:descriptions' format '[%d]'
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}
zstyle ':completion:*' menu no
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'eza -1 --color=always $realpath'
zstyle ':fzf-tab:*' fzf-flags --color=fg:1,fg+:2 --bind=tab:accept
zstyle ':fzf-tab:*' switch-group '<' '>'
zstyle ':completion:*:*:*:*:*' menu select
zstyle ':completion:*' auto-description 'specify: %d'
zstyle ':completion:*' format '%d'
zstyle ':completion:*' group-name ''
zstyle ':completion:*' list-colors ''
zstyle ':completion:*' list-prompt %SAt %p: Hit TAB for more, or the character to insert%s
zstyle ':completion:*' matcher-list 'm:{a-zA-Z}={A-Za-z}'
zstyle ':completion:*' rehash true
zstyle ':completion:*' select-prompt %SScrolling active: current selection at %p%s
zstyle ':completion:*' use-compctl false
zstyle ':completion:*' verbose true
zstyle ':completion:*:kill:*' command 'ps -u $USER -o pid,%cpu,tty,cputime,cmd'

# -------------------------------------------------------------------
# EXTRA FUNCTION FILES
# -------------------------------------------------------------------

[[ -f $HOME/.config/zsh/functions/fp ]]          && source $HOME/.config/zsh/functions/fp
[[ -f $HOME/.config/zsh/functions/wgetpaste ]]   && source $HOME/.config/zsh/functions/wgetpaste
[[ -f $HOME/.config/zsh/functions/cp-alphabit ]] && source $HOME/.config/zsh/functions/cp-alphabit
[[ -f $HOME/.config/zsh/functions/_cat ]]        && source $HOME/.config/zsh/functions/_cat
[[ -f $HOME/.config/zsh/functions/_clip ]]       && source $HOME/.config/zsh/functions/_clip

compdef _files cat

# Watson completion
_watson_custom_completion() {
    local -a commands=(add aggregate cancel config edit frames help log merge projects remove rename report restart start status stop sync tags)
    (( CURRENT == 2 )) && { _describe -t commands 'watson commands' commands; return }
    if [[ -z "$_watson_projects_cache" || "$(( SECONDS - _watson_last_cache_update ))" -gt 30 ]]; then
        _watson_projects_cache=(${(f)"$(watson projects 2>/dev/null)"})
        _watson_tags_cache=(${(f)"$(watson tags 2>/dev/null | sed 's/^/+/')"})
        _watson_last_cache_update=$SECONDS
    fi
    case $words[2] in
        start|add|restart|report|log|edit)
            [[ $words[CURRENT] == +* ]] && _values 'tags' $_watson_tags_cache || _values 'projects' $_watson_projects_cache
            ;;
    esac
}
compdef _watson_custom_completion watson


# fzf MUST be last so its ** widget isn't overwritten by fzf-tab
source <(fzf --zsh)

