#!/usr/bin/env bash
set -euo pipefail

if [[ $# -ne 1 || ! -d $1 ]]; then
  echo "Usage: $0 DIRECTORY" >&2
  exit 1
fi

command -v strfile >/dev/null || {
  echo "Error: strfile is not installed." >&2
  exit 1
}

cd -- "$1"
shopt -s nullglob dotglob

for file in ./*.dat; do
  [[ -f "$file" ]] || continue
  rm -- "$file"
done

for file in ./*; do
  [[ -f "$file" ]] || continue
  strfile "$file" "$file.dat"
done
