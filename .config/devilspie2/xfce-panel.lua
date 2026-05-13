-- First, check if the window is the XFCE panel (using the correct class case)
if (get_window_class() == "Xfce4-panel") then
    set_window_below(true);
end
