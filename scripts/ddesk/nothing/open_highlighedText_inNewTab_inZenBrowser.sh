#!/bin/bash

# read the highlighted text
selected_txt=$(xclip -o -selection primary)

# clear white space
URL=$(echo -n "$selected_txt" | sed -e 's/^[[:space:]]*//;s/[[:space:]]*$//' -e '/^$/d')


# check if URL is not empty, if not then run zen-browser --new-tab
# make sure you have zen browser open.
if [[ -n "$URL" ]]; then

    zen-browser --new-tab "$URL"

else

    notify-send "URL Opener" "No text was selected." -i "dialog-warning"

fi

