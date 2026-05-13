#!/bin/bash

# Increase width to 5 to fit larger line numbers
declare -r LINE_NUMBER_PANE_WIDTH=5
declare -r LINE_NUMBER_UPDATE_DELAY=0.1
declare -r COLOR_NUMBERS_RGB="101;112;161"
declare -r COLOR_ACTIVE_NUMBER_RGB="255;158;100"

open_line_number_split(){
    local self_path=$(realpath $0)
    local pane_id=$(tmux display-message -pF "#{pane_id}")
    if pgrep -f "$self_path $pane_id" > /dev/null; then
        return
    fi
    tmux split-window -h -l $LINE_NUMBER_PANE_WIDTH -b "$self_path $pane_id"
    tmux select-pane -l
}

enter_copy_mode(){
    local target_pane=$1
    tmux copy-mode -t "$target_pane"
    # ONLY DO IT ONCE: This centers the view immediately on entry (like zz)
    # tmux send-keys -t "$target_pane" -X scroll-middle
}

get_cursor_info(){
    tmux display-message -pt "$target_pane" -F '#{copy_cursor_y} #{scroll_position} #{history_size}'
}

is_in_copy_mode(){
    local mode=$(tmux display-message -p -t "$target_pane" -F '#{pane_mode}')
    [[ -n "$mode" ]]
}

redraw_line_numbers(){
    local cursor_y=$1
    local scroll_pos=$2
    local history_size=$3
    local lines=$(tput lines)

    # Calculate absolute line number
    local absolute_line=$((history_size - scroll_pos + cursor_y))

    clear -x

    # Relative numbers ABOVE
    printf "\e[38;2;$COLOR_NUMBERS_RGB;2m"
    if [ $cursor_y -gt 0 ]; then
        seq $cursor_y -1 1
    fi
    printf "\e[0m"

    # THE ABSOLUTE NUMBER
    printf "\e[38;2;$COLOR_ACTIVE_NUMBER_RGB;1m%${LINE_NUMBER_PANE_WIDTH}d\e[0m" "$absolute_line"

    # Relative numbers BELOW
    if [ $lines -gt $(($cursor_y + 1)) ]; then
        echo
        printf "\e[38;2;$COLOR_NUMBERS_RGB;2m"
        seq 1 $(($lines - $cursor_y - 2))
        printf $((lines - $cursor_y - 1))
        printf "\e[0m"
    fi
}

update_loop(){
    local last_info="-1"
    local last_sp="-1" # Added to track scroll jumps

    while is_in_copy_mode; do
        local current_info=$(get_cursor_info)

        if [ "$current_info" != "$last_info" ]; then
            read -r cy sp hs <<< "$current_info"

            # --- JUMP DETECTION (Ctrl+u, Ctrl+d) ---
            # If the scroll position changed by more than 1 line, trigger zz
            # if [ "$last_sp" != "-1" ] && [ "$sp" != "$last_sp" ]; then
            #     local diff=$(( sp - last_sp ))
            #     if [ "${diff#-}" -gt 1 ]; then
            #         tmux send-keys -t "$target_pane" -X scroll-middle
            #         # Refresh data so line numbers match the new centered position
            #         current_info=$(get_cursor_info)
            #         read -r cy sp hs <<< "$current_info"
            #     fi
            # fi
            last_sp="$sp"
            # ---------------------------------------

            redraw_line_numbers "$cy" "$sp" "$hs"
            last_info="$current_info"
        fi

        sleep $LINE_NUMBER_UPDATE_DELAY
    done
}

restore_pane_width(){
    local target_pane=$1
    tmux resize-pane -t "$target_pane" -L $(($LINE_NUMBER_PANE_WIDTH + 1)) 2>/dev/null || true
}

main(){
    local target_pane=$1
    if [ -z "$target_pane" ]; then
        open_line_number_split
        exit 0
    else
        enter_copy_mode "$target_pane"
    fi
    update_loop
    restore_pane_width "$target_pane"
}

main "$@"
