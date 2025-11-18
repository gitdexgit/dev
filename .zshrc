# alias nano="nvim"
## run this to memorize the oh-my-zsh git plugin aliases they are good shit
# alias | grep 'git='


export KEYTIMEOUT=1
bindkey -e
unsetopt vi



















#-] now .zshrc main shit what above this are some eseensials stuff

# github ssh
#[!RUN]# [Manual] run `keychain --eval ssh ` or whatever on first terminal of the day 1 time and that's it

eval `keychain --eval ~/.ssh/githubarch 2>/dev/null`


# ================= !!!!!!!!! =====================
# ================= !!!!!!!!! =====================



# ---- Requirements ------
# for root user log in with `su -` or log out and log in with root user
# if you do just `su` it will keep the env variables of your daily driver users
# which will not let you do step (1) in the requirements. also don't overwrite when prompted
# in oh-my-zsh you already have a .zshrc and .zshenv set up

# 1) git oh-my-zsh
# requirements, zsh shell, curl or wget
# sh -c "$(curl -fsSL https://raw.githubusercontent.com/ohmyzsh/ohmyzsh/master/tools/install.sh)"

# 2) get zsh-vi-mode
# git clone https://github.com/jeffreytse/zsh-vi-mode \
#   $ZSH_CUSTOM/plugins/zsh-vi-mode
# (OPTIONAL) if you can't use oh-my-zsh for some reason you can get the plugin in the AUR
# If installed via aur you can source it with 
# source /usr/share/zsh/plugins/zsh-vi-mode/zsh-vi-mode.plugin.zsh

# END---- Requirements END------





# _)
# W40 Mon, 29 at 07:54
# ---START------------------------------------------------------------
# ""[AI][FAILED][BUT]This is from ai to hopefully speed up the start up process the sourcing thing and exprot and things are slowing down my start up but it's a lie""

# [[]]

# DESCRIPTION:

# Why?:

# --------------------------------------------------------------------

# [WARN] This didn't work
# Add custom completions directory to the function path
# This is a lie
# fpath=($HOME/.config/zsh/functions $fpath)



# [BUT] this works for some reason I'm confused
fpath=($HOME/.config/zsh/completions $fpath)

# NEW: Add your functions directory to fpath
fpath=($HOME/.config/zsh/functions $fpath)





# --------------------------------------------------------------------
# ""[AI][FAILED]This is from ai to hopefully speed up the start up process the sourcing thing and exprot and things are slowing down my start up but it's a lie""
# ---END--------------------------------------------------------------



# _)
# W40 Tue, 30 at 05:20
# ---START------------------------------------------------------------
# ""termux config""
# --------------------------------------------------------------------

# [[]]

# DESCRIPTION:

# Why?:

# Solution?:

# --------------------------------------------------------------------

    
if [[ -v TERMUX_VERSION ]]; then
  setopt re_match_pcre
  # Add Termux-specific settings here
  
  # 1. Use the simple, common Termux hostname
  # You can try setting a simple hostname:
  # export HOSTNAME="termux" 
  
  # 2. Force the prompt to be configured immediately in Termux
  PROMPT_ALTERNATIVE=twoline # Or 'oneline' if you prefer
  NEWLINE_BEFORE_PROMPT=yes 
  
  # Termux uses xterm-256color, so color_prompt should be 'yes'
  color_prompt=yes 
  
fi





# --------------------------------------------------------------------
# ""termux config""
# ---END--------------------------------------------------------------

# The top of your .zshrc should look like this


# Add these near the top of your .zshrc (after KEYTIMEOUT)

# Speed up zsh startup and operation
export ZSH_DISABLE_COMPFIX=true  # Skip security checks (safe for personal use)

# Optimize completion system
zstyle ':completion:*' use-cache on
zstyle ':completion:*' cache-path ~/.cache/zsh-completion-cache

# Reduce git prompt delay (if you use vcs_info)
zstyle ':vcs_info:*' check-for-changes false
zstyle ':vcs_info:*' disable-patterns "${(b)HOME}/.*"

# Optimize history
setopt HIST_FCNTL_LOCK  # Faster history file locking


# I don't even need this tbh. and it sucks tbh
# export ZVM_VI_INSERT_ESCAPE_BINDKEY=JJ



# _)
# # W45 Wed, 05 at 14:45
# # ---START------------------------------------------------------------
# # ""plugins""
# # --------------------------------------------------------------------
#
# # [[]]
#
# # DESCRIPTION:
#
# # Why?:
#
# # Solution?:
#
# # --------------------------------------------------------------------



#------------ I don't know what's this 
# I want asdf but like I need to first learn it ok so no asdf

# if command -v asdf &> /dev/null; then
#   . "$(asdf direnv hook zsh)"
#   . "$(asdf init zsh)"
# fi




# ASDF Initialization: Add shims to PATH
# export PATH="${ASDF_DATA_DIR:-$HOME/.asdf}/shims:$PATH"

# ASDF Completion Setup
# append completions to fpath
# fpath=(${ASDF_DATA_DIR:-$HOME/.asdf}/completions $fpath)

# initialise completions with ZSH's compinit
# autoload -Uz compinit && compinit
#END------------ I don't know what's this 









# --- MANUAL PLUGIN SOURCING (Termux Optimized) ---
ZSH_CUSTOM="$HOME/.oh-my-zsh/custom"



# 2. FZF-TAB
FZF_TAB_PATH="$ZSH_CUSTOM/plugins/fzf-tab" 
if [ -f "$FZF_TAB_PATH/fzf-tab.plugin.zsh" ]; then
    source "$FZF_TAB_PATH/fzf-tab.plugin.zsh"
fi

# # 3. ZSH SYNTAX HIGHLIGHTING
# ZSH_SYNTAX_HIGHLIGHTING_PATH="$ZSH_CUSTOM/plugins/zsh-syntax-highlighting"
# if [ -f "$ZSH_SYNTAX_HIGHLIGHTING_PATH/zsh-syntax-highlighting.zsh" ]; then
#     source "$ZSH_SYNTAX_HIGHLIGHTING_PATH/zsh-syntax-highlighting.zsh"
#     # Keeping your custom styles here:
#     # (All your ZSH_HIGHLIGHT_STYLES definitions go here)
# fi

# 4. ZSH AUTOSUGGESTIONS
ZSH_AUTOSUGGESTIONS_PATH="$ZSH_CUSTOM/plugins/zsh-autosuggestions"
if [ -f "$ZSH_AUTOSUGGESTIONS_PATH/zsh-autosuggestions.zsh" ]; then
    source "$ZSH_AUTOSUGGESTIONS_PATH/zsh-autosuggestions.zsh"
    ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=#999'
fi

# NOTE: You may need to manually install these plugins into $ZSH_CUSTOM/plugins/ 
# if you used 'pkg install' on Termux and they landed elsewhere.



#----------------------------------------------------------------------
# ---------------------   Oh-my-zsh non-manual plugins ---------------
#----------------------------------------------------------------------

# ================= Oh My Zsh Configuration =================
export ZSH="$HOME/.oh-my-zsh"

# Oh My Zsh plugins
plugins=(
    git
)

# Source Oh My Zsh
source $ZSH/oh-my-zsh.sh




# # --------------------------------------------------------------------
# # ""plugins""
# # ---END--------------------------------------------------------------
# 





# _)
# # W45 Wed, 05 at 14:30
# # ---START------------------------------------------------------------
# # ""goodbey zi-vi-mode""
# # --------------------------------------------------------------------
#
# # [[]]
#
# # DESCRIPTION:
#
# # Why?:
#
# # Solution?:
#
# # --------------------------------------------------------------------


# ZSH_VI_MODE_PATH="$ZSH_CUSTOM/plugins/zsh-vi-mode"

# export ZVM_VI_MODE_DEFAULT_MODE=viins

# 1. ZSH VI MODE
# if [ -f "$ZSH_VI_MODE_PATH/zsh-vi-mode.plugin.zsh" ]; then
#     source "$ZSH_VI_MODE_PATH/zsh-vi-mode.plugin.zsh"
# fi


