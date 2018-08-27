#!/bin/sh

. ./docker-admin.conf

usage () {
        echo -e "\n\tcompose|docker-compose : Install docker-compose \
                \n\tpath : Install docker-admin in your PATH"
}


if [ $# == 0 ]; then
        $DAEMON image ls
        exit $?
fi

while true ; do
	case "$1" in
		compose|docker-compose)
			COMPOSE=`command -v docker-compose`
			if [ "$COMPOSE" != "" ]; then
				echo -e "\n[WARNING] docker-compose already installed"
				docker-compose --version
				echo ""
				exit 0
			else 
				echo -en "\nInstalling... \t"
				curl -s -L https://github.com/docker/compose/releases/download/$COMPOSE_VERSION/docker-compose-$(uname -s)-$(uname -m) -o /usr/bin/docker-compose
				EXIT=$?
				chmod +x /usr/bin/docker-compose
				EXIT=$(( $EXIT + $? ))
				docker-compose --version
				echo ""
				exit $(( $EXIT + $? ))
			fi;;
		path)
			ln -s `pwd`/docker-admin.sh /usr/bin/docker-admin
			exit 0;;
		*)
			echo -e "\n[ERROR] Unknown option '$1'. Options : "
			usage
			echo ""
			exit 2;;
	esac
done
 
exit 0
