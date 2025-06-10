#!/bin/bash
source $(dirname $0)/functions.sh

# do the actual job
bsg_run_task "finding yosys" which yosys
bsg_sentinel_fail "which: no"
bsg_run_task "getting yosys version" yosys --version
bsg_run_task "getting yosys help" yosys --help

# pass if no error
bsg_pass $(basename $0)

