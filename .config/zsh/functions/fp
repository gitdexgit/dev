#!/bin/zsh


fp() {
  # This part is unchanged
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

  # This is the fzf command with the modified preview script
  fd --hidden . | fzf --height 80% --layout=reverse --border \
    --preview-window 'right:50%:wrap' \
    --bind '?:toggle-preview' \
    --preview 'sh -c "
      # --- START OF DEBUG MODIFICATIONS ---
      DEBUG_LOG=\"/tmp/fzf_debug.log\"
      echo \"--- New Preview Run ---\" >> \"\$DEBUG_LOG\"
      echo \"File: \$1\" >> \"\$DEBUG_LOG\"
      echo \"TERM variable is: [\$TERM]\" >> \"\$DEBUG_LOG\"
      # --- END OF DEBUG MODIFICATIONS ---

      printf \"\033[2J\"
      
      file_path=\"\$1\"
      width=\$(( \$(tput cols 2>/dev/null || echo 80) / 2 ))
      height=\$(( \$(tput lines 2>/dev/null || echo 25) * 7 / 10 ))

      is_graphics_term=false
      if [[ \"\$TERM\" == \"xterm-kitty\" || \"\$TERM\" == \"xterm-ghostty\" ]]; then
        is_graphics_term=true
      fi

      # --- MORE DEBUGGING ---
      echo \"is_graphics_term evaluated to: [\$is_graphics_term]\" >> \"\$DEBUG_LOG\"

      if [ \"\$is_graphics_term\" = true ]; then
        echo \"ATTEMPTING to run clear command.\" >> \"\$DEBUG_LOG\"
        printf \"\033_Ga=d\033\\\\\"
      else
        echo \"SKIPPING clear command.\" >> \"\$DEBUG_LOG\"
      fi

      # The rest of the script is the same
      if [ -d \"\$file_path\" ]; then
        exa --tree --color=always \"\$file_path\" | head -200
      else
        mime_type=\$(file --brief --mime-type \"\$file_path\")
        case \"\$mime_type\" in
          image/*)
            # This part is unchanged...
            img_width=\$(( width - 2 ))
            img_height=\$(( height - 4 ))
            [ \$img_height -lt 10 ] && img_height=10
            [ \$img_width -lt 20 ] && img_width=20
            echo \"File: \$file_path\"; file \"\$file_path\"; echo \"---\"
            if [ \"\$is_graphics_term\" = true ] && command -v kitty &>/dev/null; then
              kitty +kitten icat --transfer-mode=memory --stdin=no \
                --place=\${img_width}x\${img_height}@0x3 \"\$file_path\" 2>/dev/null
            elif timg -pk --center -g \${img_width}x\${img_height} \"\$file_path\" 2>/dev/null; then
              :
            else
              echo \"Preview unavailable.\"; file \"\$file_path\"; identify \"\$file_path\" 2>/dev/null || true
            fi
            ;;
          *) # Simplified the rest for clarity, it does not affect the image part
            bat --color=always --style=numbers --line-range=:200 \"\$file_path\" || file \"\$file_path\"
            ;;
        esac
      fi
    " sh {}'
}

