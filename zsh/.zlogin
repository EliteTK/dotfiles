eval $(/usr/bin/gnome-keyring-daemon --start --components=pkcs11,secrets,ssh)
export SSH_AUTH_SOCK

if [ "$TTY" = "/dev/tty1" ]; then
	startx
fi
