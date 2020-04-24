#!/bin/bash
# Deploy our Django app to the target server.
set -e
export SERVER=64.225.23.131
./scripts/upload-code.sh
./scripts/upload-code.sh