# function zvm_after_init() {
#     ZVM_INSERT_MODE_CURSOR=$ZVM_CURSOR_BLOCK
#     PROMPT_INDICATOR="%F{cyan}[I]%f"
#
#     bindkey -M viins '^[' vi-cmd-mode
#     bindkey -M viins -rp '^['
#     bindkey -M viins '\e[A' up-line-or-history
#     bindkey -M viins '\e[B' down-line-or-history
#     bindkey -M viins '\e[C' forward-char
#     bindkey -M viins '\e[D' backward-char
#     # Fix Ctrl+V paste
#     # Enable better paste handling
#     # Or use Alt+V
#
#
#     # Add clipboard paste functionality for Ctrl+V
#     zle -N paste-from-clipboard
#     paste-from-clipboard() {
#         local clip_content
#         if command -v xclip >/dev/null 2>&1 && [ -n "$DISPLAY" ]; then
#             clip_content=$(xclip -selection clipboard -o 2>/dev/null)
#         elif command -v wl-paste >/dev/null 2>&1 && [ -n "$WAYLAND_DISPLAY" ]; then
#             clip_content=$(wl-paste 2>/dev/null)
#         fi
#
#         if [ -n "$clip_content" ]; then
#             LBUFFER+="$clip_content"
#         fi
#     }
#
#     # Bind Ctrl+V to paste from clipboard
#     bindkey -M viins '^V' paste-from-clipboard
#     bindkey -M vicmd '^V' paste-from-clipboard
#
#
#
#
# _update_vi_mode_indicator() {
#     local indicator
#     local cursor
#
#     case $KEYMAP in
#         vicmd)
#             indicator="%F{yellow}[N]%f"
#             cursor='\e[2 q' # Block cursor
#             ;;
#         viins|main)
#             indicator="%F{cyan}[I]%f"
#             cursor='\e[2 q' # Block cursor (CHANGED FROM \e[6 q)
#             ;;
#         viopp)
#             indicator="%F{red}[O]%f" # Operator-pending
#             cursor='\e[2 q' # Block cursor
#             ;;
#     esac
#
#     PROMPT_INDICATOR=$indicator
#     echo -ne "$cursor"
#     zle .reset-prompt
# }
#
# zle -N zle-keymap-select _update_vi_mode_indicator
#
#
# TRAPINT() {
#     if [[ -o zle ]]; then
#         zle .vi-insert
#         _update_vi_mode_indicator
#     fi
#     return 130
# }
#
#
#
#
#
# # --- FZF Kill Ring (Paste History) Widget ---
#
# # 1. Define the function that will be our widget.
# # fzf-kill-ring-widget() {
# #   # Check if the kill ring has anything in it.
# #   if (( ${#killring[@]} == 0 )); then
# #     zle -M "Kill ring is empty." # Show a message at the bottom
# #     return 1
# #   fi
# #
# #   # Pipe the kill ring array into fzf.
# #   # - Each item in the array is printed on a new line.
# #   # - The output of fzf (the selected line) is stored in the 'selection' variable.
# #   local selection
# #   selection=$(printf "%s\n" "${(@)killring}" | fzf --prompt="Paste History > " \
# #     --height=40% --layout=reverse --border --tac)
# #
# #   # If the user selected something (didn't press Esc),
# #   # insert it at the current cursor position.
# #   if [[ -n "$selection" ]]; then
# #     LBUFFER+="$selection"
# #   fi
# # }
# #
# # # 2. Register our function as a ZLE (Zsh Line Editor) widget.
# # zle -N fzf-kill-ring-widget
# #
# # # 3. Bind the new widget to a key.
# # # Alt+Y (Shift+y) is a great choice, as it's related to the old Alt+y.
# # bindkey -M viins '\ey' fzf-kill-ring-widget
# # bindkey -M vicmd '\ey' fzf-kill-ring-widget
#
#
# # [WARN] This could potentially make problems. <-- [FALSE] W40 Mon, 29 at 15:11: sadly I need this because
# # it will make alt+r and things not work. so I need to source this sadly
# # fzf-tab hadnles all the necessary fzf integration itself so no need for the [ -f ...
# # Load fzf keybindings and completions
# # Load fzf keybindings and completions
# [ -f ~/.fzf.zsh ] && source ~/.fzf.zsh
#
#    # --- Re-bind Custom Keys for Vi Insert and Normal Modes ---
#
#    #=== If no vi mode ues =====
#
#    # bindkey '^@' expand-or-complete
#    # bindkey '^G' autosuggest-toggle
#
#    #===END If no vi mode ues =====
#
#    # --- Application Launchers (Both Modes) ---
#    # Binds Ctrl+Space to the original completion menu. you know to have both world fzf-tab and this
#    bindkey -M viins '^@' expand-or-complete
#    bindkey -M vicmd '^@' expand-or-complete
#    # A way to toggle zsh suggestions on and off. works only in insert mode
#    bindkey -M viins '^G' autosuggest-toggle
#    bindkey -M vicmd '^G' autosuggest-toggle
#    bindkey -s -M viins '\et' "tmux-sessionizer\r"
#    bindkey -s -M vicmd '\et' "tmux-sessionizer\r"
#    bindkey -s -M viins '\eh' "tmux-sessionizer -s 0\r"
#    bindkey -s -M vicmd '\eh' "tmux-sessionizer -s 0\r"
#    # bindkey -s -M viins '\el' "tmux-sessionizer -s 1\r"
#    # bindkey -s -M vicmd '\el' "tmux-sessionizer -s 1\r"
#    bindkey -s -M viins '\el' "tmux-sessionizer -s 1\r"
#    bindkey -s -M vicmd '\el' "tmux-sessionizer -s 1\r"
#    bindkey -s -M viins '\en' "tmux-sessionizer -s 2\r"
#    bindkey -s -M vicmd '\en' "tmux-sessionizer -s 2\r"
#    bindkey -s -M viins '\eb' "tmux-sessionizer -s 3\r"
#    bindkey -s -M vicmd '\eb' "tmux-sessionizer -s 3\r"
#    # it ddoes' want to work
#    bindkey -s -M viins '\ey' "tmux-sessionizer -s 4\r"
#    bindkey -s -M vicmd '\ey' "tmux-sessionizer -s 4\r"
#    bindkey -s -M viins '\ev' "nvim \$(fzf)\r"
#    bindkey -s -M vicmd '\ev' "nvim \$(fzf)\r"
#
#   # --- General Editing & Navigation (Mostly for Insert Mode) ---
#   # Some are also bound in Normal mode for a consistent experience,
#   # overriding some default Vi keybindings.
#
#   # Unbind Ctrl+S to prevent terminal freeze
#   ##DON't: because I need this for things that move fast in the terminal and for htop
#   # bindkey -r -M viins '^S'
#   # bindkey -r -M vicmd '^S'
#
#   # Line editing
#   bindkey -M viins '^U' backward-kill-line
#   bindkey -M viins '^K' kill-line
#   bindkey -M vicmd '^K' kill-line 
#
#   # Word/Char editing
#   bindkey -M viins '^[[3;5~' kill-word      # Ctrl+Delete
#   bindkey -M vicmd '^[[3;5~' kill-word      # Ctrl+Delete
#   bindkey -M viins '^[[3~'   delete-char    # Delete
#   bindkey -M viins '^[[1;5C' forward-word   # Ctrl+Right
#   bindkey -M vicmd '^[[1;5C' forward-word
#   bindkey -M viins '^[[1;5D' backward-word  # Ctrl+Left
#   bindkey -M vicmd '^[[1;5D' backward-word
#   bindkey -M viins '^H' backward-delete-char  # fix C-h buggy in insert mode after normal mode
#
#   # ==== This is stupid don't do the alt+e and alt+a it's just how in normal mode vim works instead adopt the H L 
#   # bindkey  '\ea' beginning-of-line because in normal mode ctrl+a incremnts and \ee works but do I want to use it ? 
#   # bindkey -M vicmd '\ea' beginning-of-line
#   # bindkey -M viins '\ea' beginning-of-line
#   # bindkey -M viins '\ee' end-of-line     # Ctrl+E
#   # bindkey -M vicmd '\ee' end-of-line
#
#   bindkey -M vicmd 'H' beginning-of-line
#   bindkey -M vicmd '\L' end-of-line
#
#   # bindkey -M viins '^[[H' beginning-of-line # Home
#   # bindkey -M vicmd '^[[H' beginning-of-line
#   # bindkey -M viins '^[[F' end-of-line       # End
#   # bindkey -M vicmd '^[[F' end-of-line
#
#   bindkey '\e[H' beginning-of-line
#   bindkey '\e[F' end-of-line
#
#   # # History/Buffer Navigation
#   # bindkey -M viins '^[[5~' beginning-of-buffer-or-history # Page Up
#   # bindkey -M vicmd '^[[5~' beginning-of-buffer-or-history
#   # bindkey -M viins '^[[6~' end-of-buffer-or-history       # Page Down
#   # bindkey -M vicmd '^[[6~' end-of-buffer-or-history
#
#   # Yank/Paste/Undo
#   bindkey -M viins '^[[Z' undo # Shift+Tab
#   bindkey -M vicmd '^[[Z' undo
#   bindkey -M viins '^Y' yank
#   # I don't want my terminal to be nvim or vim I just want it to have some vim motions and
#   # some utility and that's it. everything else should be simple or use a dedicated program for it or smart tmux
#   # bindkey -M viins '\ey' yank-pop
#
#   # --- Special Bindings & Custom Widgets ---
#
#   # Insert a newline in the prompt
#   # NOTE: Not bound in vicmd mode, as 'j' is used for navigation.
#   bindkey -M viins '^J' self-insert
#   bindkey -M vicmd '^J' self-insert
#
#   # History expansion on space
#   # NOTE: Not bound in vicmd mode, as 'space' is used for navigation.
#   bindkey -M viins ' ' magic-space
#
#   # Toggle prompt style
#   bindkey -M viins '^P' toggle_oneline_prompt
#   bindkey -M vicmd '^P' toggle_oneline_prompt
#
#   # Edit command line in $EDITOR
#   bindkey -M viins '\ee' edit-command-line
#   bindkey -M vicmd '\ee' edit-command-line
#
#   # Clear the kill ring (paste history)
#   bindkey -M viins '\ek' clear-kill-ring
#   bindkey -M vicmd '\ek' clear-kill-ring
#
#   # Insert a newline in the prompt
#   # NOTE: Not bound in vicmd mode, as 'j' is used for navigation.
#   bindkey -M viins '^J' self-insert
#
#   # --- Special Bindings & Custom Widgets ---
#
#   # WIDGET: Bring the last background job to the foreground (fg)

# }



##-------- These are outside for a reason
# Explicitly for vi insert mode
# bindkey -M viins '\e[1~' beginning-of-line
# bindkey -M viins '\e[4~' end-of-line

# Explicitly for vi command mode (though 0 and $ are more common)
# bindkey -M vicmd '\e[1~' beginning-of-line
# bindkey -M vicmd '\e[4~' end-of-line

# Explicitly bind them to vi-insert mode, as this is the mode where you spend most time typing.
# This overrides any potential default ZVM behavior.
# bindkey -M viins '\e[H' beginning-of-line
# bindkey -M viins '\e[F' end-of-line

# Optional: Bind them to vi-command mode as well, although standard vim commands (0 and $) usually cover this.
# bindkey -M vicmd '\e[H' beginning-of-line
# bindkey -M vicmd '\e[F' end-of-line

# --- End: Home/End Key Fix ---






# # --------------------------------------------------------------------
# # ""goodbey zi-vi-mode""
# # ---END--------------------------------------------------------------
# 








 
  





# _)
# # W45 Wed, 05 at 14:35
# # ---START------------------------------------------------------------
# # ""ctrl+v to past from clipboard is meh I'll just use the defaults""
# # --------------------------------------------------------------------
#
# # [[]]
#
# # DESCRIPTION:
#
# # Why?:
#
# # Solution?:
#
# # --------------------------------------------------------------------





