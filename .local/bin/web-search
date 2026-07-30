#!/bin/bash

# 1. Define ENGINES
declare -A engines
engines=(
    ["srx"]="http://localhost:8888/search?q=|SearXNG (Local)"
    ["so"]="https://stackoverflow.com/search?q=|StackOverflow"
    ["gh"]="https://github.com/search?q=|GitHub"
    ["aw"]="https://wiki.archlinux.org/index.php?search=|Arch Wiki"
    ["mdn"]="https://developer.mozilla.org/en-US/search?q=|MDN Docs"
    ["chat"]="https://chatgpt.com/?q=|ChatGPT"
    ["claude"]="https://claude.ai/new?q=|Claude AI"
    ["pplx"]="https://www.perplexity.ai/search?q=|Perplexity AI"
    ["gem"]="https://gemini.google.com/app?q=|Gemini AI"
    ["gs"]="https://aistudio.google.com/prompts/new_chat?model=gemini-3-flash-preview&q=|Gemini Studio"
    ["nbk"]="https://notebooklm.google.com/|NotebookLM"
    ["edb"]="https://www.exploit-db.com/search?q=|ExploitDB"
    ["cve"]="https://www.cvedetails.com/google-search-results.php?q=|CVE Details"
    ["nvd"]="https://nvd.nist.gov/vuln/search/results?query=|NVD Database"
    ["pkt"]="https://packetstormsecurity.com/search/?q=|Packet Storm"
    ["owasp"]="https://owasp.org/www-community/SearchResults?q=|OWASP"
    ["shodan"]="https://www.shodan.io/search?query=|Shodan"
    ["0day"]="https://0day.today/search?search=|0day.today"
    ["pkg"]="https://repology.org/projects/?search=|Linux Packages"
    ["pypi"]="https://pypi.org/search/?q=|Python Packages (PyPI)"
    ["npm"]="https://www.npmjs.com/search?q=|NPM Packages"
    ["crates"]="https://crates.io/search?q=|Rust Crates"
    ["goog"]="https://www.google.com/search?q=|Google"
    ["duck"]="https://duckduckgo.com/?q=|DuckDuckGo"
    ["reddit"]="https://www.reddit.com/search/?q=|Reddit"
    ["yt"]="https://www.youtube.com/results?search_query=|YouTube"
    ["yth"]="https://www.youtube.com/feed/history|YouTube History"
    ["w"]="https://en.wikipedia.org/wiki/Special:Search?search=|Wikipedia"
    ["dc"]="https://discord.com/channels/@me|Discord"
    ["url"]="|Direct URL Entry"
    ["td"]="https://www.tldraw.com|tldraw (Whiteboard)"
    ["ed"]="https://excalidraw.com/|Excalidraw (Whiteboard)"
    ["gdg"]="https://github.com/gitdexgit|gitdexgit (My Profile)"
    ["gn"]="https://github.com/notifications|GitHub Notifications"
    ["gdr"]="https://github.com/gitdexgit?tab=repositories|My Repositories"
    ["gds"]="https://github.com/gitdexgit?tab=repositories&q=|Search My Repos"
    ["gist"]="https://gist.github.com/search?q=|GitHub Gist Search"
    ["hn"]="https://hn.algolia.com/?q=|Hacker News"
    ["dev"]="https://dev.to/search?q=|Dev.to"
    ["g4g"]="https://www.geeksforgeeks.org/search/?q=|GeeksforGeeks"
    ["leet"]="https://leetcode.com/problemset/?search=|LeetCode"
    ["rosetta"]="https://rosettacode.org/mw/index.php?search=|Rosetta Code"
    ["py"]="https://docs.python.org/3/search.html?q=|Python Docs"
    ["rs"]="https://docs.rs/releases/search?query=|Rust Docs"
)

