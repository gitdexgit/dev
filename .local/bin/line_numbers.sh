#!/bin/bash
declare -r LINE_NUMBER_PANE_WIDTH=2
declare -r LINE_NUMBER_UPDATE_DELAY=0.1
declare -r COLOR_NUMBERS_RGB="101;112;161"
declare -r COLOR_ACTIVE_NUMBER_RGB="255;158;100"

open_line_number_split(){
    local self_path=$(realpath "$0")
    local pane_id=$(tmux display-message -pF "#{pane_id}")

    local existing=$(pgrep -f "$self_path $pane_id")
    if [ -n "$existing" ]; then
        kill $existing
        return
    fi

    tmux split-window -h -l $LINE_NUMBER_PANE_WIDTH "$self_path $pane_id"
    tmux select-pane -l
}

enter_copy_mode(){
    tmux copy-mode -t "$target_pane"
}

get_cursor_info(){
    tmux display-message -pt "$target_pane" -F '#{copy_cursor_y}'
}

is_in_copy_mode(){
    local mode=$(tmux display-message -p -t "$target_pane" -F '#{pane_mode}')
    [[ "$mode" == "copy-mode" ]]
}

redraw_line_numbers(){
    local cursor_y=$1
    local lines=$(tmux display-message -p -t "$target_pane" -F '#{pane_height}')

    printf "\e[H"

    for (( i=0; i<lines; i++ )); do
        local rel=$(( cursor_y - i ))
        if [ $rel -gt 0 ]; then
            printf "\e[38;2;${COLOR_NUMBERS_RGB};2m%2d\e[0m\e[K\n" $rel
        elif [ $rel -eq 0 ]; then
            printf "\e[38;2;${COLOR_ACTIVE_NUMBER_RGB};1m%2d\e[0m\e[K\n" 0
        else
            printf "\e[38;2;${COLOR_NUMBERS_RGB};2m%2d\e[0m\e[K\n" $(( -rel ))
        fi
    done
}

update_loop(){
    local last_info="-1"
    while is_in_copy_mode; do
        local current_info=$(get_cursor_info)
        if [ "$current_info" != "$last_info" ]; then
            read -r cy <<< "$current_info"
            redraw_line_numbers "$cy"
            last_info="$current_info"
        fi
        sleep $LINE_NUMBER_UPDATE_DELAY
    done
}

restore_pane_width(){
    tmux resize-pane -t "$target_pane" -L $(($LINE_NUMBER_PANE_WIDTH + 1)) 2>/dev/null || true
}

main(){
    target_pane=$1
    if [ -z "$target_pane" ]; then
        open_line_number_split
        exit 0
    else
        enter_copy_mode
    fi
    update_loop
    restore_pane_width
}

main "$@"
