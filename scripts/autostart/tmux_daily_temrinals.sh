#!/bin/bash
#
# Script to launch my primary Alacritty + Tmux workspace

#============ seting up tmux sessions

# waiting for other  startups 
sleep 60

alacritty --title "_tmux_" -e tmux &


# waiting for tmux resurections 
sleep 30





#================ starting _git_

# --- Configuration ---
# The WM_CLASS of the application you want to move.
# You can find this by running `xprop WM_CLASS` and clicking on the window.
# For Obsidian, it's typically "obsidian.obsidian".
APP_TITLE="_git_"

# The command to launch the application.
APP_COMMAND="alacritty --title "_git_" -e tmux new -As "git" &"

# The target desktop (0=D1, 1=D2, 2=D3, etc.).
TARGET_DESKTOP=6

# How many seconds to wait before giving up.
TIMEOUT_SECONDS=30

# --- Script Logic ---

# 1. Launch the application in the background
echo "Launching _git_..."
eval $APP_COMMAND &

# 2. Wait for the window to appear
echo "Waiting for the Obsidian window to appear..."
SECONDS=0 # Reset the shell's internal timer
while true; do
    # Check if a window with the specified class exists.
    # `grep -q` is "quiet mode", it just returns a status code (0 if found, 1 if not).
    if wmctrl -lx | grep -q "$APP_TITLE"; then
        echo "Obsidian window found!"
        break # Exit the loop
    fi

    # Check for timeout
    if [ $SECONDS -ge $TIMEOUT_SECONDS ]; then
        echo "Error: Timed out after $TIMEOUT_SECONDS seconds waiting for Obsidian window."
        exit 1
    fi

    # Print a dot to show we're waiting, and wait for 1 second
    printf "."
    sleep 1
done

sleep 1
# 3. Move the window to the target desktop
echo "Moving Obsidian to Desktop $((TARGET_DESKTOP + 1))..."
wmctrl -r "$APP_TITLE" -e 0,52,86,1865,992
sleep 1
wmctrl -r "$APP_TITLE" -t $TARGET_DESKTOP
echo "Done."



#=========== starting _ssh_


# --- Configuration ---
# The WM_CLASS of the application you want to move.
# You can find this by running `xprop WM_CLASS` and clicking on the window.
# For Obsidian, it's typically "obsidian.obsidian".
APP_TITLE="_ssh_"

# The command to launch the application.
APP_COMMAND="alacritty --title "_ssh_" -e tmux new -As "_ssh" &"

# The target desktop (0=D1, 1=D2, 2=D3, etc.).
TARGET_DESKTOP=5

# How many seconds to wait before giving up.
TIMEOUT_SECONDS=30

# --- Script Logic ---

# 1. Launch the application in the background
echo "Launching _git_..."
eval $APP_COMMAND &

# 2. Wait for the window to appear
echo "Waiting for the Obsidian window to appear..."
SECONDS=0 # Reset the shell's internal timer
while true; do
    # Check if a window with the specified class exists.
    # `grep -q` is "quiet mode", it just returns a status code (0 if found, 1 if not).
    if wmctrl -lx | grep -q "$APP_TITLE"; then
        echo "Obsidian window found!"
        break # Exit the loop
    fi

    # Check for timeout
    if [ $SECONDS -ge $TIMEOUT_SECONDS ]; then
        echo "Error: Timed out after $TIMEOUT_SECONDS seconds waiting for Obsidian window."
        exit 1
    fi

    # Print a dot to show we're waiting, and wait for 1 second
    printf "."
    sleep 1
done

sleep 1
# 3. Move the window to the target desktop
echo "Moving Obsidian to Desktop $((TARGET_DESKTOP + 1))..."
wmctrl -r "$APP_TITLE" -e 0,52,86,1865,992
sleep 1
wmctrl -r "$APP_TITLE" -t $TARGET_DESKTOP
echo "Done."



# ================== starting _obsidian_


# --- Configuration ---
# The WM_CLASS of the application you want to move.
# You can find this by running `xprop WM_CLASS` and clicking on the window.
# For Obsidian, it's typically "obsidian.obsidian".
APP_TITLE="_obsidian_"

