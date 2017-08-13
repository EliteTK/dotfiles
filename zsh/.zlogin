eval $(/usr/bin/gnome-keyring-daemon --start --components=pkcs11,secrets,ssh)
export SSH_AUTH_SOCK

if [ -z "$DBUS_SESSION_BUS_ADDRESS" ]; then
	eval $(dbus-launch --sh-syntax)
fi

if [ "$TTY" = "/dev/tty1" ]; then
	startx
fi
