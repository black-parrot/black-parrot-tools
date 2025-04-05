#!/bin/bash

# get common functions
source $(dirname $0)/common/functions.sh

script_name=$(basename $0)

bsg_log_info "starting $(basename $0)"

# check for binaries in path
bsg_check_var "BP_INSTALL_DIR" || exit 1
bsg_log_info "setting installation directory as ${BP_INSTALL_DIR}"
bsg_run_task "checking for installed binaries" ls ${BP_INSTALL_DIR}/bin
PATH=${BP_INSTALL_DIR}/bin:${PATH}

# do the actual job
bsg_run_task "finding yosys" which yosys
bsg_run_task "getting yosys version" yosys --version
bsg_run_task "getting yosys help" yosys --help

bsg_log_info "finishing $(basename $0)"

