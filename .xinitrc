# Load X resources (keyboard speed, colors)
# [[ -f ~/.Xresources ]] && xrdb -merge ~/.Xresources

# Set keyboard layout first (important!)
setxkbmap us

# Fix keyboard repeat (Fast)
xset r rate 240 68



# Disable laptop screen (if HDMI connected)
# Check name with 'xrandr'. Usually eDP-1.
xrandr --output eDP-1 --off

# Start i3
exec i3
