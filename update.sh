#!/bin/bash

print_msg()
{
	echo "dot-files: ${1}"
}

dot_file()
{
	ROOT_DIR="${1}"
	FILE="${2}"
	if test ! -L "${HOME}/.${FILE}"
	then
		if test -f "${HOME}/.${FILE}"
		then
			print_msg "WARNING: File ${HOME}/.${FILE} already exists"
			DATE=$( date +'%Y%m%d-%H%M%S' )
			print_msg "INFO: File ${HOME}/.${FILE} backup to ${HOME}/.${FILE}.${DATE}"
			mv "${HOME}/.${FILE}" "${HOME}/.${FILE}.${DATE}"
		fi
		print_msg "UPDATE: Create link ${HOME}/.${FILE} to ${ROOT_DIR}/${FILE}"
		ln -s "${ROOT_DIR}/${FILE}" "${HOME}/.${FILE}"
	fi
	return 0
}

dot_dir()
{
	ROOT_DIR="${1}"
	DIR="${2}"
	if test ! -L "${HOME}/.${DIR}"
	then
		if test -d "${HOME}/.${DIR}"
		then
			print_msg "WARNING: Directory ${HOME}/.${DIR} already exists"
			DATE=$( date +'%Y%m%d-%H%M%S' )
			print_msg "INFO: Directory ${HOME}/.${DIR} backup to ${HOME}/.${DIR}.${DATE}"
			mv "${HOME}/.${DIR}" "${HOME}/.${DIR}.${DATE}"
		fi
		print_msg "UPDATE: Create link ${HOME}/.${DIR} to ${ROOT_DIR}/${DIR}"
		ln -s "${ROOT_DIR}/${DIR}" "${HOME}/.${DIR}"
	fi
	bash "${0}" "${HOME}/.${DIR}"
	return 0
}

if test $# -eq 0
then
	DOT_PATH="${HOME}/.dot"
else
	DOT_PATH="${1}"
fi
DOT_FILES="${DOT_PATH}/.dotfiles"

if test -f "${DOT_FILES}"
then
	while read ELEMENT
	do
		if test -d "${ELEMENT}"
		then
			dot_dir "${DOT_PATH}" "${ELEMENT}"
		else
			dot_file "${DOT_PATH}" "${ELEMENT}"
		fi
	done < "${DOT_FILES}"
fi
