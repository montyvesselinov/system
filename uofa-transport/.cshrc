# @(#)Cshrc
#################################################################
#
#         .cshrc file
#
#         initial setup file for both interactive and noninteractive
#         C-Shells
#
#################################################################

#if($?ENVIRONMENT) exit
#setenv ENVIRONMENT YES

set mail = (/usr/spool/mail/$USER)
setenv MAIL /usr/spool/mail/$USER
biff y

#         aliases for all shells

source ~/source/alias

#         skip remaining setup if not an interactive shell

if ($?USER == 0 || $?prompt == 0) exit

#         settings  for interactive shells

if ( $path[1] != '.' ) set path = (. ~/bin /scr3/monty/gslib/bin $path /usr/local/bin /usr/local/lib /usr/local/teTeX/bin )

source ~/source/set
source ~/source/setenv
source ~/source/prompt
source ~/source/remote
source ~/source/print
source ~/source/ps
source ~/source/scr
source ~/source/backup

source ~/source/apache
source ~/source/bhp
source ~/source/fehm

source ~/source/tex
source ~/source/for
source ~/source/tecplot
source ~/source/scr
# source ~/source/aixterm
# source ~/source/uncert
# source ~/source/background
