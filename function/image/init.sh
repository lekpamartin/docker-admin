#!/bin/sh

usage () {
	echo -e "\n\tp|prune : Remove unused images \
		\n\tl|pull : Pull an image or a repository from a registry \
		\n\ts|push : Push an image or a repository to a registry"
}

if [ $# == 0 ]; then
	docker image ls
	exit $?
fi
 
while true ; do
	case "$1" in
		p|prune) 
			docker image prune
			exit $?;;
		l|pull)
                        docker pull $2
                        exit $?;;
		s|push)
                        docker push $2
                        exit $?;;
		r|rm)
                        docker image rm $2
                        exit $?;;
		a|tag)
                        docker image tag $2 $3
                        exit $?;;
		*)
			echo -e "\n[ERROR] Unknown option '$1'. Options : "
			usage
			exit 2;;
	esac
done
