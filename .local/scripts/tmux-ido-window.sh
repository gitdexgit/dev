#!/usr/bin/env bash
# ~/.local/scripts/tmux-ido-window.sh

mapfile -t raw < <(tmux list-windows -F '#{window_last_flag}:#{window_index}:#{window_name}')
first=""; rest_windows=()
for l in "${raw[@]}"; do
  [[ ${l%%:*} == 1 ]] && first="${l#*:}" || rest_windows+=("${l#*:}")
done
order=()
[[ -n $first ]] && order+=("$first")
order+=("${rest_windows[@]}")

query=""
sel=0
matches=()

BLUE=$'\033[1;38;2;150;166;200m'    # #96a6c8
YELLOW=$'\033[1;38;2;255;221;51m'   # #ffdd33
ORANGE=$'\033[1;38;2;204;140;60m'   # #cc8c3c
RESET=$'\033[0m'
SAVE=$'\033[s'
LOAD=$'\033[u'

draw() {
  matches=()
  for w in "${order[@]}"; do
    [[ -z $query || ${w,,} == *"${query,,}"* ]] && matches+=("$w")
  done
  (( sel >= ${#matches[@]} )) && sel=0
  (( sel < 0 )) && sel=$(( ${#matches[@]} - 1 ))

  local body="" color="$YELLOW"
  (( ${#matches[@]} == 1 )) && color="$ORANGE"

  for i in "${!matches[@]}"; do
    if (( i == sel )); then
      body+="${color}${matches[$i]}${RESET}"
    else
      body+="${matches[$i]}"
    fi
    (( i < ${#matches[@]} - 1 )) && body+=" | "
  done

  printf '\r\033[K%sBuffer: %s%s%s{%s}' "$BLUE" "$RESET" "$query" "$SAVE" "$body" > /dev/tty
  printf '%s' "$LOAD" > /dev/tty
}

draw
while IFS= read -rsn1 key < /dev/tty; do
  case "$key" in
    $'\x1b')
      read -rsn2 -t 0.01 rest < /dev/tty
      case "$rest" in
        '[C') (( sel++ )) ;;
        '[D') (( sel-- )) ;;
        *) exit 1 ;;
      esac
      ;;
    $'\x07') exit 1 ;;
    $'\x7f') query="${query%?}"; sel=0 ;;
    $'\x0e') ((sel++)) ;;
    $'\x10') ((sel--)) ;;
    '')
      echo "${matches[$sel]}"
      break
      ;;
    *) query+="$key"; sel=0 ;;
  esac
  draw
done
