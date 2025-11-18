# --- Internal Helper for checking input ---
_cp_preflight() {
  if [ -z "$2" ]; then
    echo "Usage: $1 <path>"
    return 1
  fi
  if [ ! -e "$2" ]; then
    echo "Error: '$2' does not exist."
    return 1
  fi
}

# 1. cpA: Copy Absolute path
cpA() {
  _cp_preflight "cpA" "$1" || return 1
  local abs_path=$(realpath "$1")
  echo -n "$abs_path" | xclip -selection clipboard
  echo "Copied Absolute path: $abs_path"
}

# 2. cpR: Copy path Relative to CWD
cpR() {
  _cp_preflight "cpR" "$1" || return 1
  local rel_path=$(realpath --relative-to=. "$1")
  echo -n "$rel_path" | xclip -selection clipboard
  echo "Copied Relative path: $rel_path"
}

# 3. cpH: Copy path relative to HOME
cpH() {
  _cp_preflight "cpH" "$1" || return 1
  local abs_path=$(realpath "$1")
  local home_rel_path="${abs_path/#$HOME/\~}"
  echo -n "$home_rel_path" | xclip -selection clipboard
  echo "Copied Home-relative path: $home_rel_path"
}

# 4. cpF: Copy Filename (full name)
cpF() {
  _cp_preflight "cpF" "$1" || return 1
  local filename=$(basename "$1")
  echo -n "$filename" | xclip -selection clipboard
  echo "Copied Filename: $filename"
}

# 5. cpB: Copy Bare/Basename of filename (no extension)
cpB() {
  _cp_preflight "cpB" "$1" || return 1
  local filename=$(basename "$1")
  local bare_name="${filename%.*}"
  echo -n "$bare_name" | xclip -selection clipboard
  echo "Copied Bare name (no extension): $bare_name"
}

# 6. cpE: Copy Extension of filename
cpE() {
  _cp_preflight "cpE" "$1" || return 1
  local filename=$(basename "$1")
  if [[ "$filename" == *.* ]]; then
    local extension="${filename##*.}"
    echo -n "$extension" | xclip -selection clipboard
    echo "Copied Extension: $extension"
  else
    echo "File has no extension."
    return 1
  fi
}

# And the one for CONTENT
# 7. cpC: Copy file Content
cpC() {
  _cp_preflight "cpC" "$1" || return 1
  if [ ! -f "$1" ]; then
    echo "Error: '$1' is not a regular file. Cannot copy content."
    return 1
  fi
  cat "$1" | xclip -selection clipboard
  echo "Copied Content of: $1"
}


# cpQ : copy the Nth item from CopyQ (using 1-based counting). Usage: cpc 2  (to copy the 2nd item)
cpQ() {
  if [[ -z "$1" ]]; then
    echo "Usage: cpc <position>"
    return 1
  fi
  # Subtract 1 from the input to get the correct zero-based index
  copyq select $(($1 - 1))
}


