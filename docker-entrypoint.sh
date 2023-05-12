#!/bin/sh
# Start truffle develop in detached mode
truffle develop --log &
# Run the rest of the commands
exec "$@"