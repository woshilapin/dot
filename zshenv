#!/bin/zsh
# PATH initialisations
UNAME=`uname`
if test $UNAME = "Linux" ;
then
	PATH=$PATH:/usr/local/sbin:/usr/sbin:/sbin
elif test $UNAME = "Darwin" ;
then
	PATH=/opt/local/bin:/opt/local/sbin:$PATH
fi
export PATH
# TRASH initialisations
if test $UNAME = "Linux" ;
then
	TRASH=~/.local/share/Trash/files ;
elif test $UNAME = "Darwin" ;
then
	TRASH=~/.Trash ;
fi
export TRASH
export UNAME=`uname`
export LC_ALL=fr_FR.UTF-8
if test `uname` = 'Darwin';     
then
	export EDITOR=/opt/local/bin/vim
else
	export EDITOR=/usr/bin/vim
fi
export PAGER=/usr/bin/less
declare -x TEXINPUTS=.:$HOME/.texmf:
# For java
JAVA_HOME_LIST=/usr/lib/jvm/java-6-sun:/usr/lib/jvm/default-java
# Select the first available directory for JAVA_HOME
if test `uname` = 'Linux';     
then
	for dir in `echo $JAVA_HOME_LIST | sed 's/:/ /g'`                                                                                                                   
	do
		if test -d $dir
		then
			export JAVA_HOME=$dir
			break
		fi
	done
fi
