#!/bin/bash
source $(dirname $0)/functions.sh

# initializing logging
export JOB_LOG="/tmp/ci-local-log/myjob.log"
export JOB_OUT="/tmp/ci-local-out/myjob.out"
export JOB_RPT="/tmp/ci-local-rpt/myjob.rpt"
export JOB_LOGLEVEL="3"
export JOB_IS_LOCAL="1"
bsg_log_init ${JOB_LOG} ${JOB_RPT} ${JOB_OUT} ${JOB_LOGLEVEL} || exit 1

# Check if there are no arguments
if [ "$#" -eq 0 ]; then
    bsg_log_error "no script specified"
    bsg_log_raw "usage: run-local.sh <ci-script.sh>"
    exit 1
fi

bsg_log_info "running ci locally"
bsg_log_raw "with arguments: $*"
bsg_log_info "bsg_top: ${bsg_top}"
bsg_log_info "bsg_ci: ${bsg_ci}"
bsg_log_info "bsg_wrap: ${bsg_wrap}"
bsg_log_info "bsg_script: ${bsg_script}"

bsg_log_info "setting common variables"
export BP_INSTALL_DIR="$(git rev-parse --show-toplevel)/install"

# execute the command
exec "$@"