# _)
# W45 Wed, 05 at 14:35
# ---START------------------------------------------------------------
# ""ctrl+v to past from clipboard is meh I'll just use the defaults""
# --------------------------------------------------------------------

# [[]]

# DESCRIPTION:

# Why?:

# Solution?:

# --------------------------------------------------------------------



# --------------------------------------------------------------------
# ""ctrl+v to past from clipboard is meh I'll just use the defaults""
# ---END--------------------------------------------------------------


# Bind Ctrl+V to paste from clipboard in the default keymap (usually emacs)
# bindkey '^V' paste-from-clipboard







# # --------------------------------------------------------------------
# # ""ctrl+v to past from clipboard is meh I'll just use the defaults""
# # ---END--------------------------------------------------------------








# ==============================================================================
# 2. General Key Bindings (Default Keymap)

# Note on Keymaps:
# The commands below use 'bindkey' without -M. This usually binds them to
# the main/default keymap (typically 'emacs'). If you prefer to be explicit,
# you can use 'bindkey -M emacs ...'

# --- Basic Terminal Navigation (Arrow Keys) ---
# These are standard Zsh defaults, but included for completeness if they were broken.
bindkey '\e[A' up-line-or-history
bindkey '\e[B' down-line-or-history
bindkey '\e[C' forward-char
bindkey '\e[D' backward-char

# --- Application Launchers ---
# Binds Ctrl+Space to the original completion menu.
bindkey '^@' expand-or-complete
# A way to toggle zsh suggestions on and off.
bindkey '^G' autosuggest-toggle




# _)
# W45 Thu, 06 at 19:00
# ---START------------------------------------------------------------
# ""tmux-sessioniwer""
# --------------------------------------------------------------------

# [[]]

# DESCRIPTION:

# Why?:

# Solution?:

# --------------------------------------------------------------------




# Tmux sessionizers (uses -s for string execution)
bindkey -s '\et' "tmux-sessionizer\r"
# bindkey -s '\eh' "tmux-sessionizer -s 0\r"
# bindkey -s '\el' "tmux-sessionizer -s 1\r"
# bindkey -s '\en' "tmux-sessionizer -s 2\r"
# bindkey -s '\eb' "tmux-sessionizer -s 3\r"
# bindkey -s '\ey' "tmux-sessionizer -s 4\r"




# --------------------------------------------------------------------
# ""tmux-sessioniwer""
# ---END--------------------------------------------------------------





# Neovim file open
bindkey -s '\ev' "nvim \$(fzf)\r"

# --- General Editing & Navigation ---
# Line editing
bindkey '^U' backward-kill-line
bindkey '^K' kill-line
# You might want to remove the redundant Ctrl+K if you use the standard Emacs bindings.

# Word/Char editing
bindkey '^[[3;5~' kill-word      # Ctrl+Delete
bindkey '^[[3~'   delete-char    # Delete (standard, likely redundant)
bindkey '^[[1;5C' forward-word   # Ctrl+Right
bindkey '^[[1;5D' backward-word  # Ctrl+Left
bindkey '^H' backward-delete-char # Backspace/Ctrl+H

# Home/End keys
bindkey '\e[H' beginning-of-line  # Home
bindkey '\e[F' end-of-line        # End

# Yank/Paste/Undo
bindkey '^[[Z' undo # Shift+Tab
bindkey '^Y' yank
# Note: In standard Zsh (emacs mode), Ctrl+Y is yank (paste).

# --- Special Bindings & Custom Widgets ---

# Insert a newline in the prompt (Ctrl+J)
bindkey '^J' self-insert

# History expansion on space
bindkey ' ' magic-space

# Edit command line in $EDITOR
bindkey '\ee' edit-command-line


# WIDGET: Bring the last background job to the foreground (fg)
fg-widget() {
    BUFFER="fg"
    zle accept-line
}
zle -N fg-widget
# Use Alt+G for better compatibility (Go Foreground)
bindkey '^[z' fg-widget


# 2. Define the simple widget
# zi-widget() {
#     # Sets the buffer to "zi" (the zoxide interactive function)
#     BUFFER="zi"
#     # Executes the command
#     zle accept-line
# }
#
# # 3. Register and Bind Alt+X
# zle -N zi-widget
# bindkey '^[x' zi-widget

# ==============================================================================
# 3. External Dependencies (FZF)

# Load fzf keybindings and completions
# This was outside the zvm_after_init block but is critical for FZF keybinds.
[ -f ~/.fzf.zsh ] && source ~/.fzf.zsh



# --- Home/End Key Fix for xterm-style sequences (^[[1~ and ^[[4~) ---

# Global binding (main keymap)
bindkey '\e[1~' beginning-of-line
bindkey '\e[4~' end-of-line


# --- Start: Home/End Key Fix for Termux (Place near the end of ~/.zshrc) ---

# Global ZLE bindings (for environments where zsh-vi-mode doesn't handle them automatically)
bindkey '\e[H' beginning-of-line
bindkey '\e[F' end-of-line




# sets my keyboard typing speed
if [[ ! -v TERMUX_VERSION ]]; then
    # We use $DISPLAY check to ensure X server is running
    if command -v xset &> /dev/null && [ -n "$DISPLAY" ]; then
        xset r rate 180 68
    fi
fi


# disables terminal freezing
# stty -ixon

# enables terminal freezing

# disables terminal freezing
# stty -ixon

# enables terminal freezing
# stty ixon <-- DELETE/COMMENT THIS LINE



# _)
# W40 Tue, 30 at 15:01
# ---START------------------------------------------------------------
# ""freeing up ctrl+s and moving it to ctrl+o  for changing tmux prefix to ctrl+s""
# --------------------------------------------------------------------

# [[]]

# DESCRIPTION:

# Why?:

# Solution?:

# --------------------------------------------------------------------


stty ixon
# 2. Re-assign the terminal pause (stop) character to a new, available key.
#    Ctrl+T (^T) is a good choice for the new pause key.
stty stop ^O

# 3. Ensure the resume character is set to Ctrl+Q (^Q).
stty start ^Q 

# this dind't solve the problem of xterm not working with bind-key -n C-h in ~/.tmux.conf
# stty erase '^H'


# this dind't solve the problem of xterm not working with bind-key -n C-h in ~/.tmux.conf
# stty erase '^H'

# --------------------------------------------------------------------
# ""freeing up ctrl+s and moving it to ctrl+o  for changing tmux prefix to ctrl+s""
# ---END--------------------------------------------------------------





setopt autocd              # change directory just by typing its name
#setopt correct            # auto correct mistakes
setopt interactivecomments # allow comments in interactive mode



setopt magicequalsubst     # enable filename expansion for arguments of the form ‘anything=expression’
setopt nonomatch           # hide error message if there is no match for the pattern
setopt notify              # report the status of background jobs immediately
setopt numericglobsort     # sort filenames numerically when it makes sense
setopt promptsubst         # enable command substitution in prompt

WORDCHARS=${WORDCHARS//\/} # Don't consider certain characters part of the word

# hide EOL sign ('%')
PROMPT_EOL_MARK=""

# START--[]-- [ aliases ] START----
# # DESCRIPTION: 

##------------------- TIPS ---------------
## yeah yeah ofc I'll make them smart but whatever... that's for another day

# Command names (and aliases) cannot begin with a character that the shell uses for command separation or control flow, like ;, |, &, (, or ).
# Before you add alias myalias='...' to your .zshrc, run this command in your terminal: `type <proposed_alias_name>` so for example `type dd` (type it)
# in espanso use umm ;;<trigger>; and ,,<trigger>, and ..<trigger>. and ]]<trigger>] or and ]<trigger>]....(the ] is a special thing I rremember ahk with hhh.... for example ,,c, ..c. ;;c;. but for shell you always just do 
# in terminal you just do you now ,c<enter> or like `.<alias><enter>` or `]<alias><enter>` or `]]<alias><enter>` or `,,<alias><enter>` or `..<alias><enter<alias><enter>>`
##------------------- TIPS END---------------

# some more ls aliases
alias ll='ls -alhF' # Added -h for human-readable, -F for type indicators
alias la='ls -AlhF' # Added -h
alias l='ls -CF'

alias c.dp='~/Pictures/Screenshots'

# ---- Time  ----
alias ]timer='_my_timer_func'












alias P='ps aux | grep'
alias PK='pkill'
alias mpvg='mpv --player-operation-mode=pseudo-gui'
alias mpvyt='mpv --ytdl-format='
alias streamlink='streamlink --player mpv'
alias T='thunar .'
alias tt='thunar .'

# already used by oh.my.posh... tbh who cares I just alt+l gg
# alias gg='lazygit'
# alias gg='lazygit'
alias lgt='lazygit'

# alias rr='ffplay -fflags nobuffer -flags low_delay -framedrop -hwaccel vaapi -f x11grab -framerate 60 -noborder -video_size $(slop -f %wx%h) -i :0.0+$(slop -f %x,%y)'
alias vv='nvim $(fzf)'
alias ovv='ovim $(fzf)'
alias qq='exit'
alias Afeh='feh -R 5 -S mtime --reverse --geometry 3286x1080+0+0 --borderless .'
alias \00.='setxkbmap -layout us'
alias \01.='setxkbmap -layout fr'
alias \02.='setxkbmap -layout ara'
alias \04.='setxkbmap us_rpd'
alias yy='yazi'
alias ee='exit'
alias aa='nohup alacritty --working-directory . >/dev/null 2>&1 & disown ; exit'
alias Sshot='nohup ~/scripts/ddesk/nothing/autoshot.sh &'
alias Kshot='pkill autoshot.sh'

# alias ]timer='date "+%T %d-%m"; echo " " ;start=$(date +%s); while true; do current=$(date +%s); elapsed=$((current - start)); printf "\r%02d:%02d" $((elapsed/60)) $((elapsed%60)); sleep 1; done' # Use nano if you prefer: alias nanc='nano ~/.zshrc'

# ---- Time  END----

alias py='python' # The space at the end tells the shell to perfom alias expansion on the word following sudo
alias msgbox='zenity' # The space at the end tells the shell to perfom alias expansion on the word following sudo
alias sudo='sudo ' # The space at the end tells the shell to perfom alias expansion on the word following sudo


