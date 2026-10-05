# 1. Resources and Keyboard
xrdb -merge ~/.Xresources

setxkbmap us
[ -f ~/.Xmodmap ] && xmodmap ~/.Xmodmap

xset r rate 220 50
xset s off -dpms

# 2. Monitor Setup
xrandr --output HDMI-1 --mode 1920x1080 --primary --output eDP-1 --off

# 3. Environment Variables
export XDG_SESSION_TYPE=x11
export XDG_CURRENT_DESKTOP=i3
export XDG_SESSION_DESKTOP=i3

# Force X11 and Disable Portals (Fixes Flameshot v13)
export QT_QPA_PLATFORM=xcb
export QT_NO_XDG_DESKTOP_PORTAL=1
unset GTK_USE_PORTAL

# 4. Sync Environment
# Tells DBus and Systemd where your screen is
if command -v dbus-update-activation-environment >/dev/null 2>&1; then
    dbus-update-activation-environment --systemd DISPLAY XAUTHORITY XDG_CURRENT_DESKTOP
fi
systemctl --user import-environment DISPLAY XAUTHORITY

# 5. Launch i3
exec i3
