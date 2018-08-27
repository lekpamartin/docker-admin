#!/bin/sh

VERSION="0.1"

. ./docker-admin.conf

usage () {
	echo -e "\nUsage:  docker-admin COMMAND \n\nCommands:"
	cat function/*/init.txt 
	echo -e "\n docker-admin version $VERSION"
	exit 1
}

INSTALLED=`command -v $DAEMON`
if [ "$INSTALLED" == "" ]; then
	echo -e "\n\t[ERROR] Command docker not found. Check docker-admin.conf\n"
	exit 2
fi

if [ $# == 0 -o "$1" == "-h" -o "$1" == "--help" ]; then 
	usage
fi 

if [ "$1" == "-v" -o "$1" == "--version" ]; then
        echo -e "\n\t docker-admin version $VERSION\n"
	exit 0
fi

if [ ! -e "function/$1" ]; then
	echo -e "\n[ERROR] Unknown command '$1'.\n"
	usage
else
	function/$1/init.sh ${@:2}
fi

exit 0
