xrdb -merge ~/.Xresources

setxkbmap us
xset r rate 220 50

xrandr --output HDMI-1 --mode 1920x1080 --primary --output eDP-1 --off

export XDG_SESSION_TYPE=x11
export XDG_CURRENT_DESKTOP=i3
export XDG_SESSION_DESKTOP=i3
export XDG_RUNTIME_DIR="/run/user/$(id -u)"
export GTK_USE_PORTAL=1

dbus-update-activation-environment --systemd \
    DISPLAY \
    XAUTHORITY \
    XDG_CURRENT_DESKTOP \
    XDG_SESSION_DESKTOP \
    XDG_SESSION_TYPE \
    XDG_RUNTIME_DIR

exec dbus-run-session i3
