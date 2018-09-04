#!/bin/sh

CWD='.'

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
		get-image-status)
			JSON="["
			for i in $HARBOR_PROJECT_ID; do
				REPO=""
				OUTPUT_REPO=`$CURLAPI/repositories/?project_id=$i | jq -r '.[] | {name: .name  } | .name'`
				REPO="$REPO $OUTPUT_REPO"

				for j in $REPO; do
					TAGS=""
					OUTPUT_TAGS=`$CURLAPI/repositories/$j/tags | jq -r '.[] | {name: .name  } | .name'`
					TAGS="$TAGS $OUTPUT_TAGS"

						for k in $TAGS; do
							OUTPUT_VUL=`$CURLAPI/repositories/$j/tags/$k/vulnerability/details | jq -r '.[] | select(.fixedVersion != null) |  {package: .package, version: .version, fixedVersion: .fixedVersion  }' | sed 's/}/}, /g'| sed "s;{;{ 'repository': '$j', 'tag': '$k', ;g"`
							JSON="$JSON $OUTPUT_VUL"
						done
				done
			done
			echo "$JSON ]" | sed 's/},   ]/}   ]/g' | sed "s/'/\"/g"
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

		image-status)
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
