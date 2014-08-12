#!/usr/bin/env bash
# Exit on error
set -o errexit
# Exit on unset variables
set -o nounset
# Catch the error code of the program who crashed in piping commands
set -o pipefail

declare -r __ROOT_PATH__="$( cd "$( dirname "${BASH_SOURCE[0]}" )" && pwd )"

declare -r HEADERS_PATH="${__ROOT_PATH__}/headers"
declare -r MESSAGES_PATH="${__ROOT_PATH__}/messages"
declare -r TEMPORARY_PATH="${__ROOT_PATH__}/temporary"

echo "${0}: INFO: Cleaning \`headers'."
cd "${HEADERS_PATH}" ; rm -Rf ./*
echo "${0}: INFO: Cleaning \`messages'."
cd "${MESSAGES_PATH}" ; rm -Rf ./*
echo "${0}: INFO: Cleaning \`temporary'."
cd "${TEMPORARY_PATH}" ; rm -Rf ./*
