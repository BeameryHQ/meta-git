#! /bin/sh

_view_submodules() {
  # Some really terrible printfs
  # Don't read this code.... It will be bad for your health
  printf "%-30s\t%-10s\t%-10s\t%-10s\n" "Project" "Short Hash" "Branch" "Uncommited changes?"
  git -C ${1:-'.'} submodule foreach --quiet \
    'printf "%-30s\t%-10s\t%-10s\t%-10s\n" `basename \$(pwd)` `git rev-parse --short HEAD` `git rev-parse --abbrev-ref HEAD` `git diff-index --quiet HEAD -- && echo "No" || echo "Yes"`'
}
