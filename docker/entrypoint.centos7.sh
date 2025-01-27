#!/bin/bash
echo "Activating python venv"
source /opt/venv/bin/activate
echo "Activating devtoolset-11"
source scl_source enable devtoolset-11
exec "$@"
