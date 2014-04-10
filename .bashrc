[[ -f ${HOME}/.bash/init ]] && source ${HOME}/.bash/init
COMPLETIONFILE=${COMPLETIONFILE:=/etc/bash_completion}
source ${HOME}/.bash/env
source ${HOME}/.bash/aliases
source ${HOME}/.bash/func
source ${HOME}/source/.git-completion.bash
export PS1="\[\033[01;7m\] \u@\h \[\033[01;27m\] \[\033[00m\]\A\[\033[01;34m\] \w \[\033[00m\][\!] "
# [[ -n "${PS1}" ]] && source ${HOME}/.bash/prompt
function command_not_found_handle {
  zimilar $@
}
export -f command_not_found_handle
case "$OSTYPE" in
    solaris*)
	echo "SOLARIS" ;;
    darwin*)
	echo "OSX"
	export CDPATH=${HOME}:${HOME}/lanl:${HOME}/Documents:${HOME}/Documents/lanl
	;; 
    linux*)
	# echo "LINUX"
	export CDPATH=${HOME}:/scratch/er/monty:/scratch/ymp/monty:/scratch/nts/monty:/scratch/gwpa/monty:/scratch/rigel10/monty:/scratch/indigo2/monty:/scratch/fiesta2/monty
	;;
    bsd*)
	echo "BSD" ;;
    *)
	echo "unknown: $OSTYPE" ;;
esac
