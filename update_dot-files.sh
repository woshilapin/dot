#!/bin/bash

print_msg()
{
	echo "dot-files: "$1
}

dot_file()
{
	if test ! -L ~/.$2
	then
		if test -f ~/.$2
		then
			print_msg "WARNING: File ~/.$2 already exists"
			print_msg "INFO: File ~/.$2 backup to ~/.$2.`date +'%Y%m%d-%H%M%S'`"
			mv ~/.$2 ~/.$2.`date +'%Y%m%d-%H%M%S'`
		fi
		print_msg "UPDATE: Create link ~/.$2 to $1/$2"
		ln -s $1/$2 ~/.$2
	fi
	return 0
}

dot_dir()
{
	if test ! -L ~/.$2
	then
		if test -f ~/.$2
		then
			print_msg "WARNING: Directory ~/.$2 already exists"
			print_msg "INFO: Directory ~/.$2 backup to ~/.$2.`date +'%Y%m%d-%H%M%S'`"
			mv ~/.$2 ~/.$2.`date +'%Y%m%d-%H%M%S'`
		fi
		print_msg "UPDATE: Create link ~/.$2 to $1/$2"
		ln -s $1/$2 ~/.$2
	fi
	bash $0 ~/.$2
	return 0
}

if test $# -eq 0
then
	DOT_PATH=~/.dot
else
	DOT_PATH=$1
fi
DOT_FILES=$DOT_PATH/.dotfiles

if test -f $DOT_FILES
then
	for element in `cat $DOT_FILES`
	do
		if test -d $element
		then
			dot_dir $DOT_PATH $element
		else
			dot_file $DOT_PATH $element
		fi
	done
fi
