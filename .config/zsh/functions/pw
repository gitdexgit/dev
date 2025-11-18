#!/bin/zsh


pw() {
  # Check for tools
  if ! command -v sushi &> /dev/null || ! command -v xdotool &> /dev/null || ! command -v wmctrl &> /dev/null; then
    echo "Error: Missing required tools." >&2; return 1;
  fi

  local sushi_class="Org.gnome.NautilusPreviewer"

  # Find an item
  local item
  item=$(fd --hidden . | fzf --height 60% --reverse)

  if [[ -n "$item" ]]; then
    # --- MONITOR-AWARE LOGIC ---
    eval "$(xdotool getmouselocation --shell)"
    local current_mouse_x=$X
    local original_mouse_y=$Y

    local target_center_x
    local target_center_y

    # Use your tested, hardcoded coordinates
    if [[ "$current_mouse_x" -lt 1920 ]]; then
      target_center_x=828
      target_center_y=551
    else
      target_center_x=2567
      target_center_y=370
    fi

    # Launch sushi
    sushi "$item" &

    # Poll for the window ID to know when it's ready
    local sushi_window_id=""
    local -i maxtries=50; local -i count=0
    while [[ -z "$sushi_window_id" && "$count" -lt "$maxtries" ]]; do
      sushi_window_id=$(xdotool search --class "$sushi_class" | tail -1)
      sleep 0.1
      ((count++))
    done

    # If the window appeared...
    if [[ -n "$sushi_window_id" ]]; then
      # STEP 1: FOCUS THE WINDOW
      # Move mouse, click to focus, and move back instantly.
      sleep 0.1
      xdotool mousemove "$target_center_x" "$target_center_y" click 1 mousemove "$current_mouse_x" "$original_mouse_y"

      # STEP 2: ADD "ALWAYS ON TOP"
      # This is the part from your inspiration. We target the window that
      # is now ":ACTIVE:" because of our click.
      sleep 0.1
      wmctrl -r :ACTIVE: -b add,above

    else
      echo "Error: Timed out waiting for the sushi window." >&2
    fi
  fi
}

