#!/bin/sh

CWD='/data/repo/lekpamartin/docker-admin'

. $CWD/docker-admin.conf

usage () {
	echo -e "\n\tc|create : Create a volume \
		\n\ti|inspect : Display detailed information on one or more volumes \
		\n\tp|prune : Remove unused volumes \
		\n\tr|rm : Remove one or more volumes"
}

if [ $# == 0 ]; then
	$DAEMON volume ls
	exit $?
fi
 
while true ; do
	case "$1" in
		c|create)
                        $DAEMON volume create $2 $3
                        exit $?;;
		i|inspect)
                        $DAEMON volume inspect $2
                        exit $?;;
		p|prune) 
			$DAEMON volume prune
			exit $?;;
		r|rm)
                        $DAEMON volume rm $2
                        exit $?;;
		*)
			echo -e "\n[ERROR] Unknown option '$1'. Options : "
			usage
			exit 2;;
	esac
done