# [CHANGE] [W40 Mon, 29 at 07:51] I changed this with the bellow aliases
# alias ob='obsidian-cli' # https://github.com/Yakitrak/obsidian-cli make sure you have this. really useful
# alias oboo='ob o t -v' # https://github.com/Yakitrak/obsidian-cli make sure you have this. really useful
# alias obo='~/scripts/ddesk/obsidian/run-obsidian-script.sh' # https://github.com/Yakitrak/obsidian-cli make sure you have this. really useful
# alias obsearch='obsidian-cli search --vault' # https://github.com/Yakitrak/obsidian-cli make sure you have this. really useful
# alias obsh='obsidian-cli search --vault' # https://github.com/Yakitrak/obsidian-cli make sure you have this. really useful
# alias obshc='obsidian-cli search-content' # https://github.com/Yakitrak/obsidian-cli make sure you have this. really useful
# alias obsec='obsidian-cli search-content' # https://github.com/Yakitrak/obsidian-cli make sure you have this. really useful
# alias obc='obsidian-cli search-content' # https://github.com/Yakitrak/obsidian-cli make sure you have this. really useful
# alias obse='obsidian-cli search-content' # https://github.com/Yakitrak/obsidian-cli make sure you have this. really useful
# alias obsec='obsidian-cli search-content' # https://github.com/Yakitrak/obsidian-cli make sure you have this. really useful
# alias obsearchc='obsidian-cli search-content' # https://github.com/Yakitrak/obsidian-cli make sure you have this. really useful
# alias obset='obsidian-cli set-default' # https://github.com/Yakitrak/obsidian-cli make sure you have this. really useful
# alias obd='obsidian-cli set-default' # https://github.com/Yakitrak/obsidian-cli make sure you have this. really useful
# alias obsd='obsidian-cli set-default' # https://github.com/Yakitrak/obsidian-cli make sure you have this. really useful

# --- Obsidian CLI Aliases (Simplified) ---

# The main alias for the CLI tool itself.
alias ob='obsidian-cli'

# A quick alias for opening today's daily note. 'ob open today' is a common action.
alias obt='ob open today --vault "YourVaultName"' # IMPORTANT: Replace "YourVaultName"

# Optional: Keep your custom script alias if you still use it.
alias obo='~/scripts/ddesk/obsidian/run-obsidian-script.sh'



alias o='less' # https://github.com/Yakitrak/obsidian-cli make sure you have this. really useful
alias c='cd' # https://github.com/Yakitrak/obsidian-cli make sure you have this. really useful
alias cdfp='cd $(dirname "$(fp)")' # Use nano if you prefer: alias nanc='nano ~/.zshrc'
alias vim='nvim' # Use nano if you prefer: alias nanc='nano ~/.zshrc'
alias hx='helix'
alias ]exe='chmod +x'
alias ]cpuinfo='cpupower frequency-info'
alias ]cp=' col -b | xclip -selection clipboard'
alias xc=' col -b | xclip -selection clipboard'
alias -g xcc='| col -b | xclip -selection clipboard'
alias ls='ls --color=auto'
alias grep='grep --color=auto'
alias fgrep='fgrep --color=auto'
alias egrep='egrep --color=auto'
alias diff='diff --color=auto'
alias ip='ip --color=auto'
# ARCH LINUX: Changed ']]c' to 'cls' for clear, more common, and ']]r' to 'src', ']]ev' to 'virc'
alias ",c"='clear'
alias ",d"='cd ~/Desktop' # Keep if you use it, otherwise 'cd ~/Desktop' works fine
alias c.d='cd ~/Desktop' # Keep if you use it, otherwise 'cd ~/Desktop' works fine
alias c.dd='cd ~/Downloads' # Keep if you use it, otherwise 'cd ~/Desktop' works fine
# bro just type it man
# alias sc='scrcpy -b 20M -m 1920'
#!! but isn't src bad because I have sc you now scrcpy? 
# I like ]]r more than this 
# alias src='source ~/.zshrc'
alias ]]r='source ~/.zshrc ; source ~/.zshenv'
# tbh mkdir is better and should be typed than md but it's alright
alias md='mkdir -p' # Use nano if you prefer: alias nanc='nano ~/.zshrc'

# very useful to quickly open .zshrc
# ]e stands for edit
alias ]erc='nvim ~/.zshrc' # Use nano if you prefer: alias nanc='nano ~/.zshrc'
# I like typing nvnv and nvrc I make nv = ]e which is nv = edit too
alias nvrc='nvim ~/.zshrc' # Use nano if you prefer: alias nanc='nano ~/.zshrc'
alias ]evim='nvim ~/.config/nvim/'
alias nvnv='cd ~/.config/nvim/ ; nvim .'
alias ]xset='xset r rate 194 68;xset q | grep delay'
alias ]xset?='xset q | grep delay'

alias ]pqo='pacman -Qo'
# because I have o = you know trying to make variants of o
alias ]o='pacman -Qo'
# this is stupd hhh but could be useful you now it's anonying to keep
# typing the freaking ip address each single time creating aliases is 
# interesting if you are you know hopping a lot 
# alias kdex='dex@192.168.11.119'
# alias ]st='systemctl status'
# alias ]ss='systemctl start'
# alias ]sp='systemctl stop'
# alias ]se='systemctl enable'
alias ]psi='pacman -Si'
alias ]pqi='pacman -Qi'




# force zsh to show the complete history
alias history="history 0"

# END--[]-- [ aliases ] END----

# --[VI]-- [ VI keybinds for zsh ] --W32 Tue, 12 at 15:48--

# NOT_NEEDED this is not needed because we are trying to set up the
# zsh-vi-mode plugin W32 Tue, 12 at 15:47
#2 ---- [viins-insert keybinds] ----

# bindkey -M viins '^?' backward-delete-char
# bindkey -M viins '^W' backward-kill-word

#2 END---- [viins-insert keybinds] ----

# # -------------------------------------------------------------------
# # ZSH VI-MODE: The Final and Correct Architecture
# # -------------------------------------------------------------------
#
# # We must explicitly load the hook function system first.
# autoload -U add-zsh-hook
#
# # --- PART 1: The Foundation (Handles I/N modes) ---
# _update_prompt_and_cursor_interactively() {
#     case $KEYMAP in
#       vicmd)
#         if (( REGION_ACTIVE )); then
#           PROMPT_INDICATOR="%F{magenta}[V] "
#         else
#           PROMPT_INDICATOR="%F{yellow}[N] "
#         fi
#         echo -ne '\e[2 q'
#         ;;
#       viins|main)
#         PROMPT_INDICATOR="%F{cyan}[I] "
#         echo -ne '\e[6 q'
#         ;;
#     esac
#     zle .reset-prompt
# }
# zle -N zle-keymap-select _update_prompt_and_cursor_interactively
#
# # --- PART 2: The "New Line" Logic ---
# _set_prompt_for_new_line() {
#     PROMPT_INDICATOR="%F{cyan}[I] "
#     echo -ne '\e[6 q'
# }
# zle -N zle-line-init _set_prompt_for_new_line
# add-zsh-hook precmd _set_prompt_for_new_line
#
# # --- PART 3: Targeted "Scalpel" Widgets and Bindings ---
#
# # WIDGET 1: Hijacks 'v' in Normal mode for instant [V] indicator.
# _enter_visual_mode_and_update_prompt() {
#   zle .visual-mode
#   _update_prompt_and_cursor_interactively
# }
# zle -N _enter_visual_mode_and_update_prompt
# bindkey -M vicmd 'v' _enter_visual_mode_and_update_prompt
#
#
# _enter_visual_line_mode_and_update_prompt() {
#   zle .visual-line-mode
#   _update_prompt_and_cursor_interactively
# }
# zle -N _enter_visual_line_mode_and_update_prompt 
# bindkey -M vicmd 'V' _enter_visual_line_mode_and_update_prompt 
#
#
# # WIDGET 2 (NEW): Hijacks 'Esc' in Visual mode to exit and update.
# _exit_visual_mode_and_update_prompt() {
#   zle .deactivate-region
#   _update_prompt_and_cursor_interactively
# }
# zle -N _exit_visual_mode_and_update_prompt
# # Note: '^[' is the correct representation for the Escape key.
# bindkey -M visual '^[' _exit_visual_mode_and_update_prompt
#
# # WIDGET 3 (NEW): Hijacks 'y' in Visual mode to yank, exit, and update.
# _yank_and_exit_visual_mode() {
#   zle .vi-yank
#   echo -n "$CUTBUFFER" | xclip -i -selection clipboard
#   _update_prompt_and_cursor_interactively
# }
# zle -N _yank_and_exit_visual_mode
# bindkey -M visual 'y' _yank_and_exit_visual_mode
#
# # WIDGET 4 (NEW): Hijacks 'd' in Visual mode to delete, exit, and update.
# _delete_and_exit_visual_mode() {
#   zle .kill-region
#   _update_prompt_and_cursor_interactively
# }
# zle -N _delete_and_exit_visual_mode
# bindkey -M visual 'd' _delete_and_exit_visual_mode
#
#
# _paste_and_exit_visual_mode() {
#   zle .put-replace-selection # The perfect widget from your test
#   _update_prompt_and_cursor_interactively
# }
# zle -N _paste_and_exit_visual_mode
# bindkey -M visual 'p' _paste_and_exit_visual_mode
#
# # Your original keybinding for 'jjk' escape.
# _vim_jjk_escape() {
#   if [[ ${LBUFFER[-2,-1]} == 'jj' ]]; then
#     LBUFFER=${LBUFFER%jj}
#     zle vi-cmd-mode
#   else
#     zle self-insert
#   fi
# }
# zle -N _vim_jjk_escape
# bindkey -M viins 'k' _vim_jjk_escape
#
# END--[VI]-- [ VI keybinds for zsh ] END----

# # enable completion features
# autoload -Uz compinit
# Smarter compinit - only runs if necessary

