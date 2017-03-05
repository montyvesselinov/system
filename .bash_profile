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

##
# Your previous /Users/monty/.bash_profile file was backed up as /Users/monty/.bash_profile.macports-saved_2017-02-08_at_09:38:16
##

# MacPorts Installer addition on 2017-02-08_at_09:38:16: adding an appropriate PATH variable for use with MacPorts.
export PATH="/opt/local/bin:/opt/local/sbin:$PATH"
# Finished adapting your PATH environment variable for use with MacPorts.

