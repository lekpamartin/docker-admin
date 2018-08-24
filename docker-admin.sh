#!/bin/sh

PWD=`pwd`

usage () {
	echo -e "\nUsage:  docker-admin COMMAND \n\nCommands:"
	cat function/*/init.txt 
	echo ""
	exit 1
}

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
