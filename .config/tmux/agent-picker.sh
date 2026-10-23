#!/usr/bin/env bash
# Reporters set pane options @agent_pid (agent PID) and @agent_state
# (working | waiting | ready). Missing or mismatched reports show unknown.
set -o pipefail

render_rows() {
  awk -F '\t' '
    NR == FNR {
      line = $0
      sub(/^ +/, "", line)
      split(line, parts, / +/)
      parent[parts[1]] = parts[2]
      if (parts[3] == "pi") agents[parts[1]] = 1
      next
    }
    function distance(pid, root,    n) {
      n = 0
      while (pid in parent && pid != root) { pid = parent[pid]; n++ }
      return pid == root ? n : -1
    }
    {
      pane = $1; root = $2; best = ""; nearest = 999999
      for (pid in agents) {
        n = distance(pid, root)
        if (n >= 0 && n < nearest) { best = pid; nearest = n }
      }
      pid = best != "" ? best : $7
      if (pid == "" || distance(pid, root) < 0) next
      state = $6
      if ($7 != pid || (state != "working" && state != "waiting" && state != "ready")) state = "unknown"
      label = state == "working" ? "● working" : state == "waiting" ? "! waiting for input" : state == "ready" ? "✓ ready" : "? unknown"
      path = $5; sub(/.*\//, "", path)
      title = $7 == pid && $8 != "" ? $8 : path
      printf "%d\t%s\t%s\t%s\t%s\twindow %s\n", substr(pane, 2), pane, label, title, path, $3
    }
  ' "$1" "$2" | sort -n -k1,1 | cut -f2- | {
    entries=$(cat)
    [[ -z $entries ]] || paste <(printf '%s\n' "$entries" | cut -f1) <(printf '%s\n' "$entries" | cut -f2- | column -t -s $'\t')
  }
}

if [[ ${1:-} == --self-test ]]; then
  processes=$'10 1 -zsh\n20 10 pi\n21 20 pi\n30 1 -zsh\n40 30 pi\n50 1 -zsh\n60 50 codex\n'
  panes=$'%5\t30\t2\tb\t/tmp/b\tready\t999\tOld session\n%2\t10\t1\ta\t/tmp/a\twaiting\t20\n%7\t50\t3\tc\t/tmp/c\tworking\t60\tFix auth bug\n%8\t50\t4\td\t/tmp/d\tready\t999\n'
  actual=$(render_rows <(printf '%s' "$processes") <(printf '%s' "$panes")) || exit 1
  expected=$'%2\t! waiting for input  a             a  window 1\n%5\t? unknown            b             b  window 2\n%7\t● working            Fix auth bug  c  window 3'
  [[ $actual == "$expected" ]] || { printf 'Expected:\n%s\nActual:\n%s\n' "$expected" "$actual" >&2; exit 1; }
  exit
fi

client=${1:-$(tmux display-message -p '#{client_tty}')} || exit 1
session=$(tmux display-message -p '#{session_id}') || exit 1
rows=$(render_rows <(ps -axo pid=,ppid=,comm=) <(tmux list-panes -s -t "$session" -F $'#{pane_id}\t#{pane_pid}\t#{window_index}\t#{window_name}\t#{pane_current_path}\t#{@agent_state}\t#{@agent_pid}\t#{@agent_label}')) || exit 1
if [[ -z $rows ]]; then tmux display-message -c "$client" 'No agents in this session'; exit; fi
# ponytail: tmux menus cannot scroll; restore a popup picker if agents exceed terminal rows.
menu=(-c "$client" -T 'Agents' -x C -y C -M)
while IFS=$'\t' read -r pane label; do
  window=$(tmux display-message -p -t "$pane" '#{window_id}' 2>/dev/null) || continue
  label=${label//\#/##}
  label=${label//%/%%}
  menu+=("$label" '' "select-window -t $window ; select-pane -t $pane")
done <<< "$rows"
(( ${#menu[@]} > 7 )) && tmux display-menu "${menu[@]}"
