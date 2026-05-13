#!/usr/bin/env python3

import subprocess
import sys

# --- Configuration ---
MPV_CLASS = "mpv"
MPV_TARGET_MONITOR_INDEX = 1  # 0 is the first monitor, 1 is the second
GENERIC_MUSIC_TITLE = "_m_"
# ---------------------

def run_command(command):
    """Runs a shell command and returns the output or None on failure."""
    try:
        result = subprocess.run(
            command,
            capture_output=True,
            text=True,
            check=True,
            shell=True
        )
        return result.stdout.strip()
    except subprocess.CalledProcessError as e:
        # print(f"Error executing command: {e}")
        return None
    except FileNotFoundError:
        print("Error: wmctrl not found. Please ensure it is installed.")
        sys.exit(1)

def activate_window(window_id):
    """Activates the window by its ID."""
    print(f"Activating window ID: {window_id}")
    run_command(f"wmctrl -ia {window_id}")
    sys.exit(0)

def get_window_list():
    """Gets a list of all windows from wmctrl -lG and parses them."""
    # Output format: <ID> <Desktop> <Geometry> <Hostname> <Title>
    output = run_command("wmctrl -lG")
    if not output:
        return []

    windows = []
    for line in output.split('\n'):
        parts = line.split()
        if len(parts) >= 6:
            # ID is parts[0], Geometry is parts[2] and parts[3] (x and y)
            window_id = parts[0]
            # Convert X coordinate to integer
            x_pos = int(parts[2])
            title = " ".join(parts[5:])
            windows.append({
                'id': window_id,
                'x': x_pos,
                'title': title
            })
    return windows

def get_monitor_info():
    """Gets monitor geometry from wmctrl -d."""
    # Output format: 0 * DG: 2560x1080 VP: 0,0 WA: 0,0 2560x1080
    output = run_command("wmctrl -d")
    if not output:
        return []

    monitors = []
    # This part is the trickiest as wmctrl doesn't clearly list separate monitors,
    # but we can infer the boundaries if we know the total size and layout.
    # A more robust solution might use xrandr, but for simple layouts,
    # we can often rely on the total size and assume equal split or known geometry.
    
    # Let's use xrandr for reliable monitor detection (Requires xrandr)
    xrandr_output = run_command("xrandr --query")
    if not xrandr_output:
        print("Warning: xrandr not found. Cannot determine monitor boundaries accurately.")
        # Fallback: assume second monitor starts at the total width of the first screen
        return None

    # Parse xrandr for connected monitors and their geometry
    import re
    monitor_geometries = []
    # Regex to find connected monitors and their position/size (e.g., 1920x1080+2560+0)
    for line in xrandr_output.split('\n'):
        match = re.search(r' connected (\d+x\d+)\+(\d+)\+(\d+)', line)
        if match:
            # size, x_offset, y_offset
            # We only care about the X offset
            monitor_geometries.append(int(match.group(2)))
    
    # Sort the offsets to determine the boundary of the second monitor
    monitor_geometries.sort()
    
    if len(monitor_geometries) > MPV_TARGET_MONITOR_INDEX:
        # The start X coordinate of the target monitor
        return monitor_geometries[MPV_TARGET_MONITOR_INDEX]
        
    return None # Not enough monitors found

def main():
    """Main function to prioritize and activate the correct window."""

    print("Running smart music switch...")
    
    # 1. Get the starting X position of the target monitor (Monitor 1, i.e., the second monitor)
    target_monitor_x_start = get_monitor_info()
    
    # If we couldn't determine the monitor boundary, we skip the monitor check for MPV
    skip_monitor_check = target_monitor_x_start is None

    # 2. Check for MPV (with monitor preference)
    mpv_id = None
    
    # wmctrl -lx gives: <ID> <Desktop> <Client Class> <Hostname> <Title>
    mpv_list_output = run_command(f"wmctrl -lx | grep -i {MPV_CLASS}")
    
    if mpv_list_output:
        # We found potential MPV windows.
        
        # Get full window list to check geometry (X position)
        all_windows = get_window_list()
        
        for line in mpv_list_output.split('\n'):
            parts = line.split()
            if len(parts) >= 3 and parts[2].lower().startswith(MPV_CLASS):
                current_id = parts[0]
                
                # Find the window's geometry info
                window_info = next((w for w in all_windows if w['id'] == current_id), None)
                
                if window_info:
                    x_pos = window_info['x']
                    
                    if skip_monitor_check:
                        # Activate the first found MPV window if we can't check monitor
                        mpv_id = current_id
                        break
                    
                    # Check if the window's X position is on or past the second monitor's start X
                    if x_pos >= target_monitor_x_start:
                        mpv_id = current_id
                        break
        
    if mpv_id:
        print("Found MPV on target monitor. Activating.")
        activate_window(mpv_id)
        
    # 3. If no MPV found (or none on the target monitor), check for generic music window
    
    # We use wmctrl -a <title> which implicitly looks for a window with that title and activates it.
    # However, to be polite and exit properly, we should check if it exists first.
    
    generic_id = None
    
    for window in all_windows:
        if GENERIC_MUSIC_TITLE in window['title']:
            generic_id = window['id']
            break

    if generic_id:
        print(f"Found generic music window '{GENERIC_MUSIC_TITLE}'. Activating.")
        activate_window(generic_id)
    
    # 4. Fallback
    print("No target window found.")
    sys.exit(1)

if __name__ == "__main__":
    main()
