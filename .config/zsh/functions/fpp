#!/bin/zsh

fpp() {
  # Tool check remains the same
  local missing_tools=()
  command -v exa &>/dev/null || missing_tools+=('exa')
  command -v bat &>/dev/null || missing_tools+=('bat')
  command -v timg &>/dev/null || missing_tools+=('timg')
  command -v pdftotext &>/dev/null || missing_tools+=('poppler')
  command -v mediainfo &>/dev/null || missing_tools+=('mediainfo')
  if ((${#missing_tools[@]} > 0)); then
    echo "Missing tools: ${missing_tools[*]}" >&2
    return 1
  fi

  fd --hidden . | fzf --height 80% --layout=reverse --border \
    --preview-window 'right:50%:wrap' \
    --bind '?:toggle-preview' \
    --preview 'sh -c "
      file_path=\"\$1\"
      width=\$(( \$(tput cols 2>/dev/null || echo 80) / 2 ))
      height=\$(( \$(tput lines 2>/dev/null || echo 25) * 7 / 10 ))
      img_width=\$(( width - 2 ))
      img_height=\$(( height - 4 ))
      [ \$img_height -lt 10 ] && img_height=10
      [ \$img_width -lt 20 ] && img_width=20

      # Terminal capability detection
      if [[ \"$TERM\" == \"xterm-kitty\"* ]] && command -v kitty &>/dev/null; then
        # Kitty terminal with graphics support
        printf \"\033[2J\033_Ga=d\033\\\\\"
        if [ -d \"\$file_path\" ]; then
          exa --tree --color=always \"\$file_path\" | head -200
        else
          mime_type=\$(file --brief --mime-type \"\$file_path\")
          case \"\$mime_type\" in
            image/*)
              echo \"File: \$file_path\"; file \"\$file_path\"; echo \"---\"
              kitty +kitten icat --transfer-mode=memory --stdin=no \
                --place=\${img_width}x\${img_height}@0x3 \"\$file_path\" 2>/dev/null
              ;;
            *) bat --color=always --style=numbers --line-range=:200 \"\$file_path\" || file \"\$file_path\" ;;
          esac
        fi
      elif [[ \"$TERM\" == \"xterm-ghostty\"* ]] || [[ \"$TERM\" == \"alacritty\"* ]]; then
        # Ghostty or Alacritty - use timg with different flags
        printf \"\033[2J\"
        if [ -d \"\$file_path\" ]; then
          exa --tree --color=always \"\$file_path\" | head -200
        else
          mime_type=\$(file --brief --mime-type \"\$file_path\")
          case \"\$mime_type\" in
            image/*)
              echo \"File: \$file_path\"; file \"\$file_path\"; echo \"---\"
              if [[ \"$TERM\" == \"alacritty\"* ]]; then
                # Special flags for Alacritty
                timg -p --center -g \${img_width}x\${img_height} \"\$file_path\" 2>/dev/null || \
                  echo \"Preview unavailable.\"; file \"\$file_path\"
              else
                # Ghostty
                timg -pk --center -g \${img_width}x\${img_height} \"\$file_path\" 2>/dev/null || \
                  echo \"Preview unavailable.\"; file \"\$file_path\"
              fi
              ;;
            *) bat --color=always --style=numbers --line-range=:200 \"\$file_path\" || file \"\$file_path\" ;;
          esac
        fi
      else
        # Fallback for other terminals
        printf \"\033[2J\"
        if [ -d \"\$file_path\" ]; then
          exa --tree --color=always \"\$file_path\" | head -200
        else
          mime_type=\$(file --brief --mime-type \"\$file_path\")
          case \"\$mime_type\" in
            image/*)
              echo \"File: \$file_path\"; file \"\$file_path\"; echo \"---\"
              timg -p --center -g \${img_width}x\${img_height} \"\$file_path\" 2>/dev/null || \
                echo \"Preview unavailable.\"; file \"\$file_path\"
              ;;
            *) bat --color=always --style=numbers --line-range=:200 \"\$file_path\" || file \"\$file_path\" ;;
          esac
        fi
      fi
    " sh {}'
}
