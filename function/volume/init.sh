#!/bin/sh

usage () {
	echo -e "\n\tc|create : Create a volume \
		\n\ti|inspect : Display detailed information on one or more volumes \
		\n\tp|prune : Remove unused volumes \
		\n\tr|rm : Remove one or more volumes"
}

if [ $# == 0 ]; then
	docker volume ls
	exit $?
fi
 
while true ; do
	case "$1" in
		c|create)
                        docker volume create $2 $3
                        exit $?;;
		i|inspect)
                        docker volume inspect $2
                        exit $?;;
		p|prune) 
			docker volume prune
			exit $?;;
		r|rm)
                        docker volume rm $2
                        exit $?;;
		*)
			echo -e "\n[ERROR] Unknown option '$1'. Options : "
			usage
			exit 2;;
	esac
done
