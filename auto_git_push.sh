#!/bin/bash

# 📍 Get current directory (where script is run from)
DIR="$(cd "$(dirname "$0")" && pwd)"

# 🔁 Change into that directory
cd "$DIR" || exit 1

# 🕒 Create a timestamp
TIMESTAMP=$(date +"%Y-%m-%d %H:%M:%S")

# ✋ Only commit if there are changes
if [[ -n $(git status --porcelain) ]]; then
  git add .
  git commit -m "Auto-commit at $TIMESTAMP"
fi

# 🧠 Temporarily stash any changes (including untracked files)
git stash push -m "cron-temp" --include-untracked

# 🔄 Pull with rebase safely from 'main' branch
git pull --rebase origin main

# ♻️ Restore stash (may fail if nothing was stashed — ignore the error)
git stash pop || true

# ⬆️ Push changes to 'main' branch
git push origin main
