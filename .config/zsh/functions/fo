#!/bin/zsh


# Smart "fzf open" function
# - If the selected file is text-based, opens it in Neovim (in a new Kitty window).
# - Otherwise, opens it with the default GUI application (like Dolphin, Gwenview, etc).
fo() {
  # 1. Use 'local' to keep variables from polluting your shell.
  local file
  local mime_type

  # 2. Find a file using fzf.
  file=$(fd --hidden --type file . | fzf --height 60% --reverse)

  # 3. Check if a file was actually selected (the user didn't press Esc).
  if [[ -n "$file" ]]; then
    # 4. THE MAGIC: Use the `file` command to get the MIME type.
    #    --brief hides the filename, --mime-type gives output like "text/plain".
    mime_type=$(file --brief --mime-type "$file")

    # 5. THE DECISION: Check if the MIME type starts with "text/".
    if [[ "$mime_type" == text/* ]]; then
      echo "Opening text file in Neovim: $file"
      # This matches the command from your .desktop file.
      kitty -e nvim "$file"
    else
      echo "Opening with default app: $file"
      # Use xdg-open for non-text files (images, PDFs, videos...).
      # '&> /dev/null' hides any output from the GUI app in your terminal.
      xdg-open "$file" &> /dev/null
    fi
  fi
}

