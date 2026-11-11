When you already have default desktop when your computer first launches and you run
`startx [program]` it defaults to :0

If you switch to tty2, Your first desktop already took screen slot `:0`.

If you type just `startx` on TTY2, it tries to use slot `:0` again and crashes.

Adding `-- :1` forces it to use the empty second slot instead:

Example:
-------
```bash
startx -- :1
# Or launch a specific desktop:
startx /usr/bin/xfce4-session -- :1
```

