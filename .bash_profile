if [[ -n "${PS1}" ]]; then
    . ${HOME}/.bashrc && check_screen
else
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
    function lis () { source ~/.bashrc ; } ;
    [ -f ${HOME}/.bash/env ] && . ${HdOME}/.bash/env
    [ -f ${HOME}/.bash/aliases ] && . ${HOME}/.bash/aliases
    [ -f ${HOME}/.bash/func ] && . ${HOME}/.bash/func
fi

export PATH=/opt/local/bin:/opt/local/sbin:$PATH
if [ -d "$HOME/Library/Python/2.7/bin" ]; then
	PATH="$HOME/Library/Python/2.7/bin:$PATH"
fi
