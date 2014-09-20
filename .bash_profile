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
#    [ [ -r ~/.bashrc ] ] && . ~/.bashrc
    [ -f ${HOME}/.bash/env ] && . ${HdOME}/.bash/env
    [ -f ${HOME}/.bash/aliases ] && . ${HOME}/.bash/aliases
    [ -f ${HOME}/.bash/func ] && . ${HOME}/.bash/func
fi

##
# Your previous /Users/monty/.bash_profile file was backed up as /Users/monty/.bash_profile.macports-saved_2014-09-20_at_16:00:57
##

# MacPorts Installer addition on 2014-09-20_at_16:00:57: adding an appropriate PATH variable for use with MacPorts.
export PATH=/opt/local/bin:/opt/local/sbin:$PATH
# Finished adapting your PATH environment variable for use with MacPorts.