# Preserved order as requested
engine_order=("srx" "so" "gh" "aw" "mdn" "chat" "claude" "pplx" "gem" "gs" "nbk" "edb" "cve" "nvd" "pkt" "owasp" "shodan" "0day" "pkg" "pypi" "npm" "crates" "goog" "duck" "reddit" "yt" "yth" "w" "dc" "url" "td" "ed" "gdg" "gn" "gdr" "gds" "gist" "hn" "dev" "g4g" "leet" "rosetta" "py" "rs")

BROWSER="${1:-xdg-open}"
NEW_WINDOW="${2:-false}"

urlencode() {
    python3 -c "import sys, urllib.parse; print(urllib.parse.quote(sys.argv[1]))" "$1"
}

open_url() {
    local url="$1"
    case "$BROWSER" in
        vimb) vimb "$url" >/dev/null 2>&1 & ;;
        surf-raw) surf "$url" >/dev/null 2>&1 & ;;
        surf)
            existing_xid=$(xprop -root _NET_CLIENT_LIST | grep -o '0x[0-9a-f]*' | while read id; do
                xprop -id "$id" WM_CLASS 2>/dev/null | grep -q "tabbed" && echo "$id" && break
            done)
            if [ -n "$existing_xid" ]; then
                surf -e "$existing_xid" "$url" >/dev/null 2>&1 &
            else
                xid=$(tabbed -cdn "surf-tabbed" 2>/dev/null)
                surf -e "$xid" "$url" >/dev/null 2>&1 &
            fi
            ;;
        *)
            if [[ "$NEW_WINDOW" == "true" ]]; then
                firefox --new-window "$url" >/dev/null 2>&1 &
            else
                xdg-open "$url" >/dev/null 2>&1 &
            fi
            ;;
    esac
}

show_engine_menu() {
    local query="$1"
    local list=""
    for key in "${engine_order[@]}"; do
        list+="$key: $(echo "${engines[$key]}" | cut -d'|' -f2)\n"
    done
    echo -e "$list" | rofi -dmenu -p "Search '$query' via:" -l 20 | cut -d':' -f1
}

# 2. Generate suggestion list with requested priority
SUGGESTIONS="n — Open in New Window\n"
SUGGESTIONS+="s — Use Surf Browser\n"
SUGGESTIONS+="sr — Use Raw Surf Browser\n"
SUGGESTIONS+="v — Use Vimb Browser\n"
SUGGESTIONS+="--- (Pick Engine Manually)\n"
SUGGESTIONS+="-- (Pick Engine Manually)\n"
SUGGESTIONS+="---\n"
for key in "${engine_order[@]}"; do
    DESC=$(echo "${engines[$key]}" | cut -d'|' -f2)
    SUGGESTIONS+="$key — $DESC\n"
done

# 3. Customize prompt
PROMPT_TEXT="🚀 Search / URL / Prefix:"
[[ "$BROWSER" == "surf" ]] && PROMPT_TEXT="🏄 [SURF-TAB] Search:"
[[ "$BROWSER" == "surf-raw" ]] && PROMPT_TEXT="🏄 [SURF-RAW] Search:"
[[ "$BROWSER" == "vimb" ]] && PROMPT_TEXT="⚡ [VIMB] Search:"
[[ "$NEW_WINDOW" == "true" ]] && PROMPT_TEXT="🪟 [NEW] Search:"

# 4. Get User Input
USER_INPUT=$(echo -e "$SUGGESTIONS" | rofi -dmenu -p "$PROMPT_TEXT" -i -theme-str 'window {width: 45%; border: 2px; border-color: #5e81ac;} listview {lines: 12;}')
[ -z "$USER_INPUT" ] && exit 0

# 5. Handle Manual Skips (--- or --)
if [[ "$USER_INPUT" == "---"* || "$USER_INPUT" == "-- "* ]]; then
    QUERY=$(echo "$USER_INPUT" | sed 's/^---\s*//;s/^--\s*//;s/^(Pick Engine Manually)//')
    [[ -z "$QUERY" ]] && QUERY=$(rofi -dmenu -p "Enter search query:" -l 0)
    [[ -z "$QUERY" ]] && exit 0

    CHOICE=$(show_engine_menu "$QUERY")
    [[ -z "$CHOICE" ]] && exit 0

    URL_BASE=$(echo "${engines[$CHOICE]}" | cut -d'|' -f1)
    if [[ "$URL_BASE" == *"=" ]] || [[ "$URL_BASE" == *"search"* ]]; then
        open_url "$URL_BASE$(urlencode "$QUERY")"
    else
        open_url "$URL_BASE"
    fi
    exit 0
