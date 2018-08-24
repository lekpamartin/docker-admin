#!/bin/sh

usage () {
	echo "$0 " 

}

if [ $? != 0 ]; then
	usage
	exit 1
fi
 
eval set -- "$OPTS"
 
while true ; do
	case "$1" in
		-h) usage;
			exit 0;;
		--home) showHome;
			shift;;
		--nb_fichiers) echo "Afficher le nombre de fichiers et répertoires dans le répertoire $2";
			nbFichiers $2;
			shift 2;;
		--) shift; break;;
	esac
done
 
exit 0