# The command to launch the application.
APP_COMMAND="alacritty --title "_obsidian_" -e tmux new -As "_obsidian_" &"

# The target desktop (0=D1, 1=D2, 2=D3, etc.).
TARGET_DESKTOP=11

# How many seconds to wait before giving up.
TIMEOUT_SECONDS=30

# --- Script Logic ---

# 1. Launch the application in the background
echo "Launching _git_..."
eval $APP_COMMAND &

# 2. Wait for the window to appear
echo "Waiting for the Obsidian window to appear..."
SECONDS=0 # Reset the shell's internal timer
while true; do
    # Check if a window with the specified class exists.
    # `grep -q` is "quiet mode", it just returns a status code (0 if found, 1 if not).
    if wmctrl -lx | grep -q "$APP_TITLE"; then
        echo "Obsidian window found!"
        break # Exit the loop
    fi

    # Check for timeout
    if [ $SECONDS -ge $TIMEOUT_SECONDS ]; then
        echo "Error: Timed out after $TIMEOUT_SECONDS seconds waiting for Obsidian window."
        exit 1
    fi

    # Print a dot to show we're waiting, and wait for 1 second
    printf "."
    sleep 1
done

sleep 1
# 3. Move the window to the target desktop
echo "Moving Obsidian to Desktop $((TARGET_DESKTOP + 1))..."
wmctrl -r "$APP_TITLE" -e 0,52,86,1865,992
sleep 1
wmctrl -r "$APP_TITLE" -t $TARGET_DESKTOP
echo "Done."

# ================== starting test


# --- Configuration ---
# The WM_CLASS of the application you want to move.
# You can find this by running `xprop WM_CLASS` and clicking on the window.
# For Obsidian, it's typically "obsidian.obsidian".
APP_TITLE="_test_"

# The command to launch the application.
APP_COMMAND="alacritty --title "_test_" -e tmux new -As "Testing" &"

# The target desktop (0=D1, 1=D2, 2=D3, etc.).
TARGET_DESKTOP=2

# How many seconds to wait before giving up.
TIMEOUT_SECONDS=30

# --- Script Logic ---

# 1. Launch the application in the background
echo "Launching _git_..."
eval $APP_COMMAND &

# 2. Wait for the window to appear
echo "Waiting for the Obsidian window to appear..."
SECONDS=0 # Reset the shell's internal timer
while true; do
    # Check if a window with the specified class exists.
    # `grep -q` is "quiet mode", it just returns a status code (0 if found, 1 if not).
    if wmctrl -lx | grep -q "$APP_TITLE"; then
        echo "Obsidian window found!"
        break # Exit the loop
    fi

    # Check for timeout
    if [ $SECONDS -ge $TIMEOUT_SECONDS ]; then
        echo "Error: Timed out after $TIMEOUT_SECONDS seconds waiting for Obsidian window."
        exit 1
    fi

    # Print a dot to show we're waiting, and wait for 1 second
    printf "."
    sleep 1
done

sleep 1
# 3. Move the window to the target desktop
echo "Moving Obsidian to Desktop $((TARGET_DESKTOP + 1))..."
wmctrl -r "$APP_TITLE" -e 0,52,86,1865,992
sleep 1
wmctrl -r "$APP_TITLE" -t $TARGET_DESKTOP
echo "Done."




# ================== starting date


# --- Configuration ---
# The WM_CLASS of the application you want to move.
# You can find this by running `xprop WM_CLASS` and clicking on the window.
# For Obsidian, it's typically "obsidian.obsidian".
APP_TITLE="_dt_"

# The command to launch the application.
APP_COMMAND="alacritty --title "_dt_" -e tmux new -As 'Date&Time _dt_' &"

# The target desktop (0=D1, 1=D2, 2=D3, etc.).
TARGET_DESKTOP=8

# How many seconds to wait before giving up.
TIMEOUT_SECONDS=30

# --- Script Logic ---

# 1. Launch the application in the background
echo "Launching _git_..."
eval $APP_COMMAND &

