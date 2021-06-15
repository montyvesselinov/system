export BASH_SILENCE_DEPRECATION_WARNING=1
if [[ -n "${PS1}" ]]; then
    . ${HOME}/.bashrc && check_screen
else
	ulimit -c 0
	OS=`uname -s`;
    export PATH=${HOME}/bin:/usr/local/bin:/bin:/usr/bin:/sbin:/usr/sbin:/usr/X11R6/bin:/opt/TWWfsw/bin:/usr/local/sbin
    export EDITOR=vi
    export VISUAL=vi
    export PAGER=less
    export LESS=-MecX
    if [ "${OS}" = "SunOS" ] ; then
        PATH=/opt/SUNWspro/bin/:${PATH}:~/bin:/usr/local/lbin:/usr/local/sbin:/opt/SUNWspro/bin/:/usr/ccs/bin
        OPENWINHOME=/usr/openwin
        EDITOR=/usr/bin/vi
        VISUAL=/usr/bin/vi
        export OPENWINHOME EDITOR VISUAL PATH
    fi
    [ -f ${HOME}/.profile ] && . ${HOME}/.profile
    [ -f ${HOME}/.bash/env ] && . ${HOME}/.bash/env
    [ -f ${HOME}/.bash/aliases ] && . ${HOME}/.bash/aliases
    [ -f ${HOME}/.bash/func ] && . ${HOME}/.bash/func
	verify_tmux_version
fi

export PYTHONPATH=${HOME}/python
export PATH=/opt/local/bin:/opt/local/sbin:/usr/texbin:$PATH
if [ -d "$HOME/Library/Python/2.7/bin" ]; then
	PATH="$HOME/Library/Python/2.7/bin:$PATH"
fi

if [ -d $HOME/DWave/qOp ]; then
	export DWAVE_HOME=$HOME/DWave/qOp
	PATH="$PATH:$DWAVE_HOME/bin"
	export DYLD_LIBRARY_PATH=$DWAVE_HOME
	source $DWAVE_HOME/bin/dw
fi

export PATH="/opt/local/bin:/opt/local/sbin:$PATH"

# added by Miniconda3 installer
# export PATH="/Users/monty/miniconda3/bin:$PATH"  # commented out by conda initialize

# >>> conda initialize >>>
# !! Contents within this block are managed by 'conda init' !!
__conda_setup="$('/opt/miniconda3/bin/conda' 'shell.bash' 'hook' 2> /dev/null)"
if [ $? -eq 0 ]; then
    eval "$__conda_setup"
else
    if [ -f "/opt/miniconda3/etc/profile.d/conda.sh" ]; then
        . "/opt/miniconda3/etc/profile.d/conda.sh"
    else
        export PATH="/opt/miniconda3/bin:$PATH"
    fi
fi
unset __conda_setup
# <<< conda initialize <<<

