#! /bin/sh

_install() {
  # Being sneaky, like the ninja, as to how we 'install' this
  # As (AFAIK) bash and zsh do not like to exec softlink as part
  # of the shell, we are going to handle that indirection for the shell;
  # this is so we can update this script without having the user update
  # each time.

  DRIVER_DIRECTORY=$(echo "$(cd "$(dirname "$0")"; pwd)")
  DRIVER_LOCATION=$(echo "$(cd "$(dirname "$0")"; pwd)/$(basename "$0")")

  cat << EOF > /tmp/meta-helper
#! /bin/sh

# ==================== NOTE ====================
# This is not the file you are looking for
# please see ${DRIVER_DIRECTORY}
# ==============================================

case \${1:-''} in
  uninstall)
      sudo rm -iv \$0
      if [ ! -f \$0 ];then
        >&2 echo "[INFO] Sorry to see you go"
      fi
      exit 0
      ;;
  # The update script is here as you should only need this command
  # outside of the actual repo, inside the repo, a user can use git.
  update)
      git -C ${DRIVER_DIRECTORY} fetch --quiet --no-recurse-submodules
      if [ "\`git -C ${DRIVER_DIRECTORY} rev-parse HEAD\`" != "\`git -C ${DRIVER_DIRECTORY} rev-parse @{u}\`" ];then
        git -C ${DRIVER_DIRECTORY} pull --quiet
        >&2 echo "[INFO] We have now update `basename $0`"
      fi
      exit 0
      ;;
esac

# Check to see if meta helper repo has moved
# as defer all interactions to the main script there.
if [ ! -f "${DRIVER_LOCATION}" ];then
  >&2 echo "[ERROR] It appears that meta-helper script has moved, please reinstall"
  exit -1
fi

${DRIVER_LOCATION} \$@
EOF
  chmod a+x /tmp/meta-helper
  >&2 echo "[INFO] Need permission to install the application"
  sudo mv /tmp/meta-helper /usr/local/bin/meta-helper
}
