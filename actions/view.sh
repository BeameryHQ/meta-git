#! /bin/sh

_view_submodules() {
  if [ "${1:-''}" = '-h' ];then
    >&2 cat << EOF
"$(basename "${0}")" view -- Information

This action will show the current state of a meta repo's submodules.

Usage:
> "$(basename "${0}")" view [-h] [path]
h)
  Prints the help message
path
  The local file path to the meta repo

EOF
  exit 0
  fi
  # Some really terrible printfs
  # Don't read this code.... It will be bad for your health
  printf "%-30s\t%-10s\t%-10s\t%-10s\n" "Project" "Short Hash" "Branch" "Uncommited changes?"
  git -C "${1:-'.'}" submodule foreach --quiet \
    'printf "%-30s\t%-10s\t%-10s\t%-10s\n" `basename \$(pwd)` `git rev-parse --short HEAD` `git rev-parse --abbrev-ref HEAD` `git diff-index --quiet HEAD -- && echo "No" || echo "Yes"`'
}
