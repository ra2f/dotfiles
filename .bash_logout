#!/bin/bash

# Terminate the SSH agent if it is running
if [ -n "$SSH_AGENT_PID" ]; then
    kill "$SSH_AGENT_PID" 2>/dev/null || echo "Failed to terminate SSH agent"
fi

# Clear the screen when leaving the console to increase privacy
if [ "$SHLVL" = 1 ]; then
    [ -x /usr/bin/clear_console ] && /usr/bin/clear_console -q
fi
