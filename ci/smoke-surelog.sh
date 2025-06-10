#!/bin/bash
source $(dirname $0)/functions.sh

# do the actual job
bsg_run_task "finding uhdm-dump" which uhdm-dump
bsg_sentinel_fail "which: no"
bsg_run_task "getting uhdm-dump version" uhdm-dump --version

# pass if no error
bsg_pass $(basename $0)

