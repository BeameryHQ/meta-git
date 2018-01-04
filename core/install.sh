#! /bin/sh
_info_install() {
  cat << EOF
Installs a driver for $(basename "${0}") on the local system for global shell use.
EOF
}

_core_install() {
  if [ "${1:-''}" = '-h' ];then
    >&2 cat << EOT
$(basename "${0}") install -- Information

This will install $(basename "${0}") on your local machine to
make it accessible globally.
Note:
-   This needs to be run as root.
EOT
    exit 0
  fi
  if [ "$(whoami)" != "root" ];then
    >&2 echo "[ERROR] Installer requires root privilages"
    exit -1
  fi
  # Being sneaky, like the ninja, as to how we 'install' this
  # As (AFAIK) bash and zsh do not like to exec softlink as part
  # of the shell, we are going to handle that indirection for the shell;
  # this is so we can update this script without having the user update
  # each time.
  TMPD="$(mktemp -d)"
  DRIVER_DIRECTORY="$(cd "$(dirname "$0")" && pwd -P || exit -1)"
  DRIVER_LOCATION="${DRIVER_DIRECTORY}/$(basename "$0")"

  cat << EOF > "$TMPD/$(basename "${0}")"
#! /bin/sh

# ==================== NOTE ====================
# This is not the file you are looking for
# please see ${DRIVER_DIRECTORY}
# ==============================================

case "\${1:-''}" in
  uninstall)
      sudo rm -iv "\$0"
      if [ ! -f "\$0" ];then
        >&2 echo "[INFO] Sorry to see you go"
      fi
      exit 0
      ;;
  # The update script is here as you should only need this command
  # outside of the actual repo, inside the repo, a user can use git.
  update)
      git -C "${DRIVER_DIRECTORY}" fetch --quiet --no-recurse-submodules
      if [ "\$(git -C ${DRIVER_DIRECTORY} rev-parse HEAD)" != "\$(git -C ${DRIVER_DIRECTORY} rev-parse @{u})" ];then
        git -C "${DRIVER_DIRECTORY}" pull
        "${DRIVER_LOCATION}" install
        >&2 echo "[INFO] We have now update $(basename "${0}")"
      fi
      exit 0
      ;;
  location)
      echo "${DRIVER_DIRECTORY}"
      exit 0
      ;;
esac

# Check to see if meta helper repo has moved
# as defer all interactions to the main script there.
if [ ! -x "${DRIVER_LOCATION}" ];then
  >&2 echo "[ERROR] It appears that $(basename "${0}") script has moved "
  >&2 echo "[ERROR] please reinstall and make sure it is executable"
  exit -1
fi

"${DRIVER_LOCATION}" "\$@"
EOF
  chmod a+x "${TMPD}/$(basename "${0}")"
  mv "${TMPD}/$(basename "${0}")" /usr/local/bin/"$(basename "${0}")"
  rmdir "${TMPD}"
  >&2 echo "[INFO] successfully installed"
}
