#!/bin/bash

SCRIPT_DIR="$(dirname "${BASH_SOURCE[0]}")"
source "${SCRIPT_DIR}/scripts/_common.sh"

COMMAND="${1}"
if [[ -z "${COMMAND}" ]]; then
	COMMAND="$(find scripts -type f -not -name "_*.sh" -exec basename {} \; | sed 's,.sh$,,g' | _select)"
fi
_cancel_if_empty "${COMMAND}"

SCRIPT_FILE="${SCRIPT_DIR}/scripts/${COMMAND}.sh"

if [[ ! -x "${SCRIPT_FILE}" ]]; then
	_die "${COMMAND} is not a valid command"
fi

"${SCRIPT_DIR}/scripts/${COMMAND}.sh"
