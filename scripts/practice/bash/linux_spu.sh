#!/bin/bash

# To display in terminal, updating in place:
# watch -n 0.2 -t --color bash -c " \
#   eval \$(xdotool getmouselocation --shell); \
#   if [ -n \"\$WINDOW\" ] && [ \"\$WINDOW\" != \"0\" ]; then \
#     TITLE=\$(xdotool getwindowname \$WINDOW); \
#     CLASS=\$(xdotool getwindowclassname \$WINDOW); \
#     PID=\$(xdotool getwindowpid \$WINDOW); \
#     GEOMETRY=\$(xdotool getwindowgeometry --shell \$WINDOW); \
#     eval \$GEOMETRY; \
#     echo -e \"Mouse X: \$X\\nMouse Y: \$Y\\nScreen: \$SCREEN\\nWindow ID: \$WINDOW\\nPID: \$PID\\nTitle: \$TITLE\\nClass: \$CLASS\\nWindow X: \$X_WIN\\nWindow Y: \$Y_WIN\\nWidth: \$WIDTH\\nHeight: \$HEIGHT\"; \
#   else \
#     echo -e \"Mouse X: \$X\\nMouse Y: \$Y\\nScreen: \$SCREEN\\n(No window under cursor or root window)\"; \
#   fi"

# To display in a YAD GUI window:
(while true; do
    eval $(xdotool getmouselocation --shell)
    OUTPUT="Mouse X: $X\nMouse Y: $Y\nScreen: $SCREEN\n"

    if [ -n "$WINDOW" ] && [ "$WINDOW" != "0" ] && [ "$WINDOW" != "1" ]; then # Window 0 or 1 can be root
        W_TITLE=$(xdotool getwindowname "$WINDOW" 2>/dev/null)
        W_CLASS=$(xdotool getwindowclassname "$WINDOW" 2>/dev/null)
        W_PID=$(xdotool getwindowpid "$WINDOW" 2>/dev/null)
        
        # Get window geometry (x,y,width,height of the window itself)
        # xdotool getwindowgeometry can be a bit slow, consider alternatives if too laggy
        eval $(xdotool getwindowgeometry --shell "$WINDOW" 2>/dev/null)
        # Rename to avoid conflict with mouse X, Y
        WIN_X=$X 
        WIN_Y=$Y
        
        OUTPUT+="Window ID: $WINDOW\n"
        OUTPUT+="PID: $W_PID\n"
        OUTPUT+="Title: $W_TITLE\n"
        OUTPUT+="Class: $W_CLASS\n"
        OUTPUT+="Win X: $WIN_X\n" # Window's top-left X
        OUTPUT+="Win Y: $WIN_Y\n" # Window's top-left Y
        OUTPUT+="Width: $WIDTH\n"
        OUTPUT+="Height: $HEIGHT\n"
    else
        OUTPUT+="(No specific application window under cursor or over root window)\n"
    fi
    echo -e "$OUTPUT"
    echo "---" # Separator for yad --text-info --tail
    sleep 0.2 # Refresh rate
done) | yad --text-info --tail --width=500 --height=300 --title="Linux Window Spy" --wrap --show-uri
