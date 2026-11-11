`setxkbmap` is built into every Linux system with X11 out of the box. Zero installation needed.

Type this in your terminal to turn Caps Lock into a Control key right now:
```bash
setxkbmap -option ctrl:nocaps
```

To reset it back to normal:
```bash
setxkbmap -option ""
```

To keep it active every time you log in, add this line to `~/.config/i3/config`:
```text
exec_always --no-startup-id setxkbmap -option ctrl:nocaps
```

But as usually just remember the thing
