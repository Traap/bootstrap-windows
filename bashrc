#!/bin/bash
# {{{ Directory location to clone git repositories.

export GIT_HOME=/c/Users/${USERNAME}/git

# -------------------------------------------------------------------------- }}}
# A {{{ check for the existence of a directory.

dirExists() {
  [[ -d "$1" ]]
}

# -------------------------------------------------------------------------- }}}
# {{{ Validate GIT_HOME

if [[ ! dirExists ]]; then
  echo "WARNING: ${GIT_HOME} does not exist."
  AUTODOCPATH=""
fi

# -------------------------------------------------------------------------- }}}
# {{{ spath displays each path part on a separate line.

spath() {
  echo $PATH | sed -n 1'p' | tr ':' '\n' | while read word; do
    echo $word
  done
}

# -------------------------------------------------------------------------- }}}
