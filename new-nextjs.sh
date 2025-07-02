#!/usr/bin/env bash
# Usage: ./new-nextjs.sh <project-name>

if [ -z "$1" ]; then
  echo "Usage: $0 <project-name>"
  exit 1
fi

npx create-next-app@latest "$1" --typescript --eslint --tailwind --src-dir --app --import-alias "@/*"
cd "$1"
cp ../.env.local.example .env.local