# _)
# W40 Tue, 30 at 14:51
# ---START------------------------------------------------------------
# ""Enabling editing in nvim with alt+e""
# --------------------------------------------------------------------

# [[]]

# DESCRIPTION:

# Why?:

# Solution?:

# --------------------------------------------------------------------


# Explicitly autoload the Zsh function
autoload edit-command-line

# Register the Zsh function as a ZLE widget
zle -N edit-command-line

# --------------------------------------------------------------------
# ""Enabling editing in nvim with alt+e""
# ---END--------------------------------------------------------------



# [Removed] this please [Run] [Manual] at the first header of the zshrc config
# [Optimization] This is slow and gives me a lot of performance loss
# if command -v keychain > /dev/null; then
    # eval $(keychain --eval --quiet id_ed25519)
    # eval $(keychain --eval --quiet ssh)
# fi

    
# --- Optimized Keychain SSH Agent Initialization ---

# [Removed] please run [Manual]
# 1. Check if the shell is interactive AND keychain is installed
# if [[ -o interactive ]] && command -v keychain &> /dev/null; then
    
    # 2. Check if the SSH Agent socket is defined and still active.
    #    If the socket exists, skip running keychain entirely.
    # if [ -z "$SSH_AUTH_SOCK" ] || ! ssh-add -l &> /dev/null; then
        
        # Run keychain once. We only need to specify the keys here.
        # Use --agents ssh for maximum compatibility.
        # eval $(keychain --eval --agents ssh id_ed25519)
        
    # fi
    
# fi
# --- End Keychain Block ---

  


# enable color support of ls, less and man, and also add handy aliases
if [ -x /usr/bin/dircolors ]; then
    test -r ~/.dircolors && eval "$(dircolors -b ~/.dircolors)" || eval "$(dircolors -b)"
    #alias dir='dir --color=auto' # Usually covered by ls
    #alias vdir='vdir --color=auto' # Usually covered by ls -l
    export LESS_TERMCAP_mb=$'\E[1;31m'     # begin blink
    export LESS_TERMCAP_md=$'\E[1;36m'     # begin bold
    export LESS_TERMCAP_me=$'\E[0m'        # reset bold/blink
    export LESS_TERMCAP_so=$'\E[01;33m'    # begin reverse video
    export LESS_TERMCAP_se=$'\E[0m'        # reset reverse video
    export LESS_TERMCAP_us=$'\E[1;32m'     # begin underline
    export LESS_TERMCAP_ue=$'\E[0m'        # reset underline

    # Take advantage of $LS_COLORS for completion as well
    zstyle ':completion:*' list-colors "${(s.:.)LS_COLORS}"
    zstyle ':completion:*:*:kill:*:processes' list-colors '=(#b) #([0-9]#)*=0=01;31'
fi

# enable auto-suggestions based on the history
# ARCH LINUX: Path for zsh-autosuggestions is typically different.
# Ensure you installed it via: sudo pacman -S zsh-autosuggestions
ZSH_AUTOSUGGESTIONS_DIR="/usr/share/zsh/plugins/zsh-autosuggestions" # Common Arch path
if [ -f "$ZSH_AUTOSUGGESTIONS_DIR/zsh-autosuggestions.zsh" ]; then
    . "$ZSH_AUTOSUGGESTIONS_DIR/zsh-autosuggestions.zsh"
    # change suggestion color
    ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=#999' # This is good, visible but not intrusive
else
    # Fallback or warning if not found
    # echo "Zsh Autosuggestions not found at $ZSH_AUTOSUGGESTIONS_DIR" >&2
    # You might also check /usr/share/zsh-autosuggestions/ if the above path doesn't work
    if [ -f /usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh ]; then
        . /usr/share/zsh-autosuggestions/zsh-autosuggestions.zsh
        ZSH_AUTOSUGGEST_HIGHLIGHT_STYLE='fg=#999'
    fi
fi

# enable command-not-found if installed
# ARCH LINUX: Use pkgfile's command-not-found handler
# Ensure you installed it via: sudo pacman -S pkgfile AND ran sudo pkgfile --update
if [ -f /usr/share/doc/pkgfile/command-not-found.zsh ]; then
    source /usr/share/doc/pkgfile/command-not-found.zsh
elif [ -f /usr/share/pkgfile/command-not-found.zsh ]; then # Alternative path for pkgfile hook
    source /usr/share/pkgfile/command-not-found.zsh
fi



# Style for ZLE states like visual mode, search, etc.
# This is the modern and correct way to style selections.
# .zshrc
# zstyle ':zle:*' region_highlight 'bg=#FFCB6B'
# Style for ZLE states like visual mode, search, etc.
# This is the modern and correct way to style selections.
# --- ZLE HIGHLIGHT LABORATORY ---
# Use this block to experiment with styles.

## THE GOOD ONE
# zle_highlight=(
#   'default:none'
#   # 'visual:bg=#44475a'
#   'region:bg=#44475a,underline'
#   # 'isearch:bg=cyan,fg=black,bold'
#   # 'special:bg=red,fg=white'
#   # 'special:standout'
# )

# zle_highlight=(
#     'default:none'
#   'visual:bg=white,fg=black'
#   # 'region:bg=#44475a'
#   # 'region:bg=#44475a,fg=#f8f8f2'
#   # 'region:bg=#44475a,underline'
#   'region:bold,underline'
#   # 'region:bold'
#   'special:bg=red,fg=white'
#   'isearch:bg=green,fg=black,bold'
# )

# --- Test Theme 1: "High Contrast Inverted" ---
# zle_highlight=(
#   'default:none'
  # 'visual:bg=white,fg=black'
#   'region:bg=white,fg=black'
#   'isearch:bg=green,fg=black,bold'
#   'special:bg=red,fg=white'
# )

# --- Test Theme 2: "Cyberpunk Neon" ---
# zle_highlight=(
#   'default:none'
#   'visual:bg=#282a36,fg=magenta,bold'
#   'region:bg=#282a36,fg=magenta,bold'
#   'isearch:bg=cyan,fg=black'
#   'special:bg=red,fg=white,underline'
# )

# --- Test Theme 3: "Subtle & Modern" ---
# zle_highlight=(
#   'default:none'
#   'visual:bg=#44475a'
#   'region:bg=#44475a,underline'
#   'isearch:bg=yellow,fg=black'
#   'special:standout'
# )
# --- Test Theme 4: "Terminal Green" ---
# zle_highlight=(
#   'default:none'
#   'visual:bg=green,fg=black'
#   'region:bg=green,fg=black'
#   'isearch:bg=white,fg=green,bold'
#   'special:bg=red,fg=white'
# )
# --- Test Theme 5: "Just Underline" ---
# zle_highlight=(
#   # 'default:none'
#   # 'visual:bold,underline'
#   'region:bold,underline'
#   # 'isearch:standout'
#   # 'special:bg=red,fg=white'
# )
# --- Theme: "Dracula Selection" ---
# This matches the effect in your new screenshot by setting a specific
# background color for the selection.





# _)
# W40 Mon, 29 at 06:23
# ---START------------------------------------------------------------
# ""fzf-tab common configuration""

# [[]]

# DESCRIPTION:

# Why?:

# --------------------------------------------------------------------


# disable sort when completing `git checkout`
zstyle ':completion:*:git-checkout:*' sort false

# set descriptions format to enable group support
# NOTE: don't use escape sequences (like '%F{red}%d%f') here, fzf-tab will ignore them
zstyle ':completion:*:descriptions' format '[%d]'

# set list-colors to enable filename colorizing
zstyle ':completion:*' list-colors ${(s.:.)LS_COLORS}

# force zsh not to show completion menu, which allows fzf-tab to capture the unambiguous prefix
zstyle ':completion:*' menu no

# preview directory's content with eza when completing cd
zstyle ':fzf-tab:complete:cd:*' fzf-preview 'eza -1 --color=always $realpath'

#===== custom fzf flags

# NOTE: fzf-tab does not follow FZF_DEFAULT_OPTS by default
zstyle ':fzf-tab:*' fzf-flags --color=fg:1,fg+:2 --bind=tab:accept

# To make fzf-tab follow FZF_DEFAULT_OPTS.
# # NOTE: This may lead to unexpected behavior since some flags break this plugin. See Aloxaf/fzf-tab#455.
# zstyle ':fzf-tab:*' use-fzf-default-opts yes

# switch group using `<` and `>`
zstyle ':fzf-tab:*' switch-group '<' '>'

# fzf-tab in tmux
# In ~/.zshrc, with your other fzf-tab zstyle lines...
# Use the tmux popup feature for a cleaner interface
# This sucks it's so tiny and small
# zstyle ':fzf-tab:*' fzf-command ftb-tmux-popup

# --------------------------------------------------------------------
# ""fzf-tab common configuration""
# ---END--------------------------------------------------------------









zstyle ':completion:*:*:*:*:*' menu select
zstyle ':completion:*' auto-description 'specify: %d'
# zstyle ':completion:*' completer _expand _complete
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





# History configurations
HISTFILE=~/.zsh_history
HISTSIZE=10000 # Increased HISTSIZE
SAVEHIST=10000 # Increased SAVEHIST to match HISTSIZE for better retention
setopt hist_expire_dups_first # delete duplicates first when HISTFILE size exceeds HISTSIZE
setopt hist_ignore_dups       # ignore duplicated commands history list
setopt hist_ignore_space      # ignore commands that start with space
setopt hist_verify            # show command with history expansion to user before running it
#setopt share_history         # share command history data - uncomment if you use multiple zsh sessions simultaneously and want shared history immediately

# configure `time` format
TIMEFMT=$'\nreal\t%E\nuser\t%U\nsys\t%S\ncpu\t%P'

# make less more friendly for non-text input files, see lesspipe(1)
# Ensure you have 'lesspipe' installed on Arch: sudo pacman -S lesspipe
[ -x /usr/bin/lesspipe ] && eval "$(SHELL=/bin/sh lesspipe)"

# set variable identifying the chroot you work in (used in the prompt below)
# This is Debian-specific, can be commented out or removed on Arch if not needed.
# if [ -z "${debian_chroot:-}" ] && [ -r /etc/debian_chroot ]; then
#     debian_chroot=$(cat /etc/debian_chroot)
# fi

