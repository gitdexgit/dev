import subprocess, os, signal, atexit

USER = os.getlogin()
UID = str(os.getuid())
ENV = {**os.environ, "DISPLAY": ":0", "DBUS_SESSION_BUS_ADDRESS": f"unix:path=/run/user/{UID}/bus"}
ICONS = {"normal": "media-record", "emacs": "emacs"}
COLORS = {"normal": "#FFFFFF", "emacs": "#FF69B4", "red": "#FF0000"}
PIDFILE = f"/tmp/keydindicator_yad_{UID}.pids"

def kill_own_yad():
    if os.path.exists(PIDFILE):
        with open(PIDFILE) as f:
            for pid_str in f.read().split():
                try:
                    os.kill(int(pid_str), signal.SIGTERM)
                except (ProcessLookupError, ValueError):
                    pass
        os.remove(PIDFILE)

def save_pids(proc):
    if proc:
        with open(PIDFILE, "w") as f:
            f.write(str(proc.pid))
    elif os.path.exists(PIDFILE):
        os.remove(PIDFILE)

class KeydIndicator:
    def __init__(self):
        self.emacs_proc = None
        atexit.register(kill_own_yad)

    def notify(self, title, msg, color, icon):
        subprocess.Popen([
            "notify-send", "-t", "400",
            "-h", f"string:bgcolor:{color}",
            "-h", "string:frcolor:#000000",
            "-h", "string:fgcolor:#000000",
            "-i", icon, title, msg
        ], env=ENV)

    def run(self):
        proc = subprocess.Popen(["stdbuf", "-oL", "keyd", "listen"], stdout=subprocess.PIPE, text=True, bufsize=1)
        if proc.stdout:
            for line in proc.stdout:
                l = line.strip()
                if l == "+keyd_emacs":
                    if not self.emacs_proc:
                        self.emacs_proc = subprocess.Popen(
                            ["yad", "--notification", "--image", ICONS["emacs"], "--text", "Emacs"], env=ENV
                        )
                        save_pids(self.emacs_proc)
                    self.notify("Keyd", "Emacs ON", COLORS["emacs"], ICONS["emacs"])
                elif l == "-keyd_emacs":
                    if self.emacs_proc:
                        self.emacs_proc.terminate()
                        self.emacs_proc = None
                        save_pids(None)
                    self.notify("Keyd", "Emacs OFF", COLORS["red"], ICONS["normal"])

if __name__ == "__main__":
    kill_own_yad()
    KeydIndicator().run()
