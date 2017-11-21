#! /bin/sh

_show_diff() {
  if [ "${1:-''}" = "-h" ];then
    >&2 cat << EOF
$(basename "${0}") diff -- information

This is an abstraction to help show changes within the meta repo
and all of the projects contained within.

Usage:
> $(basename "${0}") diff [-h] [options...]

h)
  Shows this help message
EOF
    exit 0
  fi
  git diff --submodule "$@"
}
