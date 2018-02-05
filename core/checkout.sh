#! /bin/sh

_info_checkout() {
  cat << EOF
This will allow to switch / create meta branches within the meta repo.
EOF
}

_core_check_checkout() {
  if [ "${1:-''}" = '-h' ];then
    >&2 cat << EOF
$(basename "${0}") checkout -- Information

This will allow you to checkout meta repo branches and ensure all
the submodules are at the correct commit hash.

Usage:
> $(basename "${0}") checkout args...

This action is a wrapper for the standard 'git checkout' so you can use
your normal git checkout commands.

Example:
> $(basename "${0}") checkout -b "feature/awesome-meta-branch"
EOF
    exit 0
  fi
  git checkout --quiet "$@"
  git submodule update --init --checkout
}
