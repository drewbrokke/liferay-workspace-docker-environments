#!/bin/bash

SCRIPT_DIR="$(dirname "${BASH_SOURCE[0]}")"
# shellcheck disable=SC1091
source "${SCRIPT_DIR}/_common.sh"

GRADLE_PROPERTIES_FILE="${SCRIPT_DIR}/../gradle.properties"

function getProp() {
	KEY="${1}"
	grep "^${KEY}=.*$" "${GRADLE_PROPERTIES_FILE}" | sed 's,^.*=,,g'
}
function setProp() {
	KEY="${1}"
	VALUE="${2}"

	sed -i.bak -E "s,${KEY}=.*$,${KEY}=${VALUE},g" "${GRADLE_PROPERTIES_FILE}"
	rm "${GRADLE_PROPERTIES_FILE}.bak"
}

PROP_PRODUCTVERSION="$(getProp "liferay.workspace.product")"
if _confirm "Change Liferay product version? (${PROP_PRODUCTVERSION})"; then
	PROP_PRODUCTVERSION="$(
		curl -s https://releases.liferay.com/releases.json |
			jq -r '.[].releaseKey' |
			_select
	)"
	
	setProp "liferay.workspace.product" "${PROP_PRODUCTVERSION}"
fi

choices=(
	foo
	bar
	baz
)
printf '%s\n' "${choices[@]}" |
	_select

# lr.docker.environment.service.enabled[elasticsearch]
rg "lr.docker.environment.service.enabled\[(.*)\]=(.*)" -o --replace='$1 - $2' "${GRADLE_PROPERTIES_FILE}" |
	_select