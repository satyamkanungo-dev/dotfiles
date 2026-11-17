#!/usr/bin/env bash
# create-session.sh - show existing sessions (names only), then ask for a new session name.
# Duplicate names are rejected and you are asked again. Empty input cancels.
#
#   bind -N "Create session" C display-popup -d "#{pane_current_path}" -E "bash ~/.config/tmux/create-session.sh"

current=$(tmux display-message -p '#S')

printf '\033[1mExisting sessions\033[0m\n\n'
tmux list-sessions -F '#{session_name}' | while IFS= read -r s; do
  if [ "$s" = "$current" ]; then
    printf '  \033[1;34m▾ %s\033[0m \033[2m(current)\033[0m\n' "$s"
  else
    printf '  \033[34m▾ %s\033[0m\n' "$s"
  fi
done
printf '\n'

while true; do
  read -r -p "New session name (empty to cancel): " name
  [ -z "$name" ] && exit 0

  clean=${name//[.:]/_} # tmux turns "." and ":" into "_" anyway
  if [ "$clean" != "$name" ]; then
    printf '\033[2m  "." and ":" are not allowed, using "%s"\033[0m\n' "$clean"
    name=$clean
  fi

  if tmux has-session -t "=$name" 2>/dev/null; then
    printf '\033[31m  Session "%s" already exists. Choose a different name.\033[0m\n\n' "$name"
    continue
  fi
  break
done

tmux new-session -d -s "$name" -c "$PWD" || {
  read -r -p "Failed to create session (press Enter)" _
  exit 1
}
tmux switch-client -t "=$name"
