#!/bin/sh

PWD=`pwd`

. ./docker-admin.conf

usage () {
	echo -e "\nUsage:  docker-admin COMMAND \n\nCommands:"
	cat function/*/init.txt 
	echo ""
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

if [ ! -e "function/$1" ]; then
	echo -e "\n[ERROR] Unknown command '$1'.\n"
	usage
else
	function/$1/init.sh ${@:2}
fi

exit 0
