#!/usr/bin/env bash
#
# generate.sh — build TextReplacements.plist from words.txt.
#
# Drag the resulting TextReplacements.plist into:
#   System Settings > Keyboard > Text Replacements
# and the words sync to your iPhone/iPad via iCloud.
#
# Each canonical term in words.txt becomes the phrase; the shortcut is derived
# by lowercasing it and stripping non-alphanumerics (e.g. "CI/CD" -> "cicd").
# So typing the lowercase letters autocorrects to the proper casing.
#
set -euo pipefail

DIR="$(cd "$(dirname "${BASH_SOURCE[0]}")" && pwd)"
SRC="$DIR/words.txt"
OUT="$DIR/TextReplacements.plist"

{
  echo '<?xml version="1.0" encoding="UTF-8"?>'
  echo '<!DOCTYPE plist PUBLIC "-//Apple//DTD PLIST 1.0//EN" "http://www.apple.com/DTDs/PropertyList-1.0.dtd">'
  echo '<plist version="1.0">'
  echo '<array>'
  grep -v '^[[:space:]]*#' "$SRC" | sed '/^[[:space:]]*$/d' | while IFS= read -r phrase; do
    phrase="${phrase#"${phrase%%[![:space:]]*}"}"; phrase="${phrase%"${phrase##*[![:space:]]}"}"   # trim
    shortcut="$(printf '%s' "$phrase" | tr '[:upper:]' '[:lower:]' | tr -cd '[:alnum:]')"
    printf '  <dict><key>phrase</key><string>%s</string><key>shortcut</key><string>%s</string></dict>\n' "$phrase" "$shortcut"
  done
  echo '</array>'
  echo '</plist>'
} > "$OUT"

plutil -lint "$OUT" >/dev/null && echo "Wrote $OUT ($(grep -c '<dict>' "$OUT") entries)"
