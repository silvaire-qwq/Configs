#!/usr/bin/env bash

tmpdir=$(dirname "$0")/../tmp/fullscreen-old-workspace

isfullscreen=$(hyprctl activewindow | grep 'fullscreen:' | head -n1 | cut -d' ' -f2)

active=$(hyprctl activewindow | grep pid: | sd '\s*pid: (.*)' '$1')

if [ "$isfullscreen" -eq 1 ]; then
	hyprctl dispatch fullscreen >/dev/null
	if [ -f "$tmpdir/$active" ]; then
		old_workspace=$(cat "$tmpdir/$active")
		hyprctl dispatch movetoworkspace "$old_workspace" >/dev/null
		rm "$tmpdir/$active"
	fi
	exit
fi

current_workspace=$(hyprctl activeworkspace | grep 'workspace ID' | head -n1 | sd 'workspace ID .* \((.*)\).*' '$1')
workspaces=$(hyprctl clients | grep workspace: | awk '{print $2}' | grep -v '\-1')

echo "$current_workspace" >"$tmpdir/$active"

count=0

for workspace in $workspaces; do
	if [ "$workspace" -eq "$current_workspace" ]; then
		count=$((count + 1))
	fi
done

if [ $count -gt 1 ]; then
	for i in $(seq 1 10); do
		if ! echo "$workspaces" | grep -w -q "$i"; then
			hyprctl dispatch movetoworkspace "$i" >/dev/null
			hyprctl dispatch fullscreen >/dev/null
			exit
		fi
	done
fi

hyprctl dispatch fullscreen >/dev/null
