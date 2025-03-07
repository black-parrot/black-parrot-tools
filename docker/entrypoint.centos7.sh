#!/bin/bash
echo "Activating python venv"
source /opt/venv/bin/activate
echo "Activating devtoolset-11"
source scl_source enable devtoolset-11
echo "Activating git218"
source scl_source enable rh-git218

exec "$@"
