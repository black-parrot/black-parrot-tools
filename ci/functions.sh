#!/bin/bash

# source-only guard
[[ "${BASH_SOURCE[0]}" == "${0}" ]] && return
# include guard
[ -n "${_LOCAL_SH_INCLUDE}" ] && return

# disable automatic export
set -o allexport

# constants
readonly _LOCAL_SH_INCLUDE=1

# check for binaries in path
bsg_check_var "BP_INSTALL_DIR"
bsg_log_info "setting installation directory as ${BP_INSTALL_DIR}"
PATH=${BP_INSTALL_DIR}/bin:${PATH}

# disable automatic export
set +o allexport

