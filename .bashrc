[[ -f ${HOME}/.bash/init ]] && source ${HOME}/.bash/init
HOSTNAME_ORIG=${HOSTNAME}
HOSTNAME=${HOSTNAME##su*-}
HOSTNAME=${HOSTNAME%%.*}
HOSTNAME=${HOSTNAME%%[1-9]*}
HOSTNAME=${HOSTNAME%%-fe*}
export HOSTNAME
if [[ -n "${PS1}" ]]; then
	powerline_path="$(python -c 'import pkgutil; print pkgutil.get_loader("powerline").filename' 2>/dev/null)"
	#if [[ "$powerline_path" != "" ]]; then
    #source ${powerline_path}/bindings/bash/powerline.sh
	if [[ -f "${HOME}/system/powerline/powerline/bindings/bash/powerline.sh" ]]; then 
# Powerline prompt
		export PATH=$PATH:~/system/powerline/scripts
		powerline-daemon -q
		POWERLINE_BASH_CONTINUATION=1
		POWERLINE_BASH_SELECT=1
		. ${HOME}/system/powerline/powerline/bindings/bash/powerline.sh
		function _update_title() {
			if [[ "${HOSTNAME}" == "bored" ]]; then
				echo -ne "\033]0;${PWD##*/}\007"
			else
				echo -ne "\033]0;${HOSTNAME}:${PWD##*/}\007"
			fi
		}
		export PROMPT_COMMAND="$PROMPT_COMMAND _update_title"
		#if [ -f ${HOME}/system/powerline-shell/powerline-shell.py ]; then
			#function _update_ps1() {
				# export PS1="$(${HOME}/system/powerline-js/powerline.js $? --shell bash --depth 4)"
				# export PS1="$(${HOME}/system/powerline-shell/powerline-shell.py $? 2> /dev/null)"
			#}
			# export PROMPT_COMMAND="$PROMPT_COMMAND _update_title"
		#fi
		# source ${HOME}/.bash/prompt # does not work properly
	else
# Use fancy prompt
		function _disown() {
			disown -a -r -h
		}
		export PROMPT_COMMAND="$PROMPT_COMMAND _disown"
		case $TERM in
			xterm*)
				PS1='\[\033]0;$HOSTNAME:\W\007\]\[\033[01;7m\] \u@$HOSTNAME \[\033[01;27m\] \[\033[00m\]\A\[\033[01;34m\] \w \[\033[00m\][\!] '
				;;
			*)
				PS1='\[\033[01;7m\] \u@$HOSTNAME \[\033[01;27m\] \[\033[00m\]\A\[\033[01;34m\] \w \[\033[00m\][\!] '
				;;
		esac
		function _update_title() {
			if [[ "${HOSTNAME}" == "bored" ]]; then
				echo -ne "\033]0;${PWD##*/}\007"
			else
				echo -ne "\033]0;${HOSTNAME}:${PWD##*/}\007"
			fi
		}
		export PROMPT_COMMAND="$PROMPT_COMMAND _update_title"
	fi
# Use bash-completion, if available
	if [[ -f ~/system/bash-completion/bash_completion ]]; then
		. ~/system/bash-completion/bash_completion
	elif [[ -f /opt/local/share/bash-completion/bash_completion ]]; then
		. /opt/local/share/bash-completion/bash_completion
	fi
	if [[ -f /etc/bash_completion ]] && ! shopt -oq posix; then
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
		# echo "OSX"
		export CDPATH=.:${HOME}:${HOME}/lanl:${HOME}/Documents:${HOME}/Documents/lanl
		export CLICOLOR=1
		export LSCOLORS=gxfxcxdxbxegedabagaced ;; 
    linux*)
		# echo "LINUX"
		export CDPATH=.:${HOME}:/scratch/er/monty:/scratch/ymp/monty:/scratch/nts/monty:/scratch/gwpa/monty:/scratch/rigel10/monty:/scratch/indigo2/monty:/scratch/fiesta2/monty ;;
    msys*)
		# echo "Windows" 
		;;
    bsd*)
		echo "BSD" ;;
    *)
		echo "unknown: $OSTYPE" ;;
esac
ulimit -c 0
export GIT_SSH=~/system/script/turq-ssh-hop.sh
source ${HOME}/.bash/env
source ${HOME}/.bash/aliases
source ${HOME}/.bash/func
source ${HOME}/.bash/func-common
source ${HOME}/system/git-completion.bash
source ${HOME}/system/tmux.completion.bash
export LD_LIBRARY_PATH=/users/vvv/mads/repo/tpls/lib:/usr/projects/hpcsoft/toss2/common/gcc/4.9.2/lib64:$LD_LIBRARY_PATH
if [[ $HOSTNAME_ORIG =~ $TURQ_REGEXP ]]; then
	if [[ -n "${PS1}" ]]; then
		echo "LANL turquoise machines"
		echo "Load modules ..."
		module load friendly-testing
		module load user_contrib
		module load friendly-testing cmake/3.2.1
		module load friendly-testing gcc/4.9.2
		module load git
		# export MADS_NO_PLOT=""
		export MADS_NO_PLOT=""
	fi
fi
