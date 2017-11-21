#! /bin/sh

_clone_meta() {
  if [ "${1:-''}" = '-h' ];then
  >&2 cat << EOF
$(basename "${0}") clone -- information

This action will clone a meta repo and all of its submodules with it.

Usage:
> $(basename "${0}") clone [-h] <gitpath> [directory]

This work the exact same as git clone but provides the ability to fetch
submodules at the same time.
EOF
    exit 0
  fi
  git clone --recursive "$@"
}
