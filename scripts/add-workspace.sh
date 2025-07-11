#!/bin/bash

SCRIPT_DIR="$(dirname "${BASH_SOURCE[0]}")"
# shellcheck disable=SC1091
source "${SCRIPT_DIR}/_common.sh"

if [[ -z "${LR_COMPOSER_WORKTREES_DIR}" ]]; then
	LR_COMPOSER_WORKTREES_DIR="$(git rev-parse --show-toplevel)/.."
fi
echo "LR_COMPOSER_WORKTREES_DIR: ${LR_COMPOSER_WORKTREES_DIR}"

_TICKET_NUMBER="$(gum input --prompt="Ticket number? ")"
_cancel_if_empty "${_TICKET_NUMBER}"

_TICKET_NUMBER="$(echo "${_TICKET_NUMBER}" | xargs | tr " " "-")"

_PROJECT_NAME="liferay-composer-workspace-${_TICKET_NUMBER}"

_BRANCH_NAME="branch-${_TICKET_NUMBER}"
_PROJECT_DIR="${LR_COMPOSER_WORKTREES_DIR}/${_PROJECT_NAME}"

if ! _confirm "Add workspace? ${_PROJECT_DIR}"; then
	_cancel
fi

git worktree add "${_PROJECT_DIR}" -b "${_BRANCH_NAME}" main

echo ""
echo "New workspace created at ${_PROJECT_DIR}"
echo ""
