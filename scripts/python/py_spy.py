#!/usr/bin/env python3

import tkinter as tk
from Xlib import display, X
from ewmh import EWMH # For _NET_WM_PID

class WindowSpyApp:
    def __init__(self, root):
        self.root = root
        self.root.title("PyWindowSpy")
        self.root.geometry("450x250") # Adjusted size

        self.disp = display.Display()
        self.xroot = self.disp.screen().root
        self.ewmh = EWMH(self.disp, self.xroot)

        self.info_labels = {}
        labels_text = [
            "Mouse X:", "Mouse Y:", "Screen:", "Window ID:",
            "Win Title:", "Win Class:", "Win PID:",
            "Win X:", "Win Y:", "Win Width:", "Win Height:"
        ]

        for i, text in enumerate(labels_text):
            tk.Label(root, text=text, anchor="w").grid(row=i, column=0, sticky="w", padx=5, pady=2)
            self.info_labels[text] = tk.Label(root, text="", anchor="w")
            self.info_labels[text].grid(row=i, column=1, sticky="w", padx=5, pady=2)

        self.root.grid_columnconfigure(1, weight=1) # Make value column expandable

        self.update_info()

    def get_window_attributes(self, window_obj):
        try:
            geom = window_obj.get_geometry()
            return geom.x, geom.y, geom.width, geom.height
        except Exception:
            return "N/A", "N/A", "N/A", "N/A"

    def get_window_pid(self, window_obj):
        try:
            pid = self.ewmh.getWmPid(window_obj)
            if pid is not None:
                return pid
            # Fallback for non-EWMH compliant WMs or if _NET_WM_PID is not set
            atom = self.disp.intern_atom('_NET_WM_PID')
            prop = window_obj.get_full_property(atom, X.AnyPropertyType)
            if prop and prop.value:
                return prop.value[0]
        except Exception:
            pass
        return "N/A"


    def update_info(self):
        try:
            pointer = self.xroot.query_pointer()
            win_id = pointer.child

            self.info_labels["Mouse X:"].config(text=str(pointer.root_x))
            self.info_labels["Mouse Y:"].config(text=str(pointer.root_y))
            
            # Screen info isn't directly available from pointer like xdotool provides.
            # xdotool uses Xinerama or RandR extensions. For simplicity, we'll omit or use placeholder.
            # You could use 'xrandr' or more complex Xlib calls to determine this.
            self.info_labels["Screen:"].config(text="N/A (Use xdotool for this)")


            if win_id and win_id != X.NONE: # X.NONE means no specific child window
                window_obj = self.disp.create_resource_object('window', win_id)
                if window_obj:
                    title = window_obj.get_wm_name() # Standard ICCCM title
                    if not title: # Fallback for _NET_WM_NAME (UTF-8)
                        try:
                            title_prop = window_obj.get_full_property(self.disp.intern_atom('_NET_WM_NAME'), self.disp.intern_atom('UTF8_STRING'))
                            if title_prop:
                                title = title_prop.value.decode('utf-8', 'replace')
                        except Exception:
                            title = None

                    wm_class = window_obj.get_wm_class()
                    pid = self.get_window_pid(window_obj)
                    win_x, win_y, win_w, win_h = self.get_window_attributes(window_obj)

                    self.info_labels["Window ID:"].config(text=hex(win_id))
                    self.info_labels["Win Title:"].config(text=str(title or "N/A"))
                    self.info_labels["Win Class:"].config(text=str(wm_class[1] if wm_class else "N/A")) # class[0] is instance, class[1] is class
                    self.info_labels["Win PID:"].config(text=str(pid))
                    self.info_labels["Win X:"].config(text=str(win_x))
                    self.info_labels["Win Y:"].config(text=str(win_y))
                    self.info_labels["Win Width:"].config(text=str(win_w))
                    self.info_labels["Win Height:"].config(text=str(win_h))
                else:
                    self.clear_window_info()
            else:
                self.clear_window_info()

        except Exception as e:
            # print(f"Error: {e}") # For debugging
            self.info_labels["Win Title:"].config(text="Error fetching info")
            # Clear other fields on error or if no window
            self.clear_window_info(clear_id=False) # Keep mouse info

        self.disp.flush()
        self.root.after(200, self.update_info) # Refresh every 200ms

    def clear_window_info(self, clear_id=True):
        if clear_id:
            self.info_labels["Window ID:"].config(text="N/A")
        self.info_labels["Win Title:"].config(text="N/A (Root or no window)")
        self.info_labels["Win Class:"].config(text="N/A")
        self.info_labels["Win PID:"].config(text="N/A")
        self.info_labels["Win X:"].config(text="N/A")
        self.info_labels["Win Y:"].config(text="N/A")
        self.info_labels["Win Width:"].config(text="N/A")
        self.info_labels["Win Height:"].config(text="N/A")


if __name__ == "__main__":
    main_root = tk.Tk()
    app = WindowSpyApp(main_root)
    main_root.mainloop()
