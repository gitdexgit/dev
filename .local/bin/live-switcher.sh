#!/usr/bin/env bash
set -euo pipefail

# Filter: Current workspace -> Tiling nodes only -> Actual windows
FILTER='.. | objects | select(.type == "workspace" and any(.. | objects; .focused == true)) | .nodes[] | .. | objects | select(.window != null)'

get_tree() {
    command -v swaymsg &>/dev/null && swaymsg -t get_tree || i3-msg -t get_tree
}

wm_focus() {
    local id="$1"
    [[ -z "$id" || "$id" == "null" ]] && return 0
    local cmd; command -v swaymsg &>/dev/null && cmd="swaymsg" || cmd="i3-msg"
    $cmd "[con_id=$id] focus" &>/dev/null || true
}

if [[ -z "${ROFI_RETV:-}" ]]; then
    # ---------------- WRAPPER MODE ----------------
    orig_id=$(get_tree | jq '[.. | objects | select(.focused == true) | .id][0]')
    state=$(mktemp /tmp/rofi-live-switch.XXXXXX)
    # Line 1: original_id, Line 2: current_index
    echo -e "$orig_id\n0" > "$state"

    ROFI_LIVE_SWITCH_STATE="$state" rofi -show switcher -modi "switcher:$0" \
        -kb-row-down "" -kb-row-up "" \
        -kb-custom-1 "Down" -kb-custom-2 "Up"

    # If user hits Escape (exit 1), restore original focus
    [[ $? -eq 1 ]] && wm_focus "$(head -n 1 "$state")"
    rm -f "$state"
    exit 0
fi

# ---------------- MODI SCRIPT MODE ----------------
state="$ROFI_LIVE_SWITCH_STATE"
curr_idx=$(sed -n '2p' "$state")
mapfile -t ids < <(get_tree | jq -r "$FILTER | .id")
max_idx=$((${#ids[@]} - 1))

case "$ROFI_RETV" in
    0)  echo -en "\0use-hot-keys\x1ftrue\n" ;;
    10) # Down
        curr_idx=$(( curr_idx < max_idx ? curr_idx + 1 : curr_idx ))
        wm_focus "${ids[$curr_idx]:-}"
        ;;
    11) # Up
        curr_idx=$(( curr_idx > 0 ? curr_idx - 1 : 0 ))
        wm_focus "${ids[$curr_idx]:-}"
        ;;
    1)  # Enter
        wm_focus "${ROFI_INFO:-}"
        exit 0
        ;;
esac

# Update state and Rofi UI
sed -i "2s/.*/$curr_idx/" "$state"
echo -en "\0keep-selection\x1ftrue\n"
echo -en "\0selected-row\x1f$curr_idx\n"
get_tree | jq -r "$FILTER | \"\(.name // .app_id // \"?\")\u0000info\u001f\(.id)\""
