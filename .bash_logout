#!/bin/bash

# kill running ssh agent
if [ -n "$SSH_AUTH_SOCK" ]; then
	if command -v keychain &> /dev/null; then
		eval "$(keychain --quiet -k mine)"
	fi
fi

# when leaving the console, clear the screen to increase privacy
if [ "$SHLVL" = 1 ]; then
	[ -x /usr/bin/clear_console ] && /usr/bin/clear_console -q
fi
