#!/usr/bin/env sh
set -eu

message="${1:-chore: update project}"
branch="$(git branch --show-current 2>/dev/null || true)"

if [ -z "$branch" ]; then
  branch="main"
fi

git add -A

if git diff --cached --quiet; then
  printf '%s\n' 'No staged changes to commit.'
else
  git commit -m "$message"
fi

git push -u origin "$branch"
