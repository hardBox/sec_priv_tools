#!/bin/sh
### BEGIN INIT INFO
# Provides:          hostname
# Required-Start:
# Required-Stop:
# Should-Start:      glibc
# Default-Start:     S
# Default-Stop:
# Short-Description: Sets a random hostname
# Description:       Read /usr/share/dict/words, pick a random word
#                    and update the kernel value with this value.
#                    If /etc/hostname is empty, it is created.
#                    The old hostname in /etc/hosts is also replaced
#                    If everything fails, the value 'localhost' is used.
### END INIT INFO
# INSTALLING:
# sudo cp hostname.sh /etc/init.d/hostname.sh
# sudo chmod u+x /etc/init.d/hostname.sh
# sudo update-rc.d hostname.sh start 02 S .
# install other script
# reboot & pray
# WRITTEN BY Someone, May 2010


PATH=/sbin:/bin

. /lib/init/vars.sh
. /lib/lsb/init-functions

do_start () {
	# either current name or /etc/hostname (/etc/hostname shouldn't be missing)
	[ -f /etc/hostname ] && OLD_HOSTNAME="$(cat /etc/hostname)"

	# Keep current name if /etc/hostname is missing.
	[ -z "$OLD_HOSTNAME" ] && OLD_HOSTNAME="$(hostname)"

	# below we pick a random word and filter it for special chars (and make sure we still have string)
	# could be approached cleaner (ie rejecting a word with special chars instead of filtering,
	# but that'd give us fewer pretty names to pick from!)
	HOSTNAME=`cat /usr/share/dict/words |/usr/bin/perl -e '@w=<>;$g="";while($_!~/\A[a-z]+\Z/i){@good=$w[int rand $#w]=~/([a-z]+)/ig;$_=join("",@good);}print'`

	#default to localhost (we do not want to use a previously stored value)
	[ -z "$HOSTNAME" ] && HOSTNAME=localhost

	log_action_begin_msg	"$HOSTNAME is now the new hostname :-)"
	[ "$VERBOSE" != no ] && log_action_begin_msg "Setting hostname to '$HOSTNAME'"
	hostname "$HOSTNAME"
	ES=$?
	[ "$VERBOSE" != no ] && log_action_end_msg $ES
	exit $ES
}

case "$1" in
  start|"")
	do_start
	;;
  restart|reload|force-reload)
	echo "Error: argument '$1' not supported" >&2
	exit 3
	;;
  stop)
	# No-op
	;;
  *)
	echo "Usage: hostname.sh [start|stop]" >&2
	exit 3
	;;
esac
