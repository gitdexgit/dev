#!/usr/bin/env python

import gi
gi.require_version('Gtk', '3.0')
from gi.repository import Gtk, Gdk
import cairo
import Xlib
import Xlib.display
import subprocess

class HintWindow(Gtk.Window):
    def __init__(self, windows):
        super().__init__(type=Gtk.WindowType.POPUP)
        self.windows = windows
        self.hint_chars = "sadfjklewcmpgh"
        self.hints = {}
        self.input_sequence = ""

        self.set_decorated(False)
        self.set_app_paintable(True)
        self.set_visual(self.get_screen().get_rgba_visual())
        self.set_keep_above(True)

        self.connect("map-event", self._on_map)
        self.connect("draw", self.on_draw)
        self.connect("key-press-event", self.on_key_press)
        self.connect("destroy", Gtk.main_quit)

        self.generate_hints()
        self.show_all()
        self.grab_focus()

    def _on_map(self, widget, event):
        display = Gdk.Display.get_default()
        monitor = display.get_monitor_at_window(self.get_window())
        geometry = monitor.get_geometry()
        self.resize(geometry.width, geometry.height)
        self.move(geometry.x, geometry.y)

        seat = Gdk.Display.get_default().get_default_seat()
        seat.grab(self.get_window(), Gdk.SeatCapabilities.KEYBOARD, True, None, None, None)

    def generate_hints(self):
        # --- FINAL FIX: New logic for unlimited, unique hints ---
        num_chars = len(self.hint_chars)
        for i, (win_id, geo) in enumerate(self.windows.items()):
            if i < num_chars:
                # Single-character hint
                hint_str = self.hint_chars[i]
            else:
                # Two-character hint
                num = i - num_chars
                first_char = self.hint_chars[num // num_chars]
                second_char = self.hint_chars[num % num_chars]
                hint_str = first_char + second_char
            self.hints[hint_str] = win_id

    def on_draw(self, widget, cr):
        cr.set_source_rgba(0, 0, 0, 0)
        cr.set_operator(cairo.OPERATOR_CLEAR)
        cr.paint()
        cr.set_operator(cairo.OPERATOR_OVER)

        for hint_str, win_id in self.hints.items():
            geo = self.windows[win_id]
            
            cr.select_font_face("monospace", cairo.FONT_SLANT_NORMAL, cairo.FONT_WEIGHT_BOLD)
            cr.set_font_size(24)

            extents = cr.text_extents(hint_str.upper())
            box_width = extents.width + 12
            box_height = extents.height + 8
            box_x = geo['x'] + 8
            box_y = geo['y'] + 8

            cr.set_source_rgba(0.1, 0.1, 0.1, 0.85)
            cr.rectangle(box_x, box_y, box_width, box_height)
            cr.fill()

            cr.set_source_rgb(1, 0.9, 0.2)
            cr.move_to(box_x + 6, box_y + extents.height + 2)
            cr.show_text(hint_str.upper())

    def on_key_press(self, widget, event):
        keyval_name = Gdk.keyval_name(event.keyval)
        if keyval_name == "Escape":
            self.destroy()
        elif keyval_name in self.hint_chars:
            self.input_sequence += keyval_name
            
            # Check for a direct match first
            if self.input_sequence in self.hints:
                win_id = self.hints[self.input_sequence]
                subprocess.run(["wmctrl", "-i", "-a", str(win_id)])
                self.destroy()
                return

            # If no direct match, check if it's a valid prefix for longer hints
            if not any(h.startswith(self.input_sequence) for h in self.hints):
                self.destroy()

def get_windows():
    disp = Xlib.display.Display()
    root = disp.screen().root
    windows = {}

    stacking_list_atom = disp.intern_atom('_NET_CLIENT_LIST_STACKING')
    current_desktop_atom = disp.intern_atom('_NET_CURRENT_DESKTOP')
    window_desktop_atom = disp.intern_atom('_NET_WM_DESKTOP')

    current_desktop_prop = root.get_full_property(current_desktop_atom, Xlib.X.AnyPropertyType)
    if not current_desktop_prop: return {} # Exit if desktop properties not found
    current_desktop = current_desktop_prop.value[0]
    
    window_ids_prop = root.get_full_property(stacking_list_atom, Xlib.X.AnyPropertyType)
    if not window_ids_prop: return {}
    window_ids = window_ids_prop.value

    for win_id in reversed(window_ids):
        try:
            win = disp.create_resource_object('window', win_id)
            win_desktop_prop = win.get_full_property(window_desktop_atom, Xlib.X.AnyPropertyType)
            if win_desktop_prop is None: continue
            win_desktop = win_desktop_prop.value[0]

            if win_desktop == current_desktop or win_desktop == 0xFFFFFFFF:
                attrs = win.get_attributes()
                geo = win.get_geometry()

                if attrs.map_state == Xlib.X.IsViewable and geo.width > 50 and geo.height > 50:
                    parent = win
                    x, y = 0, 0
                    while parent.id != root.id:
                        g = parent.get_geometry()
                        x += g.x
                        y += g.y
                        parent = parent.query_tree().parent
                    windows[win_id] = {'x': x, 'y': y}
        except (Xlib.error.BadWindow, AttributeError):
            continue
    return windows

if __name__ == "__main__":
    windows = get_windows()
    if windows:
        win = HintWindow(windows)
        Gtk.main()
