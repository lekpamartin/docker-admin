#!/bin/sh

CWD='.'

. $CWD/docker-admin.conf

if [ $# == 0 ]; then
	$DAEMON ps -a
	exit $?
fi
 
while true ; do
	case "$1" in
		a|start) 
			$DAEMON ps
			exit $?;;
		o|stop)
                        $DAEMON ps -a | grep -v "Up "
                        exit $?;;
		*)
			echo -e "\n[ERROR] Unknown option '$1'.\n"
			#usage
			exit 2;;
	esac
done
