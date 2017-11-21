#! /bin/sh

_set_project_config() {
  BRANCH='master'
  while getopts ":hb:" option; do
    case $option in
      h)
        >&2 cat << EOF
"$(basename "${0}")" set -- information

Usage:
"$(basename "${0}")" set [-h] [-b remote_branch_name] projects...

h)
  Displays this help message
b)
  Requires an argument that is the remote branch
  This will branch will be applied to the meta repo
  and will use that track changes instead of 'master'.

Notes:
- If project doesn't exist inside the current directory,
  it will report an error then stop.
- The order that set will preference branches is:
    - remote
    - local
  if the branch isn't created, it will create it and push it to origin.
EOF
        ;;
      b)
        BRANCH="${OPTARG}"
        ;;
      \?)
        >&2 echo "[ERROR] Unknown option found ${OPTARG}"
        >&2 echo "[INFO] please see \"$(basename "${0}") set -h\" for usage"
        exit 1
        ;;
      esac
  done
  shift $(( OPTIND - 1 ))
  for project in "$@"; do
    if [ ! -d "${project}" ];then
      >&2 echo "[ERROR] No valid directory listed -- ${project}"
      exit -1
    fi
    if   [ ! -z "$(git -C "${project}" show-branch remotes/origin/"${BRANCH}" 2>/dev/null || true)" ];then
      >&2 echo "[INFO] Found ${BRANCH} listed on remote, using that"
      git -C "${project}" checkout origin/"${BRANCH}"
    elif [ ! -z "$(git -C "${project}" rev-parse --verify "${BRANCH}" 2>/dev/null || true)" ];then
      >&2 echo "[INFO] Found ${BRANCH} locally, using that"
      git -C "${project}" checkout "${BRANCH}"
    else
      >&2 echo "[INFO] ${BRANCH} not found, creating and pushing..."
      git -C "${project}" checkout -b "${BRANCH}"
      git -C "${project}" push --set-upstream origin "${BRANCH}"
    fi
    git submodule add -b "${BRANCH}" "${project}"
    git config -f .gitmodules submodule."${project}".branch "${BRANCH}"
  done
  >&2 echo "[INFO] Make sure you fetch any recent updates before continuing"
}
