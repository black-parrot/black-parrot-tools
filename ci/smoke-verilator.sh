#!/bin/bash

# get common functions
source $(dirname $0)/common/functions.sh
bsg_log_info "starting $(basename $0)"

# fail on any error
set -e

# check for binaries in path
bsg_check_var "BP_INSTALL_DIR"
bsg_log_info "setting installation directory as ${BP_INSTALL_DIR}"
bsg_run_task "checking for installed binaries" ls ${BP_INSTALL_DIR}/bin
PATH=${BP_INSTALL_DIR}/bin:${PATH}

# do the actual job
bsg_run_task "finding verilator" which verilator
bsg_run_task "getting verilator version" verilator --version

# pass if no error
bsg_pass $(basename $0)

