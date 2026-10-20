#!/usr/bin/env bash
set -euo pipefail

CACHE_DIR="$HOME/.cache/cliphist-thumbs"
mkdir -p "$CACHE_DIR"

cliphist list | while IFS=$'\t' read -r id rest; do
    case "$rest" in
        "[[ binary data "*"]]")
            ext=$(printf '%s' "$rest" | grep -oE 'png|jpe?g|bmp|gif' | head -1)
            dims=$(printf '%s' "$rest" | grep -oE '[0-9]+x[0-9]+')
            thumb="$CACHE_DIR/${id}.${ext:-png}"
            if [[ ! -s "$thumb" ]]; then
                printf '%s\t\n' "$id" | cliphist decode > "$thumb" 2>/dev/null || rm -f "$thumb"
            fi
            printf '%s\t Imagem %s\x00icon\x1f%s\n' "$id" "$dims" "$thumb"
            ;;
        *)
            printf '%s\t%s\n' "$id" "$rest"
            ;;
    esac
done | rofi -dmenu -show-icons -display-columns 2 -theme-str 'element-icon { size: 1.3em; }' | cliphist decode | wl-copy