# 2. Wait for the window to appear
echo "Waiting for the Obsidian window to appear..."
SECONDS=0 # Reset the shell's internal timer
while true; do
    # Check if a window with the specified class exists.
    # `grep -q` is "quiet mode", it just returns a status code (0 if found, 1 if not).
    if wmctrl -lx | grep -q "$APP_TITLE"; then
        echo "Obsidian window found!"
        break # Exit the loop
    fi

    # Check for timeout
    if [ $SECONDS -ge $TIMEOUT_SECONDS ]; then
        echo "Error: Timed out after $TIMEOUT_SECONDS seconds waiting for Obsidian window."
        exit 1
    fi

    # Print a dot to show we're waiting, and wait for 1 second
    printf "."
    sleep 1
done

sleep 1
# 3. Move the window to the target desktop
echo "Moving Obsidian to Desktop $((TARGET_DESKTOP + 1))..."
wmctrl -r "$APP_TITLE" -e 0,52,86,1865,992
sleep 1
wmctrl -r "$APP_TITLE" -t $TARGET_DESKTOP
echo "Done."


# ================== starting read


# --- Configuration ---
# The WM_CLASS of the application you want to move.
# You can find this by running `xprop WM_CLASS` and clicking on the window.
# For Obsidian, it's typically "obsidian.obsidian".
APP_TITLE="_read_"

# The command to launch the application.
APP_COMMAND="alacritty --title "_read_" -e tmux new -As '_read_' &"

# The target desktop (0=D1, 1=D2, 2=D3, etc.).
TARGET_DESKTOP=19

# How many seconds to wait before giving up.
TIMEOUT_SECONDS=30

# --- Script Logic ---

# 1. Launch the application in the background
echo "Launching _git_..."
eval $APP_COMMAND &

# 2. Wait for the window to appear
echo "Waiting for the Obsidian window to appear..."
SECONDS=0 # Reset the shell's internal timer
while true; do
    # Check if a window with the specified class exists.
    # `grep -q` is "quiet mode", it just returns a status code (0 if found, 1 if not).
    if wmctrl -lx | grep -q "$APP_TITLE"; then
        echo "Obsidian window found!"
        break # Exit the loop
    fi

    # Check for timeout
    if [ $SECONDS -ge $TIMEOUT_SECONDS ]; then
        echo "Error: Timed out after $TIMEOUT_SECONDS seconds waiting for Obsidian window."
        exit 1
    fi

    # Print a dot to show we're waiting, and wait for 1 second
    printf "."
    sleep 1
done

sleep 1
# 3. Move the window to the target desktop
echo "Moving Obsidian to Desktop $((TARGET_DESKTOP + 1))..."
wmctrl -r "$APP_TITLE" -e 0,52,86,1865,992
sleep 1
wmctrl -r "$APP_TITLE" -t $TARGET_DESKTOP
echo "Done."



# ================== starting scrcpy


# --- Configuration ---
# The WM_CLASS of the application you want to move.
# You can find this by running `xprop WM_CLASS` and clicking on the window.
# For Obsidian, it's typically "obsidian.obsidian".
APP_TITLE="_scrcpy_"

# The command to launch the application.
APP_COMMAND="alacritty --title "_scrcpy_" -e tmux new -As 'scrcpy' &"

# The target desktop (0=D1, 1=D2, 2=D3, etc.).
TARGET_DESKTOP=15

# How many seconds to wait before giving up.
TIMEOUT_SECONDS=30

# --- Script Logic ---

# 1. Launch the application in the background
echo "Launching _git_..."
eval $APP_COMMAND &

# 2. Wait for the window to appear
echo "Waiting for the Obsidian window to appear..."
SECONDS=0 # Reset the shell's internal timer
while true; do
    # Check if a window with the specified class exists.
    # `grep -q` is "quiet mode", it just returns a status code (0 if found, 1 if not).
    if wmctrl -lx | grep -q "$APP_TITLE"; then
        echo "Obsidian window found!"
        break # Exit the loop
    fi

    # Check for timeout
    if [ $SECONDS -ge $TIMEOUT_SECONDS ]; then
        echo "Error: Timed out after $TIMEOUT_SECONDS seconds waiting for Obsidian window."
        exit 1
    fi

    # Print a dot to show we're waiting, and wait for 1 second
    printf "."
    sleep 1
