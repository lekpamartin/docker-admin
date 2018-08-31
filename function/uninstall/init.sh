#!/bin/sh

CWD='.'

. $CWD/docker-admin.conf

usage () {
        echo -e "\n\tcompose|docker-compose : Install docker-compose \
		\n\n\tmonitoring : Install monitoring tools for docker. Base on https://github.com/stefanprodan/dockprom \
                \n\n\tpath : Install docker-admin in your PATH"
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
			if [ -e "/usr/bin/docker-compose" ]; then
				echo -e "\nUninstalling docker-compose in /usr/bin \t"
				rm -f /usr/bin/docker-compose
				exit ?
			else 
				echo -e "\ndocker-compose not found in /usr/bin. \t"
				exit 1
			fi;;
		monitoring)
			cd $CWD/config/monitoring
			docker-compose down
			exit $?;;
		path)
			rm -f /usr/bin/docker-admin
			exit 0;;
		*)
			echo -e "\n[ERROR] Unknown option '$1'. Options : "
			usage
			echo ""
			exit 2;;
	esac
done
 
exit 0
