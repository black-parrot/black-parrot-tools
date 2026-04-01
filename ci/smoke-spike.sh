#!/bin/bash
source $(dirname $0)/functions.sh

# do the actual job
bsg_run_task "find_spike" "finding spike" which spike
bsg_sentinel_fail "which: no"
bsg_run_task "spike_help" "getting spike version" spike --help

# pass if no error
bsg_pass $(basename $0)

