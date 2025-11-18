#!/bin/bash

PROFILE_NAME="$1"
OPENBOX_CONFIG_DIR="$HOME/.config/openbox"
PROFILES_DIR="$OPENBOX_CONFIG_DIR/profiles"
TARGET_RC_XML="$OPENBOX_CONFIG_DIR/rc.xml"

SOURCE_RC_XML=""

if [[ "$PROFILE_NAME" == "main" ]]; then
    SOURCE_RC_XML="$PROFILES_DIR/rc.xml.main"
elif [[ "$PROFILE_NAME" == "default" ]]; then
    SOURCE_RC_XML="$PROFILES_DIR/rc.xml.default"
else
    echo "Usage: $0 [main|default]"
    # Optional: send a notification
    notify-send "Openbox Switcher" "Error: Invalid profile name. Use 'main' or 'default'." -u critical
    exit 1
fi

if [[ ! -f "$SOURCE_RC_XML" ]]; then
    echo "Error: Source profile '$SOURCE_RC_XML' not found!"
    notify-send "Openbox Switcher" "Error: Profile file $SOURCE_RC_XML not found!" -u critical
    exit 1
fi

echo "Switching to Openbox profile: $PROFILE_NAME"
cp "$SOURCE_RC_XML" "$TARGET_RC_XML"

if [[ $? -eq 0 ]]; then
    echo "Successfully copied $SOURCE_RC_XML to $TARGET_RC_XML"
    echo "Reconfiguring Openbox..."
    openbox --reconfigure
    notify-send "Openbox Switcher" "Switched to '$PROFILE_NAME' profile and reconfigured." -u normal
    echo "Done."
else
    echo "Error: Failed to copy $SOURCE_RC_XML to $TARGET_RC_XML"
    notify-send "Openbox Switcher" "Error: Failed to switch profile." -u critical
fi

exit 0
