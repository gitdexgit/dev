#!/bin/bash
# This script prompts for a title and prints a text block,
# reliably placing the cursor on a new empty line in the middle.

# 1. Get the title from the user
if command -v zenity &> /dev/null;
  then title=$(zenity --entry --title="Comment Header" --text="Enter the header title:")
else
  read -p "Header title: " title < /dev/tty
fi

# # 2. If the user cancelled, exit.
# if [ -z "$title" ]; then
#   exit 0
# fi

# 3. Construct the parts of our text block
header_line="# --[]-- [ $title ] ----"
end_line="# END--[]--- [ $title ] END----"

# 4. THE CORRECTED PRINTF STATEMENT
# This format is less ambiguous and more robust.
printf "%s\n\n$|$\n\n%s" "$header_line" "$end_line"
