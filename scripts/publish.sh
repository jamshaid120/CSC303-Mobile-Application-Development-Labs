#!/usr/bin/env bash
# Optional helper: run from repository root with GitHub remote URL.
# Requires a new empty GitHub repository and configured SSH/HTTPS authentication.
set -euo pipefail
if [ "$#" -ne 1 ]; then
  echo "Usage: bash scripts/publish.sh git@github.com:OWNER/REPO.git" >&2
  exit 2
fi
remote_url="$1"
case "$remote_url" in
  git@github.com:*|https://github.com/*) ;;
  *) echo 'Expected a github.com SSH or HTTPS repository URL.' >&2; exit 2 ;;
esac
if [ ! -f README.md ] || [ ! -d labs ] || [ ! -d downloads ]; then
  echo 'Run from the extracted repository root, not inside scripts/.' >&2
  exit 2
fi
if [ ! -d .git ]; then
  git init -b main
fi
current_branch=$(git branch --show-current)
if [ "$current_branch" != "main" ]; then
  echo "Current branch is $current_branch; expected main. Review before pushing." >&2
  exit 3
fi
if git remote get-url origin >/dev/null 2>&1; then
  existing=$(git remote get-url origin)
  if [ "$existing" != "$remote_url" ]; then
    echo "Existing origin $existing differs from requested $remote_url; not changing it." >&2
    exit 3
  fi
else
  git remote add origin "$remote_url"
fi

echo 'Files to be published:'
git status --short | head -60
printf '
Press Enter to stage and commit these files, or Ctrl+C to cancel: '
read -r _
git add .
if ! git diff --cached --quiet; then
  git commit -m 'docs: publish CSC303 Flutter labs and manual'
fi
# Do not force-push or rewrite an existing remote history.
git push -u origin main
