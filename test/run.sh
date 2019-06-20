#!/usr/bin/env bash

set -p

cd "$( dirname "${BASH_SOURCE[0]}" )" || exit

: "${VADER_TEST_VIM:=vim}"
eval "$VADER_TEST_VIM -Nu vimrc -es -c 'Vader! -q *'"
