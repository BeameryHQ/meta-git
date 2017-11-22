#! /bin/sh

# Start of the abstracted functionality
_core_check_add() {
  if [ "${1:-''}" = "-h" ];then
    >&2 cat << EOF
$(basename "${0}") add -- information
This will add a new repo to be managed by the meta repo.

Usage:
> $(basename "${0}") add [-h] <gitrepo>

h)
  Will show this help message

Note:
- The branch to track will be master.
- Any repo that is added has to be accessible by all staff using
  the meta-repo otherwise it will become unusable for those that don't.
EOF
    exit 0
  fi
  # Enforce that we track the master branch by default
  git submodule add -b master "$*"
}
