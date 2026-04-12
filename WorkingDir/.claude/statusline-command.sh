#!/bin/bash

# --- Customize these characters ---
FILLED_CHAR=$'█'   # Full block █  (change to e.g. "#", "=", "▓")
EMPTY_CHAR="░"          # Space       (change to e.g. "-", "░", "·")
# ----------------------------------

input=$(cat)
model=$(echo "$input" | jq -r '.model.display_name // "Unknown Model"')
used=$(echo "$input" | jq -r '.context_window.used_percentage // empty')

if [ -n "$used" ]; then
  used_int=$(printf '%.0f' "$used")
  filled=$(( used_int / 5 ))
  empty_blocks=$(( 20 - filled ))
  bar=""
  for i in $(seq 1 $filled); do bar="${bar}${FILLED_CHAR}"; done
  for i in $(seq 1 $empty_blocks); do bar="${bar}${EMPTY_CHAR}"; done
  printf "\033[0;36m%s\033[0m [%s] %d%% used" "$model" "$bar" "$used_int"
else
  empty_bar=$(printf "%0.s${EMPTY_CHAR}" {1..20})
  printf "\033[0;36m%s\033[0m [%s] --%% used" "$model" "$empty_bar"
fi
