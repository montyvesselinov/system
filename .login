# .login

if ( ! $?SSH_AUTH_SOCK ) then
        eval `ssh-agent -c`
	ssh-add
endif

setenv PRINTER data
setenv LPDEST data
setenv EDITOR vim

limit coredumpsize 0

switch( $HOSTTYPE )
case powermac:
case intel-mac:
case x86_64-linux:
	set term=xterm-color
	setenv TERM xterm-color
	set path = ( /opt/local/bin $path ~/bin ~/script )
	breaksw
case i386-linux:
	set term=xterm-color
	setenv TERM xterm-color
	set path = ( $path ~/bin ~/pest_m/02linux /usr/local/tecplot/tlm /usr/local/tecplot/bin )
	breaksw
case alpha:
	set term=xterm-color
	setenv TERM xterm-color
	set path = ( $path ~/bin-q ~/pest_m/02q )
	setenv FORT_CONVERT.stor BIG_ENDIAN
	setenv FORT_CONVERT.temp BIG_ENDIAN
	breaksw
case iris4d:
	set path = ( $path ~/bin-sgi ~/pest_m/02sgi )
	breaksw
case sun4:
	set term=xterm
	setenv TERM xterm
        set path = ( $path ~/bin-sun )
        breaksw
endsw
set path = ( . ~/script /usr/local/bin $path )

exit
if ( ! ${?DTUSERSESSION} ) then
# Place any commands that set terminal characteristics here (these will
# not be set if you are running CDE...)
endif
# END -----------------------------------
# Verify not a LSF batch job.
if (! $?LSB_QUEUE) then
    # Set the interrupt character to CTRL-C and do clean backspacing.
#    stty intr '^C' echoe
 
    # Set the suspend character to CTRL-Z.
#    stty susp '^Z' echoe
 
    # Set the TERM environment variable.
#    eval `tset -s -Q`
endif

# Load modules.
# NOTE: Module loading has the side effect of modifying the PATH and MANPATH
# environment variables.  If you need to customize PATH or MANPATH (using
# either mungepath or setenv), do so prior to module loading.

switch( $HOSTTYPE )
case iris4d:
#if (-f /opt/modules/modules/modulefiles/modules) then
#    module load modules
#endif
#if (-f /opt/modulefiles/MIPSpro_latest) then
#    module load MIPSpro_latest
#endif
# if (-f /opt/modulefiles/MIPSpro_default) then
#    module load MIPSpro_default
#endif
#if (-f /opt/modulefiles/mpt_default) then
#    module load mpt_default
#endif
breaksw

case i386-linux:
#        if (-f /opt/modulefiles/absoft ) then
#                module load absoft
#        endif
breaksw

case alpha:
breaksw
endsw

# List loaded modules.
# module list
