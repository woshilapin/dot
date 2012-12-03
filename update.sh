#!/bin/bash

print_msg()
{
	echo "dot-files: "$1
}

REV_MASTER=`cd ~/.dot && git rev-parse master`
REV_ORIGIN=`cd ~/.dot && git rev-parse origin/master`
if test $REV_MASTER != $REV_ORIGIN
then
	print_msg "INFO: Your dot-files are outdated"
	print_msg "Do you want to update your dot-files [y/n/a]?"
	read UPDATE_DOT_FILES
	if test $UPDATE_DOT_FILES = "a"
	then
		logout
	elif test $UPDATE_DOT_FILES = "n"
	then
		return 0
	elif test $UPDATE_DOT_FILES = "y"
	then
		cd ~/.dot &&
			git pull &&
			git submodule update
	else
		print_msg "ERROR: You should answer with one of (y)es, (n)o or (a)bort"
		sh $0
	fi
fi
sh ~/.dot/update_dot-files.sh ~/.dot
