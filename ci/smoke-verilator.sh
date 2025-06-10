#!/bin/bash
source $(dirname $0)/functions.sh

# do the actual job
bsg_run_task "finding verilator" which verilator
bsg_sentinel_fail "which: no"
bsg_run_task "getting verilator version" verilator --version

# pass if no error
bsg_pass $(basename $0)