# ===================================================================
# ============= NEW DUAL-STYLE PROMPT CONFIGURATION =============
# ===================================================================

# Load the version control information module
autoload -Uz vcs_info

# --- Configure vcs_info for Git ---
# Set the format for the Git prompt string. e.g., " git:(master)"
zstyle ':vcs_info:git:*' formats ' %F{yellow}git:(%b)%f'
zstyle ':vcs_info:git:*' actionformats ' %F{yellow}git:(%b|%a)%f'

# This adds vcs_info to the functions that run before showing a prompt
add-zsh-hook precmd vcs_info


# --- Main Prompt Configuration Function ---
configure_prompt() {
    # This variable will hold the git info, like " git:(master)"
    local git_info='${vcs_info_msg_0_}'

    case "$PROMPT_ALTERNATIVE" in
	twoline)
	    # THE ORIGINAL KALI PROMPT + GIT INFO
        # This is your full-path, two-line prompt, with Git info added to the end of the first line.
	    PROMPT=$'%F{%(#.blue.green)}┌──${debian_chroot:+($debian_chroot)─}${VIRTUAL_ENV:+($(basename $VIRTUAL_ENV))─}(%B%F{%(#.red.blue)}%n'$'%b%F{%(#.blue.green)})-[%B%F{reset}%(6~.%-1~/…/%4~.%5~)%b%F{%(#.blue.green)}]'
        PROMPT+="$git_info" # Add git info here
        PROMPT+=$'\n└─%B${PROMPT_INDICATOR}%(#.%F{red}#.%F{blue}$)%b%F{reset} '
	    ;;
	oneline)
	    # THE PRIMEAGEN-STYLE PROMPT + GIT INFO
        # This is the short-path, one-line prompt. (%1. = current directory only)
	    PROMPT=$'%F{green}→%f %F{cyan}%1.%f'
        PROMPT+="$git_info" # Add git info here
        PROMPT+=' %F{white}×%f '
	    ;;
    esac
}












# ======================== END NEW PROMPT CONFIG =======================

# ----- trying to remove capslock stupid letters ---- 

# caps_lock_noop(){
#
# }
#
# zle -N caps_lock_noop
#
# bindkey "^[[57387u" caps_lock_noop
# bindkey "^[[57387;2u" caps_lock_noop
# ----- trying to remove capslock stupid letters END ---- 

# bindkey "\e[387u" caps_lock_noop
# bindkey "387u" caps_lock_noop
# bindkey "\e^[[57387u" caps_lock_noop
# The following block is surrounded by two delimiters.
# These delimiters must not be modified. Thanks.
# START KALI CONFIG VARIABLES

PROMPT_ALTERNATIVE=twoline
NEWLINE_BEFORE_PROMPT=yes
# STOP KALI CONFIG VARIABLES

# ===================================================================
# ============= ZSH SYNTAX HIGHLIGHTING (CORRECT SETUP) =============
# ===================================================================

# Define the path to the plugin provided by the official Arch Linux package
ZSH_SYNTAX_HIGHLIGHTING_FILE="/usr/share/zsh/plugins/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh"

# Check if the plugin file actually exists before trying to load it
if [ -f "$ZSH_SYNTAX_HIGHLIGHTING_FILE" ]; then

    # STEP 1: SOURCE THE PLUGIN. This must happen first.
    source "$ZSH_SYNTAX_HIGHLIGHTING_FILE"

    # STEP 2: NOW, CONFIGURE THE STYLES.
    # These settings will apply to the plugin we just loaded above.

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

    # --- THIS IS THE FIX FOR YOUR COMMENT COLOR ---
    ZSH_HIGHLIGHT_STYLES[comment]=fg=#FFFFFF,bold

fi

# --- END OF ZSH SYNTAX HIGHLIGHTING SETUP ---


# if [ "$color_prompt" = yes ]; then
#     # override default virtualenv indicator in prompt
#     VIRTUAL_ENV_DISABLE_PROMPT=1
#
#     configure_prompt
#
#     # enable syntax-highlighting
#     # ARCH LINUX: Path for zsh-syntax-highlighting is typically different.
#     # Ensure you installed it via: sudo pacman -S zsh-syntax-highlighting
#     ZSH_SYNTAX_HIGHLIGHTING_DIR="/usr/share/zsh/plugins/zsh-syntax-highlighting" # Common Arch path
#     if [ -f "$ZSH_SYNTAX_HIGHLIGHTING_DIR/zsh-syntax-highlighting.zsh" ]; then
#         . "$ZSH_SYNTAX_HIGHLIGHTING_DIR/zsh-syntax-highlighting.zsh"
#         ZSH_HIGHLIGHT_HIGHLIGHTERS=(main brackets pattern)
#         ZSH_HIGHLIGHT_STYLES[default]=none
#         ZSH_HIGHLIGHT_STYLES[unknown-token]=underline
#         ZSH_HIGHLIGHT_STYLES[reserved-word]=fg=cyan,bold
#         ZSH_HIGHLIGHT_STYLES[suffix-alias]=fg=green,underline
#         ZSH_HIGHLIGHT_STYLES[global-alias]=fg=green,bold
#         ZSH_HIGHLIGHT_STYLES[precommand]=fg=green,underline
#         ZSH_HIGHLIGHT_STYLES[commandseparator]=fg=blue,bold
#         ZSH_HIGHLIGHT_STYLES[autodirectory]=fg=green,underline
#         ZSH_HIGHLIGHT_STYLES[path]=bold
#         ZSH_HIGHLIGHT_STYLES[path_pathseparator]=
#         ZSH_HIGHLIGHT_STYLES[path_prefix_pathseparator]=
#         ZSH_HIGHLIGHT_STYLES[globbing]=fg=blue,bold
#         ZSH_HIGHLIGHT_STYLES[history-expansion]=fg=blue,bold
#         ZSH_HIGHLIGHT_STYLES[command-substitution]=none
#         ZSH_HIGHLIGHT_STYLES[command-substitution-delimiter]=fg=magenta,bold
#         ZSH_HIGHLIGHT_STYLES[process-substitution]=none
#         ZSH_HIGHLIGHT_STYLES[process-substitution-delimiter]=fg=magenta,bold
#         ZSH_HIGHLIGHT_STYLES[single-hyphen-option]=fg=green
#         ZSH_HIGHLIGHT_STYLES[double-hyphen-option]=fg=green
#         ZSH_HIGHLIGHT_STYLES[back-quoted-argument]=none
#         ZSH_HIGHLIGHT_STYLES[back-quoted-argument-delimiter]=fg=blue,bold
#         ZSH_HIGHLIGHT_STYLES[single-quoted-argument]=fg=yellow
#         ZSH_HIGHLIGHT_STYLES[double-quoted-argument]=fg=yellow
#         ZSH_HIGHLIGHT_STYLES[dollar-quoted-argument]=fg=yellow
#         ZSH_HIGHLIGHT_STYLES[rc-quote]=fg=magenta
#         ZSH_HIGHLIGHT_STYLES[dollar-double-quoted-argument]=fg=magenta,bold
#         ZSH_HIGHLIGHT_STYLES[back-double-quoted-argument]=fg=magenta,bold
#         ZSH_HIGHLIGHT_STYLES[back-dollar-quoted-argument]=fg=magenta,bold
#         ZSH_HIGHLIGHT_STYLES[assign]=none
#         ZSH_HIGHLIGHT_STYLES[redirection]=fg=blue,bold
#         ZSH_HIGHLIGHT_STYLES[comment]=fg=#FFFFFF,bold
#         ZSH_HIGHLIGHT_STYLES[named-fd]=none
#         ZSH_HIGHLIGHT_STYLES[numeric-fd]=none
#         ZSH_HIGHLIGHT_STYLES[arg0]=fg=cyan
#         ZSH_HIGHLIGHT_STYLES[bracket-error]=fg=red,bold
#         ZSH_HIGHLIGHT_STYLES[bracket-level-1]=fg=blue,bold
#         ZSH_HIGHLIGHT_STYLES[bracket-level-2]=fg=green,bold
#         ZSH_HIGHLIGHT_STYLES[bracket-level-3]=fg=magenta,bold
#         ZSH_HIGHLIGHT_STYLES[bracket-level-4]=fg=yellow,bold
#         ZSH_HIGHLIGHT_STYLES[bracket-level-5]=fg=cyan,bold
#         ZSH_HIGHLIGHT_STYLES[cursor-matchingbracket]=standout
#     else
#         # Fallback or warning if not found
#         # echo "Zsh Syntax Highlighting not found at $ZSH_SYNTAX_HIGHLIGHTING_DIR" >&2
#         # You might also check /usr/share/zsh-syntax-highlighting/ if the above path doesn't work
#         if [ -f /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh ]; then
#              . /usr/share/zsh-syntax-highlighting/zsh-syntax-highlighting.zsh
#              # Apply styles here too if using this fallback
#         fi
#     fi
# else
#     PROMPT='${debian_chroot:+($debian_chroot)}%n@%m:%~%(#.#.$) ' # This prompt is used if no color. debian_chroot can be removed.
# fi
unset color_prompt force_color_prompt

toggle_oneline_prompt(){
    if [ "$PROMPT_ALTERNATIVE" = oneline ]; then
        PROMPT_ALTERNATIVE=twoline
    else
        PROMPT_ALTERNATIVE=oneline
    fi
    configure_prompt
    zle reset-prompt
}
zle -N toggle_oneline_prompt
bindkey ^P toggle_oneline_prompt # Ctrl+P to toggle prompt style

# If this is an xterm set the title to user@host:dir
case "$TERM" in
xterm*|rxvt*|Eterm|aterm|kterm|gnome*|alacritty|kitty) # Added kitty
    TERM_TITLE=$'\e]0;${debian_chroot:+($debian_chroot)}${VIRTUAL_ENV:+($(basename $VIRTUAL_ENV))}%n@%m: %~\a'
    ;;
*)
    ;;
esac

