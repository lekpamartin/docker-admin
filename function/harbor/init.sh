#!/bin/sh

CWD='/data/repo/docker-admin'

. $CWD/docker-admin.conf

usage () {
        echo -e "\n\tget-images : print images details\
		\n\tget-image-tags : print images tags details\
		\n\tget-projects : print project's details\
		\n\tget-user-info : print user info. without arg for configured user or with arg for a different user 'get-user-info user'"
}


if [ $# == 0 ]; then
	echo -e "\n[WARNING] Provide an option. Options : "
        usage
	echo ""
        exit $?
fi

if [ ! -e "${HARBOR_API_CACERT}" ]; then
	CERT='-k'
else
	CERT="--cacert ${HARBOR_API_CACERT}"
fi 

CURLAPI="curl -u ${HARBOR_API_USER}:${HARBOR_API_PASSWORD} -i ${CERT} ${HARBOR_API_URL}"

while true ; do
	case "$1" in
		get-images)
			exit $?;;
		get-image-tags)
			${CURLAPI}/repositories/$2/tags
			exit $?;;
		get-projects)
			exit $?;;
		get-user-info)
			${CURLAPI}/users/current
			exit $?;;
		get-user-list)
			${CURLAPI}/users
			exit $?;;
		*)
			echo -e "\n[ERROR] Unknown option '$1'. Options : "
			usage
			echo ""
			exit 2;;
	esac
done
 
exit 0
