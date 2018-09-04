#!/bin/sh

CWD='/data/repo/lekpamartin/docker-admin'

. $CWD/docker-admin.conf

CURLAPI="curl -s -u ${HARBOR_API_USER}:${HARBOR_API_PASSWORD} ${CERT} ${HARBOR_API_URL}"

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