# precmd() {
#     # Print the previously configured title
#     print -Pnr -- "$TERM_TITLE"
#
#     # Print a new line before the prompt, but only if it is not the first line
#     if [ "$NEWLINE_BEFORE_PROMPT" = yes ]; then
#         if [ -z "$_NEW_LINE_BEFORE_PROMPT" ]; then
#             _NEW_LINE_BEFORE_PROMPT=1
#         else
#             print ""
#         fi
#     fi
# }

_zsh_precmd_actions() {
    # Print the previously configured title
    print -Pnr -- "$TERM_TITLE"

    # Print a new line before the prompt, but only if it is not the first line
    if [ "$NEWLINE_BEFORE_PROMPT" = yes ]; then
        if [ -z "$_NEW_LINE_BEFORE_PROMPT" ]; then
            _NEW_LINE_BEFORE_PROMPT=1
        else
            print ""
        fi
    fi
}
add-zsh-hook precmd _zsh_precmd_actions


# You can add any of your personal aliases or functions below this line

# 1. Free up Ctrl+R completely by unbinding it from both modes.
bindkey -r -M viins '^R' # Unbind from INSERT mode
bindkey -r -M vicmd '^R' # Unbind from NORMAL mode (This was the missing piece!)

# 2. Bind Alt+R to the FZF history widget in BOTH modes.
bindkey -M viins '\er' fzf-history-widget # Bind for INSERT mode
bindkey -M vicmd '\er' fzf-history-widget # Bind for NORMAL mode



# 3. Bind Ctrl+R to the native `redo` command, but ONLY in normal mode.
bindkey -M vicmd '^R' redo
# ---- functions i made with ai asstantce ---- 

#------------------------------------------------------------------
#  SMART "FZF OPEN" AND "FZF PREVIEW" FUNCTIONS
#------------------------------------------------------------------

# "Clipboard Pastebin Tools:"
# "Cbin - curl clipboard URL to terminal"
# "Obin - curl to pager (less)"
# "Vbin - open in vim"
# "Gbin - grep with prompt"
# "Pbin - upload clipboard to pastebin"
# "Rbin - upload with -r flag"
# "Hbin - Brings Help"
source $HOME/.config/zsh/functions/wgetpaste

# _cat:
#
# Kcat --- uses _get_clip and displays content of current clipboard on temrinal
source $HOME/.config/zsh/functions/_cat


# _cat:
#
# Gclip --- Grep 
#
# Vclip
#
source $HOME/.config/zsh/functions/_clip

# fo
# look for file and open it 
source $HOME/.config/zsh/functions/fo

# pw
# some old sushi preview thing on the file, meh still useful
source $HOME/.config/zsh/functions/pw

# ---[FUNCTIONS]-- [ myfuncs ] [ my functions] ---------

# fp.scuffed.video.preview.zsh
# some unfinished fzf file preview for vids
source $HOME/.config/zsh/functions/fp.scuffed.video.preview

# fp
# fzf file preview
source $HOME/.config/zsh/functions/fp

#fp
#fzf file preview
source $HOME/.config/zsh/functions/fpp

## Clipboard functions that help me do copy things to clipboard in smart ways. read the source for more info
source $HOME/.config/zsh/functions/cp-alphabit
## Quick Guide to use:
# Intuitive clipboard functions: cp<Letter> <file>
# cpA -> Absolute Path
# cpR -> Relative Path
# cpH -> Home-relative Path
# cpF -> Filename
# cpB -> Bare/Basename (no extension)
# cpE -> Extension
# cpC -> Content
# cpQ --> copyq <number>, Copies the Nth item from CopyQ (using 1-based counting). Usage: cpc 2  (to copy the 2nd item)


# --------------------------------------------------------------------
#  Alacritty Dynamic Window Title
#  This code tells Zsh to update the terminal title automatically.
# --------------------------------------------------------------------

# This function runs just BEFORE a command is executed.
# It sets the title to the command being run.
alacritty_preexec() {
  # \e]0; is the "start setting title" command.
  # $1 is the first argument, which is the command itself.
  # \a is the "finish setting title" command.
  print -Pn "\e]0;$1\a"
}

# This function runs just BEFORE the prompt is displayed (i.e., after a command finishes).
# It resets the title to the current directory.
alacritty_precmd() {
  # %~ is Zsh's special character for the current path (e.g., ~/Code/project).
  print -Pn "\e]0;%~\a"
}

# Add our functions to Zsh's hook arrays.
# This tells Zsh to actually run them at the right times.
if [[ "$TERM" == "alacritty" ]]; then
  add-zsh-hook preexec alacritty_preexec
  add-zsh-hook precmd alacritty_precmd
fi

# 1. Define the readable function with a safe, valid name.
#    The leading underscore is a common convention for "helper" functions.
_my_timer_func() {
  # Print the start time and date
  date "+%T %a, %d-%m"
  echo "" # Add a newline

  # Get the starting time in seconds since 1970-01-01
  local start=$(date +%s)
  local last_mins=-1 # Initialize with a value that won't match the first minute

  # Loop forever until you press Ctrl+C
  while true; do
    # Get the current time and calculate total elapsed seconds
    local current=$(date +%s)
    local elapsed=$((current - start))

    # Calculate hours and minutes from total elapsed seconds
    local hours=$((elapsed / 3600))
    local mins=$(((elapsed / 60) % 60))

    # Check if the minute has changed since the last time it was printed
    if [ "$mins" -ne "$last_mins" ]; then
      # Print the formatted time, using \r to return to the start of the line
      printf "\r%02d:%02d" $hours $mins
      # Update the last printed minute
      last_mins=$mins
    fi

    # Wait for one second
    sleep 1
  done
}
# Function to get detailed info for a specific IP address
# Usage: ipinfo 8.8.8.8
ipinfo() {
    # Check if an IP address was provided as an argument
    if [ -z "$1" ]; then
        # If no IP is given, show info for our own IP
        curl ipinfo.io
    else
        # If an IP is given, look it up
        curl ipinfo.io/"$1"
    fi
}





# --- Custom Widget to Clear the Kill Ring ---

# 1. Define a function that will be run by the line editor.
#    This function runs in the correct scope to modify the real killring.
# _clear_kill_ring() {
  # This is the core logic that empties the actual killring array.
  # killring=()

  # This provides visual feedback so you know it worked.
  # zle -M "Kill ring cleared."
# }

# 2. Register the shell function as a ZLE widget.
#    This makes the function available to `bindkey`.
# zle -N clear-kill-ring _clear_kill_ring

# 3. Bind the new widget to a key.
#    Alt+K is a good choice (mnemonic for "Kill the Kill-ring").
#    We bind it for both Insert and Normal mode for convenience.
# bindkey '\ek' clear-kill-ring      # For Vi INSERT mode

# xdotool mousemove --window $(xdotool getactivewindow) --polar 0 0


# Lazy-load zoxide for faster startup
if command -v zoxide > /dev/null; then
# --- Zoxide: Advanced Dynamic Functions (Final Version) ---


# 1. Initialize Zoxide. This MUST come first.
eval "$(zoxide init zsh)"

# 2. Define our custom 'zi' function.
#    - Default 'zi' has NO preview.
#    - 'zi -l' or 'zi -la' adds a preview.
zi() {
  local fzf_opts=""

  # Check the first argument to see if we need to add a preview
  case "$1" in
    -l)
      fzf_opts="--preview 'ls -l --color=auto {2..}' --bind 'alt-j:preview-down,alt-k:preview-up'"
      shift # Consume the '-l' argument
      ;;
    -la | -al)
      fzf_opts="--preview 'ls -la --color=auto {2..}' --bind 'alt-j:preview-down,alt-k:preview-up'"
      shift # Consume the '-la' or '-al' argument
      ;;
    -a)
      fzf_opts="--preview 'ls -a --color=auto {2..}' --bind 'alt-j:preview-down,alt-k:preview-up'"
      shift # Consume the '-la' or '-al' argument
      ;;
  esac

  # If we generated options, run with them. Otherwise, run the default command.
  if [ -n "$fzf_opts" ]; then
    _ZO_FZF_OPTS="$fzf_opts" __zoxide_zi "$@"
  else
    # This is the default case: no flags, no custom options, pure fzf.
    __zoxide_zi "$@"
  fi
}

# 3. Define our custom 'zii' function for the eza tree view.
#    - Default 'zii' HAS the tree preview.
#    - 'zii -l' or 'zii -la' changes the preview to a list.
zii() {
  local fzf_opts

  # Check the first argument to determine the preview style
  case "$1" in
    -l)
      fzf_opts="--preview 'eza --long --color=always {2..}' --bind 'alt-j:preview-down,alt-k:preview-up'"
      shift # Consume the '-l' argument
      ;;
    -la | -al)
      fzf_opts="--preview 'eza --long --all --color=always {2..}' --bind 'alt-j:preview-down,alt-k:preview-up'"
      shift # Consume the '-la' or '-al' argument
      ;;
    -lag | -alg)
      fzf_opts="--preview 'eza -g --long --all --color=always {2..}' --bind 'alt-j:preview-down,alt-k:preview-up'"
      shift # Consume the '-la' or '-al' argument
      ;;
    -g)
      fzf_opts="--preview 'eza -g --color=always {2..}' --bind 'alt-j:preview-down,alt-k:preview-up'"
      shift # Consume the '-la' or '-al' argument
      ;;
    -ga | -ag)
      fzf_opts="--preview 'eza -g --all --color=always {2..}' --bind 'alt-j:preview-down,alt-k:preview-up'"
      shift # Consume the '-la' or '-al' argument
      ;;
    -lg | -gl)
      fzf_opts="--preview 'eza -g --long --color=always {2..}' --bind 'alt-j:preview-down,alt-k:preview-up'"
      shift # Consume the '-la' or '-al' argument
      ;;
    -a)
      fzf_opts="--preview 'eza --all --color=always {2..}' --bind 'alt-j:preview-down,alt-k:preview-up'"
      shift # Consume the '-la' or '-al' argument
      ;;
    *)
      # Default view for zii IS the tree view
      fzf_opts="--preview 'eza --tree --level=1 --color=always {2..}' --bind 'alt-j:preview-down,alt-k:preview-up'"
      ;;
  esac

  # Since 'zii' always has a preview, we always run it with the options.
  _ZO_FZF_OPTS="$fzf_opts" __zoxide_zi "$@"
}
fi




