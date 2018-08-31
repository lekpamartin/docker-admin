#!/bin/sh

CWD='/data/repo/lekpamartin/docker-admin'

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

if [ ! -e ${HARBOR_API_CACERT} ]; then
	CERT='-k'
else
	CERT="--cacert ${HARBOR_API_CACERT}"
fi 

CURLAPI="curl -u ${HARBOR_API_USER}:${HARBOR_API_PASSWORD} -i ${CERT} ${HARBOR_API_URL}"

while true ; do
	case "$1" in
		get-projects)
			exit $?;;
		get-images)
			exit $?;;
		get-image-tags)
			${CURLAPI}/repositories/$2/tags
			exit $?;;
		get-user-info)
			${CURLAPI}/users/${2:-$HARBOR_API_USER}
			exit $?;;
		*)
			echo -e "\n[ERROR] Unknown option '$1'. Options : "
			usage
			echo ""
			exit 2;;
	esac
done
 
exit 0
