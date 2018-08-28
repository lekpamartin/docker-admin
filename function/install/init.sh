#!/bin/sh

CWD='.'

. $CWD/docker-admin.conf

usage () {
        echo -e "\n\tcompose|docker-compose : Install docker-compose \
		\n\tmonitoring : Install monitoring tools for docker. Base on https://github.com/stefanprodan/dockprom \
                \n\tpath : Install docker-admin in your PATH"
}


if [ $# == 0 ]; then
	echo -e "\n[WARNING] Provide an option. Options : "
        usage
	echo ""
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
		monitoring)
			cd config/monitoring
			docker-compose up -d
			exit $?;;
		path)
			ln -s `pwd`/docker-admin.sh /usr/bin/docker-admin
			sed -i "s,CWD='.',CWD='`pwd`',g" function/*/init.sh
			exit 0;;
		*)
			echo -e "\n[ERROR] Unknown option '$1'. Options : "
			usage
			echo ""
			exit 2;;
	esac
done
 
exit 0
