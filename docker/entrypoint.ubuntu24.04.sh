#!/bin/bash
echo "Activating python venv"
source /opt/venv/bin/activate
exec "$@"
