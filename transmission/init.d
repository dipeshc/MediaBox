#!/bin/sh -e
### BEGIN INIT INFO
# Provides:          transmission-daemon
# Required-Start:    $local_fs $remote_fs $network
# Required-Stop:     $local_fs $remote_fs $network
# Default-Start:     2 3 4 5
# Default-Stop:      0 1 6
# Short-Description: Start or stop the transmission-daemon.
### END INIT INFO

NAME=transmission-daemon
DAEMON=/usr/bin/$NAME
USER=root
STOP_TIMEOUT=30

export PATH="${PATH:+$PATH:}/sbin"

[ -x $DAEMON ] || exit 0

[ -e /etc/default/$NAME ] && . /etc/default/$NAME

. /lib/lsb/init-functions

start_daemon () {
    if [ $ENABLE_DAEMON != 1 ]; then
        log_progress_msg "(disabled, see /etc/default/${NAME})"
    else    
        start-stop-daemon --start \
        --chuid $USER \
		$START_STOP_OPTIONS \
        --exec $DAEMON -- $OPTIONS
    fi
}

case "$1" in
    start)
        log_daemon_msg "Starting bittorrent daemon" "$NAME"
        start_daemon
        log_end_msg 0
        ;;
    stop)
        log_daemon_msg "Stopping bittorrent daemon" "$NAME"
        start-stop-daemon --stop --quiet \
            --exec $DAEMON --retry $STOP_TIMEOUT \
            --oknodo
        log_end_msg 0
        ;;
    reload)
        log_daemon_msg "Reloading bittorrent daemon" "$NAME"
        start-stop-daemon --stop --quiet \
            --exec $DAEMON \
            --oknodo --signal 1
        log_end_msg 0
        ;;
    restart|force-reload)
        log_daemon_msg "Restarting bittorrent daemon" "$NAME"
        start-stop-daemon --stop --quiet \
            --exec $DAEMON --retry $STOP_TIMEOUT \
            --oknodo
        start_daemon
        log_end_msg 0
        ;;
    status)
        status_of_proc "$DAEMON" "$NAME" && exit 0 || exit $?
        ;;
    *)
        echo "Usage: /etc/init.d/$NAME {start|stop|reload|force-reload|restart|status}"
        exit 2
        ;;
esac

exit 0

