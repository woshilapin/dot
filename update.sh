#!/bin/bash

print_msg()
{
	echo "dot-files: ${1}"
}

create_link()
{
	ROOT_DIR="${1}"
	DOT="${2}"
	DST="${3}"
	SRC="${ROOT_DIR}/${DOT}"
	if test -z "${DST}"
	then
		# Default goes to a hidden file in ${HOME}
		DST="${HOME}/.${DOT}"
	fi
	if test ! -L "${DST}"
	then
		# Create symbolic link only if there is no file nor directory
		if test ! -f "${DST}" -a ! -d "${DST}"
		then
			print_msg "UPDATE: Create link '${DST}' to '${SRC}'"
			ln --symbolic "${SRC}" "${DST}"
		else
			# Mention all file or directories that are not symbolic links
			print_msg "INFO: ${DST} already exists"
		fi
	fi
	if test -d "${SRC}"
	then
		bash "${0}" "${SRC}"
	fi
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
	while read DOT_FILE_CONFIGURATION
	do
		DOT_ELEMENT="$(echo "${DOT_FILE_CONFIGURATION}" | awk '{print $1;}' )"
		WHERE="$(echo "${DOT_FILE_CONFIGURATION}" | awk '{print $2;}' )"
		if test ! -z "${WHERE}"
		then
			WHERE="${HOME}/${WHERE}"
		fi
		create_link "${DOT_PATH}" "${DOT_ELEMENT}" "${WHERE}"
	done < "${DOT_FILES}"
fi
