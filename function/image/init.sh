#!/bin/sh

CWD='/data/repo/lekpamartin/docker-admin'

. $CWD/docker-admin.conf

usage () {
	echo -e "\n\tp|prune : Remove unused images \
		\n\tl|pull : Pull an image or a repository from a registry \
		\n\ts|push : Push an image or a repository to a registry"
}

if [ $# == 0 ]; then
	$DAEMON image ls
	exit $?
fi
 
while true ; do
	case "$1" in
		p|prune) 
			$DAEMON image prune
			exit $?;;
		l|pull)
                        $DAEMON pull $2
                        exit $?;;
		s|push)
                        $DAEMON push $2
                        exit $?;;
		r|rm)
                        $DAEMON image rm $2
                        exit $?;;
		a|tag)
                        $DAEMON image tag $2 $3
                        exit $?;;
		*)
			echo -e "\n[ERROR] Unknown option '$1'. Options : "
			usage
			exit 2;;
	esac
done
