#!/bin/bash

echo "$0 sourcing common"

function _cancel() {
	echo "${@:-Cancelled}"
	exit 0
}

function _cancel_if_empty() {
	if [[ -z "${1}" ]]; then
		_cancel "${@}"
	fi
}

function _confirm() {
	MESSAGE="${1?Need a confirmation message}"

	echo ""
	echo "${MESSAGE}"
	read \
		-n 1 \
		-p "(y/N): " \
		-r \
		;

	if [ "${REPLY}" != "y" ] && [ "${REPLY}" != "Y" ]; then
		return 1
	fi
	return 0
}

function _die() {
	echo "${@}" >&2
	exit 2
}

function _select() {
	fzf --height 50% --reverse --border rounded --padding 5%
}
