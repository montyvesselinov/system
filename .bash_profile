if [[ -n "$PS1" ]]
then
    . ${HOME}/.bashrc && check_screen
else
    #source ${HOME}/.bash_profile
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
    [ -f ${HOME}/.bash/env ] && . ${HOME}/.bash/env
    [ -f ${HOME}/.bash/aliases ] && . ${HOME}/.bash/aliases
    [ -f ${HOME}/.bash/func ] && . ${HOME}/.bash/func
fi
