[[ -f ${HOME}/.bash/init ]] && source ${HOME}/.bash/init
if [ -f /opt/local/bin/bash ]; then
	export SHELL=/opt/local/bin/bash
	export BASH=/opt/local/bin/bash
fi
if [ -f /etc/bashrc ]; then
	. /etc/bashrc
fi
if [ -f ~/.profile ]; then
	source ~/.profile
fi

OSVERSION=`uname -r`
export OSVERSION

if [ -z ${HOSTNAME_ORIG+x} ]; then
	export HOSTNAME_ORIG=${HOSTNAME}
	if [[ $HOSTNAME_ORIG =~ ^es[0-9]*$ ]]; then
		ESNUMBER=${HOSTNAME_ORIG#es*}
		MADSNUMBER=`expr $ESNUMBER - 7`
		HOSTNAME=$(printf "mads%02d" $MADSNUMBER)
		source ~/system/export-proxy-lanl
	elif [[ $HOSTNAME_ORIG =~ ^mads.*$ ]]; then
		source ~/system/export-proxy-lanl
	else
		HOSTNAME=${HOSTNAME##su*-}
		HOSTNAME=${HOSTNAME%%.*}
		HOSTNAME=${HOSTNAME%%[0-9]*}
		HOSTNAME=${HOSTNAME%%-fe*}
	fi
	if [[ $HOSTNAME =~ cja.* ]]; then
		HOSTNAME="cj"
	fi
	export HOSTNAME
fi

if [[ -n "${PS1}" ]]; then
	bind '"\e[A": history-search-backward'
	bind '"\e[B": history-search-forward'
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
			if [[ "${HOSTNAME}" == "ml" ]] || [[ "${HOSTNAME}" == "ml.lanl.gov" ]]; then
				echo -ne "\033]0;${PWD##*/}\007"
			else
				echo -ne "\033]0;${HOSTNAME}:${PWD##*/}\007"
			fi
		}
		function _update_title2() {
			echo "${PWD##*/}"
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
				if [[ "${HOSTNAME}" == "ml" ]] || [[ "${HOSTNAME}" == "ml.lanl.gov" ]]; then
					PS1='\[\033]0;\W\007\]\[\033[01;7m\] \u@$HOSTNAME \[\033[01;27m\] \[\033[00m\]\A\[\033[01;34m\] \w \[\033[00m\][\!] '
				else
					PS1='\[\033]0;$HOSTNAME:\W\007\]\[\033[01;7m\] \u@$HOSTNAME \[\033[01;27m\] \[\033[00m\]\A\[\033[01;34m\] \w \[\033[00m\][\!] '
				fi
				;;
			*)
				PS1='\[\033[01;7m\] \u@$HOSTNAME \[\033[01;27m\] \[\033[00m\]\A\[\033[01;34m\] \w \[\033[00m\][\!] '
				;;
		esac
		function _update_title() {
			if [[ "${HOSTNAME}" == "ml" ]] || [[ "${HOSTNAME}" == "ml.lanl.gov" ]]; then
				echo -ne "\033]0;${PWD##*/}\007"
			else
				echo -ne "\033]0;${HOSTNAME}:${PWD##*/}\007"
			fi
		}
		function _update_title2() {
			echo "${PWD##*/}"
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
		export PATH=${PATH}:/Users/vvv/Library/Python/3.6/bin:/usr/local/opt/openssl/bin
		export LDFLAGS="-L/usr/local/opt/openssl/lib"
		export CPPFLAGS="-I/usr/local/opt/openssl/include"
		export LSCOLORS=gxfxcxdxbxegedabagaced 
		export PFLOTRAN_DIR=/Users/vvv/pflotran
		export PYFLOTRAN_DIR=/Users/vvv/python/pyflotran-lanl
		export PETSC_DIR=/Users/vvv/petsc
		export PETSC_ARCH=arch-darwin-c-opt ;;
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
export GIT_SSH=~/system/script/turq-ssh-hop.sh
source ${HOME}/.bash/env
source ${HOME}/.bash/aliases
source ${HOME}/.bash/func
source ${HOME}/.bash/func-common
source ${HOME}/system/git-completion.bash
source ${HOME}/system/tmux.completion.bash
export LD_LIBRARY_PATH=/users/vvv/mads/repo/tpls/lib:${HOME}/.julia/conda/3/lib/:$LD_LIBRARY_PATH
if [[ $HOSTNAME_ORIG =~ "ml.lanl.gov" ]]; then
	source ~/system/export-proxy-lanl
	export PATH=${PATH}:/usr/local/cuda/bin
	eval $(brew shellenv)
else
	eval $(/home/vvv/.linuxbrew-mads/bin/brew shellenv)
fi
if [[ $HOSTNAME_ORIG =~ $TURQ_REGEXP ]]; then
	umask g+w
	module load git
	module load gcc/5.3.0
	module load python/2.7-anaconda-4.1.1
	if [[ -n "${PS1}" ]]; then
		echo "LANL turquoise machines"
		echo "Load modules ..."
		module load friendly-testing
		if [[ `module avail user_cotrib` ]]; then
			module load user_contrib
		fi
		module load git
	fi
fi
export PATH="/home/vvv/miniconda3/bin:$PATH"
