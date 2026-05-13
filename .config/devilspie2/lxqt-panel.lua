-- Final, working rule for the LXQt panel

if (get_window_class() == "lxqt-panel") then
    set_window_below(true);
end
