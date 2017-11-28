#! /bin/sh

_info_pull() {
  cat << EOF
Pull all remote changes for projects and apply them locally.
EOF
}

_core_check_pull() {
    if [ "${1:-''}" = "-h" ];then
      >&2 cat << EOF
"$(basename "${0}")" pull -- Information

Usage:
> "$(basename "${0}")" pull [-h]
This will pull all remote changes to the projects and apply them locally.

Note:
The default branch used to fetch from is master, if you need to change this
please see "$(basename "${0}")" set -h

EOF
      exit 0
    fi
  >&2 echo "[INFO] Fetching latest changes for this branch"
  git pull
  # This will get all the updates from remote and checkout those changes
  >&2 echo "[INFO] Fetching latest changes in submodules"
  git submodule init
  git submodule update --recursive --remote -j 10 "$@"
}
