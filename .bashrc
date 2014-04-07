[[ -f ${HOME}/.bash-local/init ]] && source ${HOME}/.bash-local/init
COMPLETIONFILE=${COMPLETIONFILE:=/etc/bash_completion}
source ${HOME}/.bash/env
source ${HOME}/.bash/aliases
source ${HOME}/.bash/func
source ${HOME}/source/.git-completion.bash
# source ${HOME}/source/alias
# [[ -n "${PS1}" ]] && source ${HOME}/.bash/prompt
export PS1="\[\033[01;7m\] \u@\h \[\033[01;27m\] \[\033[00m\]\A\[\033[01;34m\] \w \[\033[00m\][\!] "
function command_not_found_handle {
  zimilar $@
}
