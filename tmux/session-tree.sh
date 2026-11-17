#!/usr/bin/env bash
# session-tree.sh - pick a tmux session or window from a tree view.
#
# Bind it in ~/.tmux.conf:
#   bind -N "Session tree" f display-popup -E -w 80% -h 80% "~/.tmux/session-tree.sh"
#
# Note: tmux replaces tab characters in -F output with "_", so "|" is used
# as the field separator instead.

current=$(tmux display-message -p '#S')

selection=$(
  tmux list-windows -a -F '#{session_name}|#{window_index}|#{window_active}|#{window_panes}|#{window_name}' |
    awk -F'|' -v cur="$current" '
    {
      sn = $1
      if (!(sn in seen)) { seen[sn] = 1; order[++ns] = sn }
      c = ++n[sn]
      idx[sn, c] = $2; act[sn, c] = $3; panes[sn, c] = $4
      # window name = everything after the 4th "|" (name may contain "|")
      nm = $0
      for (k = 0; k < 4; k++) nm = substr(nm, index(nm, "|") + 1)
      name[sn, c] = nm
    }
    END {
      for (s = 1; s <= ns; s++) {
        sn = order[s]
        tag = (sn == cur) ? " (current)" : ""
        # field 1 = hidden target, field 2 = displayed text
        printf "=%s|\033[1;34m▾ %s\033[0m\033[2m%s\033[0m\n", sn, sn, tag
        for (i = 1; i <= n[sn]; i++) {
          branch = (i == n[sn]) ? "└─" : "├─"
          mark = (act[sn, i] == 1) ? " \033[32m*\033[0m" : ""
          p = panes[sn, i]
          pinfo = (p > 1) ? " \033[2m[" p " panes]\033[0m" : ""
          printf "=%s:%s|  \033[2m%s\033[0m \033[33m%s: %s\033[0m%s%s\n", \
                 sn, idx[sn, i], branch, idx[sn, i], name[sn, i], mark, pinfo
        }
      }
    }
  ' |
    fzf --ansi --reverse --delimiter='|' --with-nth=2.. --prompt='sessions> ' |
    cut -d'|' -f1
)

[ -n "$selection" ] && tmux switch-client -t "$selection"
