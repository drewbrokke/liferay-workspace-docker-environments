#!/bin/bash

SCRIPT_DIR="$(dirname "${BASH_SOURCE[0]}")"
# shellcheck disable=SC1091
source "${SCRIPT_DIR}/_common.sh"

_WORKSPACES="$(git worktree list --porcelain | grep '/liferay-composer-workspace')"
_cancel_if_empty "${_WORKSPACES}" "No workspaces to remove"

_WORKSPACE="$(echo "${_WORKSPACES}" | _select | awk '{print $2}')"

if _confirm "Remove workspace? ${_WORKSPACE}"; then
	git worktree remove "${_WORKSPACE}"
fi
