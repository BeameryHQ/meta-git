#! /bin/sh

_pull_changes() {
    if [ ${1:-''} = "-h" ];then
      >&2 cat << EOF
`basename $0` pull -- Information

Usage:
> `basename $0` pull [-h]
This will pull all remote changes to the projects and apply them locally.

Note:
The default branch used to fetch from is master, if you need to change this
please see `basename $0` set -h
EOF
      exit 0
    fi
  # This will get all the updates from remote and checkout those changes
  git submodule init
  git submodule update --recursive --remote $@
}
