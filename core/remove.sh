#! /bin/sh

_core_check_remove() {
  if [ "${1:-''}" = "-h" ];then
    >&2 cat << EOF
"$(basename "${0}")" remove -- information

This will remove managed submodules from meta repo.

Usage:
> "$(basename "${0}")" remove [-h] path...

Note:
This will remove the submodule from git but will leave the folder
unchanged on your local directory.
EOF
    exit 0
  fi

  for module in "$@"; do
    if [ ! -d "${module}" ];then
      >&2 echo "[ERROR] The submodule does not appear in the local file directory"
      >&2 echo "[ERROR] The removal of ${module} would need to be done by hand"
      exit -1
    fi
    git submodule deinit --force "${module}"
    git rm --cached "${module}"
    rm -rf .git/modules/"${module}"
  done
}