done

sleep 1
# 3. Move the window to the target desktop
echo "Moving Obsidian to Desktop $((TARGET_DESKTOP + 1))..."
wmctrl -r "$APP_TITLE" -e 0,52,86,1865,992
sleep 1
wmctrl -r "$APP_TITLE" -t $TARGET_DESKTOP
echo "Done."


# ================== starting Afeh


# --- Configuration ---
# The WM_CLASS of the application you want to move.
# You can find this by running `xprop WM_CLASS` and clicking on the window.
# For Obsidian, it's typically "obsidian.obsidian".
APP_TITLE="_Afeh_"

# The command to launch the application.
APP_COMMAND="alacritty --title "_Afeh_" -e tmux new -As '_Afeh' &"

# The target desktop (0=D1, 1=D2, 2=D3, etc.).
TARGET_DESKTOP=9

# How many seconds to wait before giving up.
TIMEOUT_SECONDS=30

# --- Script Logic ---

# 1. Launch the application in the background
echo "Launching _git_..."
eval $APP_COMMAND &

# 2. Wait for the window to appear
echo "Waiting for the Obsidian window to appear..."
SECONDS=0 # Reset the shell's internal timer
while true; do
    # Check if a window with the specified class exists.
    # `grep -q` is "quiet mode", it just returns a status code (0 if found, 1 if not).
    if wmctrl -lx | grep -q "$APP_TITLE"; then
        echo "Obsidian window found!"
        break # Exit the loop
    fi

    # Check for timeout
    if [ $SECONDS -ge $TIMEOUT_SECONDS ]; then
        echo "Error: Timed out after $TIMEOUT_SECONDS seconds waiting for Obsidian window."
        exit 1
    fi

    # Print a dot to show we're waiting, and wait for 1 second
    printf "."
    sleep 1
done

sleep 1
# 3. Move the window to the target desktop
echo "Moving Obsidian to Desktop $((TARGET_DESKTOP + 1))..."
wmctrl -r "$APP_TITLE" -e 0,52,86,1865,992
sleep 1
wmctrl -r "$APP_TITLE" -t $TARGET_DESKTOP
echo "Done."


# ================ starting 2nd screen terminals 

echo "Launching workspace windows..."
sleep 5


# 1. Attach to 'jobs' session with title '_j_'
# Syntax: alacritty --title "TITLE" -e command-to-run
alacritty --title "_j_" -e tmux new -As  "jobs" &

sleep 1
sleep 1
sleep 1
sleep 1
sleep 1
# 2. Attach to 'configs _f_' session with title '_f_'
# NOTE: The session name is in quotes because it contains spaces.
alacritty --title "_f_" -e tmux new -As  "config _f_" &

sleep 1
sleep 1
sleep 1
sleep 1
sleep 1
# 3. Attach to 'Computer resource Management' session with title '_a_'
alacritty --title "_a_" -e tmux new -As "Computer resource Management" &

sleep 1
sleep 1
sleep 1
sleep 1
# 4. Attach to 'logs' session, CREATING it if it doesn't exist.
# NOTE: Your list didn't have a 'logs' session. Using 'new -As' is safer.
# It Attaches if the session exists, or creates a New one if it doesn't.
alacritty --title "_l_" -e tmux new -As "logs" &
sleep 1
sleep 1

alacritty --title "_m_" -e tmux new -As "music _m_" &

sleep 1
sleep 1
alacritty --title "_mi_" -e tmux new -As "mixer _mi_" &
sleep 1
sleep 1
echo "All windows launched."

sleep 1
sleep 1
/home/dex/scripts/bash/window_rules/restart_win_pos.sh
sleep 1
sleep 1
/home/dex/scripts/bash/window_rules/restart_win_pos.sh
sleep 1
sleep 1
/home/dex/scripts/bash/window_rules/restart_win_pos.sh
sleep 1


wmctrl -ic "$(wmctrl -l | grep ' _tmux_$' | awk '{print $1}')"
