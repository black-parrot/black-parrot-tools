#!/bin/bash
source $(dirname $0)/functions.sh

# do the actual job
bsg_run_task "find_verilator" "finding verilator" which verilator
bsg_sentinel_fail "which: no"
bsg_run_task "verilator_version" "getting verilator version" verilator --version

# pass if no error
bsg_pass $(basename $0)