fi

# 6. Handle Browser switches (Explicit Selection)
case "$USER_INPUT" in
    "n — Open in New Window") exec "$0" "xdg-open" "true" ;;
    "s — Use Surf Browser") exec "$0" "surf" ;;
    "sr — Use Raw Surf Browser") exec "$0" "surf-raw" ;;
    "v — Use Vimb Browser") exec "$0" "vimb" ;;
esac

# 7. Parse browser prefix with content (typing "n query", "s query", etc)
FIRST_WORD=$(echo "$USER_INPUT" | awk '{print $1}')
REST_OF_INPUT=$(echo "$USER_INPUT" | cut -d' ' -f2- -s)

if [[ "$FIRST_WORD" =~ ^(s|sr|v|n)$ ]]; then
    [[ "$FIRST_WORD" == "s" ]] && BROWSER="surf"
    [[ "$FIRST_WORD" == "sr" ]] && BROWSER="surf-raw"
    [[ "$FIRST_WORD" == "v" ]] && BROWSER="vimb"
    [[ "$FIRST_WORD" == "n" ]] && NEW_WINDOW="true"

    if [[ -z "$REST_OF_INPUT" ]]; then
        exec "$0" "$BROWSER" "$NEW_WINDOW"
    else
        USER_INPUT="$REST_OF_INPUT"
    fi
fi

# 8. Logic: Selection from list
if [[ "$USER_INPUT" == *" — "* ]]; then
    KEY=$(echo "$USER_INPUT" | awk '{print $1}')
    DATA="${engines[$KEY]}"
    URL=$(echo "$DATA" | cut -d'|' -f1)
    DESC=$(echo "$DATA" | cut -d'|' -f2)

    if [[ "$URL" == *"=" ]] || [[ "$URL" == *"search"* ]]; then
        QUERY=$(rofi -dmenu -p "Search $DESC:" -l 0)
        [[ -n "$QUERY" ]] && open_url "$URL$(urlencode "$QUERY")"
    else
        open_url "$URL"
    fi
    exit 0
fi

# 9. Logic: Prefix with query (e.g. "gh my-repo")
PREFIX=$(echo "$USER_INPUT" | awk '{print $1}')
QUERY=$(echo "$USER_INPUT" | cut -d' ' -f2- -s)

if [[ -n "${engines[$PREFIX]}" ]]; then
    URL=$(echo "${engines[$PREFIX]}" | cut -d'|' -f1)
    if [[ -z "$QUERY" ]]; then
        if [[ "$URL" == *"=" ]] || [[ "$URL" == *"search"* ]]; then
             QUERY=$(rofi -dmenu -p "Search:" -l 0)
             [[ -n "$QUERY" ]] && open_url "$URL$(urlencode "$QUERY")"
        else
             open_url "$URL"
        fi
    else
        open_url "$URL$(urlencode "$QUERY")"
    fi
    exit 0
fi

# 10. Logic: Direct URL
if [[ "$USER_INPUT" =~ ^(https?://)?[a-zA-Z0-9.-]+\.[a-zA-Z]{2,}(/.*)?$ && ! "$USER_INPUT" == *" "* ]]; then
    [[ ! "$USER_INPUT" =~ ^https?:// ]] && USER_INPUT="https://$USER_INPUT"
    open_url "$USER_INPUT"
    exit 0
fi

# 11. Fallback: Show engine menu
CHOICE=$(show_engine_menu "$USER_INPUT")
[[ -z "$CHOICE" ]] && exit 0
URL_BASE=$(echo "${engines[$CHOICE]}" | cut -d'|' -f1)
open_url "$URL_BASE$(urlencode "$USER_INPUT")"
