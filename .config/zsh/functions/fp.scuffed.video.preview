#!/bin/zsh

fp.scuffed.video.preview() {
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
    --preview 'sh -c "
      file_path=\"\$1\"
      width=\$(( \$(tput cols 2>/dev/null || echo 80) / 2 - 2 ))
      height=\$(( \$(tput lines 2>/dev/null || echo 25) / 2 ))

      if [ -d \"\$file_path\" ]; then
        exa --tree --color=always \"\$file_path\" | head -200
      else
        mime_type=\$(file --brief --mime-type \"\$file_path\")
        case \"\$mime_type\" in
          image/*)
            echo \"📷 \$(basename \"\$file_path\")\"
            echo \"\"
            if [ \"\$TERM\" = \"xterm-kitty\" ]; then
              timg -pk --compress=0 -g \${width}x\${height} --center \"\$file_path\" 2>/dev/null
            else
              timg -ps -g \${width}x\${height} --center \"\$file_path\" 2>/dev/null
            fi
            ;;
          video/*)
            echo \"🎬 \$(basename \"\$file_path\")\"
            echo \"\"
            echo \"\"
            echo \"\"
            
            if command -v ffmpeg &>/dev/null; then
              temp_dir=\"/tmp/fpp_frames_\$\$\"
              mkdir -p \"\$temp_dir\"
              
              # Extract frames quickly
              for i in 1 2 3 4 5; do
                time_point=\$((i * 2))
                frame_file=\"\$temp_dir/frame_\${i}.jpg\"
                ffmpeg -ss \$time_point -i \"\$file_path\" -vframes 1 -q:v 2 -s 800x600 -preset ultrafast -y \"\$frame_file\" 2>/dev/null &
              done
              wait
              
              # Position cursor for stationary animation
              echo \"\"
              
              # Loop slideshow
              while true; do
                for i in 1 2 3 4 5; do
                  frame_file=\"\$temp_dir/frame_\${i}.jpg\"
                  if [ -f \"\$frame_file\" ]; then
                    
                    # Move cursor back to image position
                    printf \"\\033[10A\"
                    
                    if [ \"\$TERM\" = \"xterm-kitty\" ]; then
                      timg -pk --compress=0 -g \${width}x\${height} --center \"\$frame_file\" 2>/dev/null
                    else
                      timg -ps -g \${width}x\${height} --center \"\$frame_file\" 2>/dev/null
                    fi
                    
                    sleep 0.6
                  fi
                done
              done &
              
              # Clean up after 30 seconds
              sleep 30
              kill \$! 2>/dev/null
              rm -rf \"\$temp_dir\" 2>/dev/null
            else
              echo \"Video preview unavailable\"
            fi
            ;;
          application/pdf)
            echo \"📄 \$(basename \"\$file_path\")\"
            echo \"---\"
            pdftotext \"\$file_path\" - 2>/dev/null | head -30 || echo \"PDF preview failed\"
            ;;
          audio/*)
            echo \"🎵 \$(basename \"\$file_path\")\"
            echo \"---\"
            mediainfo --Inform=\"General;Duration: %Duration/String%\\nBitrate: %BitRate/String%\\nFormat: %Format%\" \"\$file_path\" 2>/dev/null || \
            echo \"Audio info unavailable\"
            ;;
          text/*)
            bat --color=always --style=numbers --line-range=:30 \"\$file_path\" 2>/dev/null || \
            cat \"\$file_path\" | head -30
            ;;
          *)
            file \"\$file_path\"
            ;;
        esac
      fi
    " sh {}'
}
