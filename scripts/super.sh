#!/bin/bash
set -e
# supervisorctl shortcut
supervisorctl -c config/supervisord.conf $@
