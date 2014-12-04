[[ -f ${HOME}/.bash/init ]] && source ${HOME}/.bash/init
source ${HOME}/.bash/env
source ${HOME}/.bash/aliases
source ${HOME}/.bash/func
source ${HOME}/source/.git-completion.bash
if [[ -n "${PS1}" ]]; then
# Use fancy prompt
	case $TERM in
    	xterm*)
        	PS1='\[\033]0;\h:\W\007\]\[\033[01;7m\] \u@\h \[\033[01;27m\] \[\033[00m\]\A\[\033[01;34m\] \w \[\033[00m\][\!] '
        	;;
    	*)
        	PS1='\[\033[01;7m\] \u@\h \[\033[01;27m\] \[\033[00m\]\A\[\033[01;34m\] \w \[\033[00m\][\!] '
        	;;
	esac
# Very powerful prompt
# However requires powerline
# source ${HOME}/.bash/prompt
# Use bash-completion, if available
	if [ -f ~/source/bash-completion/bash_completion ]; then
		. ~/source/bash-completion/bash_completion
	elif [ -f /opt/local/share/bash-completion/bash_completion ]; then
		. /opt/local/share/bash-completion/bash_completion
	fi
	if [ -f /etc/bash_completion ] && ! shopt -oq posix; then
		COMPLETIONFILE=${COMPLETIONFILE:=/etc/bash_completion}
		. /etc/bash_completion
	fi
fi
# zimilar
#function command_not_found_handle {
#  zimilar $@
#}
#export -f command_not_found_handle
case "$OSTYPE" in
    solaris*)
		echo "SOLARIS" ;;
    darwin*)
		echo "OSX"
		export CDPATH=.:${HOME}:${HOME}/lanl:${HOME}/Documents:${HOME}/Documents/lanl
		export CLICOLOR=1
		export LSCOLORS=gxfxcxdxbxegedabagaced ;; 
    linux*)
		# echo "LINUX"
		export CDPATH=.:${HOME}:/scratch/er/monty:/scratch/ymp/monty:/scratch/nts/monty:/scratch/gwpa/monty:/scratch/rigel10/monty:/scratch/indigo2/monty:/scratch/fiesta2/monty ;;
    bsd*)
		echo "BSD" ;;
    *)
		echo "unknown: $OSTYPE" ;;
esac
