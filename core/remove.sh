#! /bin/sh

_info_remove() {
  cat << EOF
This will remove a submodule from the meta repo.
EOF
}

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
    # Need to programaticlly delete the lines from the file
    # This is some rather shite code but lets explain
    # In order to delete the corect submodule from .gitmodules
    # We need to figure out where the line starts and where it ends
    # once we have reached another submodule definition then we can stop.
    START=-1
    COUNT=0
    grep --colour=never -n -T -A 4 "\[submodule\s*\"${module}\"\]" .gitmodules | tr '[\-:]' ' ' | while read number tail; do
        if [ ${START} -eq -1 ];then
            START=${number}
            COUNT=${number}
            continue
        fi
        if [ ! -z "$(echo ${tail} | grep -E "submodule")" ];then
            sed -i "${START},${COUNT}d" .gitmodules
            break
        fi
        COUNT=$((COUNT + 1))
    done
    git submodule deinit --force --"${module}"
    git rm --cached "${module}"
    rm -rf ".git/modules/${module}"
  done
}
