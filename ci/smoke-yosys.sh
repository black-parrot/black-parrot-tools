#!/bin/bash
source $(dirname $0)/functions.sh

# do the actual job
bsg_run_task "yosys_find" "finding yosys" which yosys
bsg_sentinel_fail "which: no"
bsg_run_task "yosys_version" "getting yosys version" yosys --version

# pass if no error
bsg_pass $(basename $0)

