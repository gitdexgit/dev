#!/bin/bash

PID_FILE="/tmp/paused_pid.txt"

if [ -f "$PID_FILE" ]; then
    # Unpause - but still select the same window
    echo "Click on the window you want to resume..."
    WINDOW_ID=$(xdotool selectwindow 2>/dev/null)
    
    if [ -n "$WINDOW_ID" ]; then
        # Get the PID for this window (using same method as pause)
        WM_CLASS=$(xprop -id "$WINDOW_ID" WM_CLASS 2>/dev/null)
        CLASS_NAME=$(echo "$WM_CLASS" | awk -F '"' '{print $4}' | cut -d',' -f1)
        
        if [ -n "$CLASS_NAME" ]; then
            PID=$(pgrep -f "$CLASS_NAME" | head -n 1)
        else
            # Fallback to common names
            for name in "zen" "browser" "zen-browser" "chrome" "firefox"; do
                PID=$(pgrep -i "$name" | head -n 1)
                if [ -n "$PID" ]; then
                    break
                fi
            done
        fi
        
        # Use the PID from the file as backup if we can't match
        if [ -z "$PID" ]; then
            PID=$(cat "$PID_FILE")
        fi
        
        if [ -n "$PID" ] && ps -p "$PID" > /dev/null; then
            kill -CONT "$PID"
            rm "$PID_FILE"
            echo "Process resumed (PID: $PID)"
        else
            echo "Could not find process to resume"
        fi
    else
        echo "No window selected"
    fi
else
    # Pause a new process
    echo "Click on the window you want to pause..."
    WINDOW_ID=$(xdotool selectwindow)
    
    if [ -n "$WINDOW_ID" ]; then
        echo "Selected window ID: $WINDOW_ID"
        
        # Get window class
        WM_CLASS=$(xprop -id "$WINDOW_ID" WM_CLASS 2>/dev/null)
        echo "Window class info: $WM_CLASS"
        
        CLASS_NAME=$(echo "$WM_CLASS" | awk -F '"' '{print $4}' | cut -d',' -f1)
        echo "Class name: $CLASS_NAME"
        
        if [ -n "$CLASS_NAME" ]; then
            PID=$(pgrep -f "$CLASS_NAME" | head -n 1)
            echo "Found PID by class: $PID"
        fi
        
        if [ -z "$PID" ]; then
            for name in "zen" "browser" "zen-browser" "chrome" "firefox"; do
                PID=$(pgrep -i "$name" | head -n 1)
                if [ -n "$PID" ]; then
                    echo "Found PID by common name: $PID"
                    break
                fi
            done
        fi
        
        if [ -n "$PID" ] && ps -p "$PID" > /dev/null; then
            kill -STOP "$PID"
            echo "$PID" > "$PID_FILE"
            echo "Process paused (PID: $PID)"
        else
            echo "Could not find process"
        fi
    else
        echo "No window selected"
    fi
fi
