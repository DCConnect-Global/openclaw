#!/bin/sh

# Remap node user to match host UID if OPENCLAW_UID is set
if [ -n "$OPENCLAW_UID" ] && [ "$OPENCLAW_UID" != "$(id -u node)" ]; then
  # The following automatically changes ownership in /home/node
  usermod -u "$OPENCLAW_UID" node
  groupmod -g "${OPENCLAW_GID:-$OPENCLAW_UID}" node
  chown -R node:node /app/{extensions /app/skills}
else
  # In event that UID does not change, make sure of .openclaw ownership
  chown -R node:node /home/node/.openclaw
fi

exec gosu node "$@"
