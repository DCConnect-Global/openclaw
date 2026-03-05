#!/bin/sh
chown -R node:node /home/node/.openclaw
exec gosu node "$@"