# A better ls | grep, handles no arguments and adds color
lsg() {
  if [ -z "$1" ]; then
    # If no argument is given, just do a normal ls -la
    ls -l
  else
    # If there is an argument, pipe ls to grep
    # --color=auto highlights the match
    ls -la | grep -i --color=auto "$1"
  fi
}

##---Custom mapings for opening files with respect to their default applications set in file association

# oo because it's ergonomic
oo() {
  xdg-open "$@"
}

# xo because it's easy to remember just the first letters man xdg that's `x` and open that's `o`
xo() {
  xdg-open "$@"
}

##---END

# This is for bindings L-z inside terminal after you click C-z for bring to forground, without typing it. saves a bit of time.



# This is for bindings A-x inside terminal for zi in zoxide without typing it, saves a bit of time.
# zi-widget() {
#     BUFFER="zi"
#     zle accept-line
# }



# Universal copy-to-clipboard function for files.
# Handles common image types correctly and defaults to plain text.
# Automatically uses xclip (for X11) or wl-copy (for Wayland).
# Usage: cxclip <file_path>
Cxclip() {
  # --- 1. Input Validation ---
  if [ -z "$1" ]; then
    echo "Usage: cxclip <file_path>" >&2
    return 1
  fi

  if [ ! -f "$1" ]; then
    echo "Error: File not found: '$1'" >&2
    return 1
  fi

  # --- 2. Determine File Type and MIME Type ---
  local filepath="$1"
  local ext
  # Get lowercase extension from the filename
  ext=$(echo "${filepath##*.}" | tr '[:upper:]' '[:lower:]')
  local mimetype

  case "$ext" in
    png)      mimetype="image/png" ;;
    jpg|jpeg) mimetype="image/jpeg" ;;
    gif)      mimetype="image/gif" ;;
    webp)     mimetype="image/webp" ;;
    svg)      mimetype="image/svg+xml" ;;
    bmp)      mimetype="image/bmp" ;;
    *)
      # Default to plain text for any other extension
      mimetype="text/plain" ;;
  esac

  # --- 3. Choose Tool (xclip for X11, wl-copy for Wayland) and Copy ---
  if [ -n "$WAYLAND_DISPLAY" ]; then
    # --- Wayland Environment ---
    if ! command -v wl-copy &> /dev/null; then
      echo "Error: 'wl-copy' not found. Please install wl-clipboard for Wayland." >&2
      return 1
    fi
    
    if [ "$mimetype" = "text/plain" ]; then
      wl-copy < "$filepath"
      echo "Copied '$filepath' to Wayland clipboard as plain text."
    else
      wl-copy -t "$mimetype" < "$filepath"
      echo "Copied '$filepath' to Wayland clipboard as '$mimetype'."
    fi
    
  else
    # --- X11 Environment ---
    if ! command -v xclip &> /dev/null; then
      echo "Error: 'xclip' not found. Please install xclip for X11." >&2
      return 1
    fi

    if [ "$mimetype" = "text/plain" ]; then
      cat "$filepath" | xclip -selection clipboard
      echo "Copied '$filepath' to X11 clipboard as plain text."
    else
      cat "$filepath" | xclip -selection clipboard -t "$mimetype"
      echo "Copied '$filepath' to X11 clipboard as '$mimetype'."
    fi
  fi
}

service() {
    if [ "$2" == "status" ]; then
        systemctl status "$1"
    else
        sudo systemctl "$2" "$1"
    fi
}

##---Things to Consider deleting the following:--------------

# this is stupid but it uses obsidian-cli but I don't use it 
# obcd() {
#     local result=$(obsidian-cli print-default --path-only)
#     [ -n "$result" ] && cd -- "$result"
# }

xkill() {
    # Check the first argument passed to the function
    case "$1" in
        -p|--pause)
            echo "Click on the window to PAUSE..."
            # Get the PID and send the STOP signal
            pid=$(xprop _NET_WM_PID | awk '{print $3}')
            if [[ -n "$pid" ]]; then
                kill -STOP "$pid" && echo "Process PID $pid paused."
            else
                echo "No window selected or PID not found."
            fi
            ;;

        -c|--continue)
            echo "Click on the window to CONTINUE..."
            # Get the PID and send the CONT signal
            pid=$(xprop _NET_WM_PID | awk '{print $3}')
            if [[ -n "$pid" ]]; then
                kill -CONT "$pid" && echo "Process PID $pid continued."
            else
                echo "No window selected or PID not found."
            fi
            ;;

        *)
            # If the argument is anything else, run the REAL xkill command.
            # 'command' tells the shell to ignore this function and run the actual program.
            # "$@" passes along all the original arguments.
            echo "Running original xkill..."
            command xkill "$@"
            ;;
    esac
}

# Smart functions to control the phone screen via ADB
# They automatically find the device serial for the specified IP.

phoneWakeup() {
  # Find the device serial (IP:PORT) for your phone's static IP
  local device_serial
  device_serial=$(adb devices | grep '192.168.11.118:' | awk '{print $1}')

  # Check if the device was found
  if [ -z "$device_serial" ]; then
    echo "Error: Phone with IP 192.168.11.118 not found."
    echo "Is it connected via 'adb connect'?"
    return 1 # Return with an error code
  fi

  # Send the command to the found device
  echo "Waking up device: $device_serial"
  adb -s "$device_serial" shell input keyevent KEYCODE_WAKEUP
}

phoneSleep() {
  # Find the device serial (IP:PORT) for your phone's static IP
  local device_serial
  device_serial=$(adb devices | grep '192.168.11.118:' | awk '{print $1}')

  # Check if the device was found
  if [ -z "$device_serial" ]; then
    echo "Error: Phone with IP 192.168.11.118 not found."
    echo "Is it connected via 'adb connect'?"
    return 1 # Return with an error code
  fi

  # Send the command to the found device
  echo "Putting device to sleep: $device_serial"
  adb -s "$device_serial" shell input keyevent KEYCODE_SLEEP
}


# Add this function to your ~/.bashrc or ~/.zshrc file
# Add this function to your ~/.bashrc or ~/.zshrc file
rr() {
    echo "Please select the window or region you want to stream..."
    local selection=$(slop -f "%x %y %w %h")

    if [ -z "$selection" ]; then
        echo "No region selected. Aborting."
        return 1
    fi

    read -r x y w h <<< "$selection"

    echo "Streaming region: Width=$w, Height=$h at position ($x, $y)"

    ffplay -fflags nobuffer -flags low_delay -framedrop \
           -hwaccel vaapi \
           -f x11grab \
           -framerate 30 \
           -video_size "${w}x${h}" \
           -i ":0.0+${x},${y}" \
           -noborder \
           -alwaysontop \
           -window_title "Spy Cam"
}


# Name it something different to keep your original
# Spy on a specific window, even across virtual desktops.



rr_medium() {
    local selection=$(slop -f "%x %y %w %h")
    if [ -z "$selection" ]; then
        echo "No region selected. Aborting."
        return 1
    fi
    
    read -r x y w h <<< "$selection"
    
    ffplay -f x11grab -video_size ${w}x${h} -i ":0.0+${x},${y}" \
           -fflags nobuffer -flags low_delay -framedrop \
           -framerate 30 -noborder -alwaysontop \
           -window_title "Live Preview"
}

rr_light() {
    local selection=$(slop -f "%x %y %w %h")
    if [ -z "$selection" ]; then
        echo "No region selected. Aborting."
        return 1
    fi
    
    read -r x y w h <<< "$selection"
    
    ffplay -f x11grab -video_size ${w}x${h} -i ":0.0+${x},${y}" \
           -framerate 8 -noborder -alwaysontop \
           -window_title "Light Preview" \
           -x ${w} -y ${h}
}











# _Ecat)
# W45 Sun, 09 at 19:32
# ---START------------------------------------------------------------
# ""Ecat""
# --------------------------------------------------------------------

# [[]]

# DESCRIPTION: Ecat stands for Everything cat. and when I cat everything I ususually
#               most of the time usually want to copy everything.

# Why?:

# Solution?:

# --------------------------------------------------------------------



# This stupid Ecat copies everything including images and shit trash data mumbo jumpboo
# alias Ecat="cat **/*(.) | xclip -selection clipboard"

# I just made an Ecat(){} function bellow check it out... otherwise this command I think is better. Havne't tested it yet. I used to use the mumbo jumbo Ecat one above this one 
# alias Ecat="cat **/*(.)~*.(jpg|jpeg|png|gif|bmp|mp3|mp4|zip|rar|gz|tgz|bz2|iso|exe|dll|pdf|odt|docx|xlsx) | xclip -selection clipboard"



Ecat() {
  local files
  # Find all regular files recursively
  files=(**/*(.))

  for f in "${files[@]}"; do
    # Check the mime-type. If it starts with 'text/', print the content.
    if [[ $(file -b --mime-type "$f") == text/* ]]; then
      cat "$f"
    fi
  done | xclip -selection clipboard
}

# Change the alias to a function
# alias Ecat="Ecat" # (if you want to keep the alias name)




# --------------------------------------------------------------------
# ""Ecat""
# ---END--------------------------------------------------------------








##---END

autoload -U compinit
if [ -n "$HOME/.cache/zcompdump"(.om[1]) ]; then
  compinit -i -U -d "$HOME/.cache/zcompdump"
else
  # If the file doesn't exist, create it. -C stops it from reading .zshrc files
  compinit -i -C -U -d "$HOME/.cache/zcompdump"
fi

compdef _files cat


# END---[FUNCTIONS]-- [ myfuncs ] [ my functions] END---------
export TERMINAL=alacritty

# 1. Set the PROMPT variable using our function
configure_prompt

# Generated for envman. Do not edit.
[ -s "$HOME/.config/envman/load.sh" ] && source "$HOME/.config/envman/load.sh"
