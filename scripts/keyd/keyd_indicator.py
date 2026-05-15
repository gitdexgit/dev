import subprocess, os, signal, atexit

USER = os.getlogin()
UID = str(os.getuid())
ENV = {**os.environ, "DISPLAY": ":0", "DBUS_SESSION_BUS_ADDRESS": f"unix:path=/run/user/{UID}/bus"}
ICONS = {"normal": "media-record", "prog": "input-keyboard", "emacs": "emacs"}
COLORS = {"normal": "#FFFFFF", "prog": "#00FF00", "emacs": "#FF69B4", "red": "#FF0000"}
PIDFILE = f"/tmp/keydindicator_yad_{UID}.pids"

def kill_own_yad():
    if os.path.exists(PIDFILE):
        with open(PIDFILE) as f:
            for pid_str in f.read().split():
                try:
                    os.kill(int(pid_str), signal.SIGTERM)
                except ProcessLookupError:
                    pass
        os.remove(PIDFILE)

def save_pids(*procs):
    pids = [str(p.pid) for p in procs if p is not None]
    with open(PIDFILE, "w") as f:
        f.write(" ".join(pids))

class KeydIndicator:
    def __init__(self):
        self.emacs_proc = None
        self.main_yad = subprocess.Popen(
            ["yad", "--notification", "--listen", "--image", ICONS["normal"], "--text", "Normal"],
            stdin=subprocess.PIPE, text=True, env=ENV
        )
        save_pids(self.main_yad)
        atexit.register(kill_own_yad)

    def notify(self, title, msg, color, icon):
        subprocess.Popen([
            "notify-send", "-t", "400",
            "-h", f"string:bgcolor:{color}",
            "-h", "string:frcolor:#000000",
            "-h", "string:fgcolor:#000000",
            "-i", icon, title, msg
        ], env=ENV)

    def update_main(self, icon, tooltip):
        if self.main_yad.stdin:
            self.main_yad.stdin.write(f"icon:{icon}\n")
            self.main_yad.stdin.write(f"tooltip:{tooltip}\n")
            self.main_yad.stdin.flush()

    def run(self):
        proc = subprocess.Popen(["stdbuf", "-oL", "keyd", "listen"], stdout=subprocess.PIPE, text=True, bufsize=1)
        if proc.stdout:
            for line in proc.stdout:
                l = line.strip()
                if l == "+programmer_mode":
                    self.update_main(ICONS["prog"], "Programmer Mode")
                    self.notify("Keyd", "Programmer ON", COLORS["prog"], ICONS["prog"])
                elif l == "-programmer_mode":
                    self.update_main(ICONS["normal"], "Normal Mode")
                    self.notify("Keyd", "Normal", COLORS["normal"], ICONS["normal"])
                elif l == "+keyd_emacs":
                    if not self.emacs_proc:
                        self.emacs_proc = subprocess.Popen(
                            ["yad", "--notification", "--image", ICONS["emacs"], "--text", "Emacs"], env=ENV
                        )
                        save_pids(self.main_yad, self.emacs_proc)
                    self.notify("Keyd", "Emacs ON", COLORS["emacs"], ICONS["emacs"])
                elif l == "-keyd_emacs":
                    if self.emacs_proc:
                        self.emacs_proc.terminate()
                        self.emacs_proc = None
                        save_pids(self.main_yad)
                    self.notify("Keyd", "Emacs OFF", COLORS["red"], ICONS["normal"])

if __name__ == "__main__":
    kill_own_yad()  # only kills prior run of THIS script
    KeydIndicator().run()
