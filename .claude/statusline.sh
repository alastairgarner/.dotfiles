#!/bin/bash
input=$(cat)
eval "$(printf '%s' "$input" | jq -r '@sh "dir=\(.workspace.current_dir) session=\(.session_id // "none")"')"

# 5s TTL cache (dir / timestamp / branch), invalidated when the cwd changes.
cache="${TMPDIR:-/tmp}/statusline-git-$session"
now=$(date +%s)
{ read -r c_dir; read -r c_time; read -r branch; } 2>/dev/null <"$cache"
if [ "$c_dir" != "$dir" ] || [ $((now - ${c_time:-0})) -ge 5 ]; then
  branch=$(git -C "$dir" branch --show-current 2>/dev/null)
  printf '%s\n%s\n%s\n' "$dir" "$now" "$branch" >"$cache"
fi

printf '%s' "$input" | jq -r --arg branch "$branch" '
  def bar($p): (($p/10)|floor) as $f | (("█"*$f)//"") + (("░"*(10-$f))//"");
  (.context_window.used_percentage // 0 | floor) as $p |
  [ (.workspace.current_dir | sub("^\($ENV.HOME)"; "~")),
    (if $branch == "" then empty else $branch end),
    .model.display_name,
    "\(bar($p)) \($p)%"
  ] | join("  ")'
