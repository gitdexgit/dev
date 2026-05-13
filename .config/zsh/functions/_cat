
# Kcat - Display clipboard content (like 'cat' command)
# Usage: Kcat
# Shows current clipboard content exactly as it appears
Kcat() {
  local clipboard_content=$(_get_clip)
  
  if [[ -z "$clipboard_content" ]]; then
    echo "No content in clipboard"
    return 1
  fi
  
  echo "$clipboard_content"
}


