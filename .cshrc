# .cshrc

if ($?prompt == 0) then
        source ~/source/alias
        limit coredumpsize 0
        exit 0
endif

# Verify the shell is tcsh and is interactive.
if ($?tcsh && ! $?0) then

    # Set the prompt to show the username %n, hostname %m, the last three
    # elements of the current directory %c03, and the event number %h.  The
    # symbol %# translates to `>' for normal users and `#' for superuser.
    # Skipped directory path components are indicated by a leading `/<n>',
    # where n is the number of directory components skipped.  Replacing %c03
    # with %c3 will disable the `/<n>' indicator.  If the full path (rather
    # than simply the last three elements of the current directory) is desired,
    # change %c03 to %~.  The home directory is displayed as `~'.  Replacing
    # %c03 with %C03 (or %~ with %/) will expand `~' to `/<home>/<user>'.

    set prompt = "%S %n@%m %s %T %~ \[!\] "

    # Bind CTRL-R to reverse history search.
    bindkey "^r" i-search-back

    # Complete cd, pushd & popd for directory files only.
    complete {cd,pushd,popd} 'p/1/d/'

    # Complete printenv for environment variables only.
    complete printenv 'p/1/e/'

    # Complete alias for alias variables only.
    complete alias 'p/1/a/'

    if ($?TERM) then
	# Verify an xterm or an xterm compatible window is running.
	if ($TERM =~ xterm || $TERM =~ xterm-color || $TERM =~ iris-ansi || $TERM =~ dtterm) then
	    # Aliases to set the title of an xterm window to display the host
	    # and current directory whenever a directory change occurs.
	    alias settitle 'echo -n "\033];$HOST:r $cwd:t\007"'
	    # alias settitle 'echo -n "]2; ${HOST} $cwd"'
	    alias cd 'cd \!*; settitle'
	    alias pushd 'pushd \!*; settitle'
	    alias popd 'popd \!*; settitle'

	    # Set the window title.
	    settitle

	    # Alias to set the icon of an xterm window to display the user
	    # and host when the window is iconified.
	    alias seticon 'echo -n "]1; ${HOST}"'

	    # Set the window icon.
	    seticon
	endif
    endif

    # History parameters
    set tperiod = 300
    alias periodic 'history -S'
    set history = 1000
    set savehist = 1000

    # Mungepath is a perl script that prepends and/or appends to path
    # environment variables without duplication.  Mungepath expects three
    # arguments, the name of the environment variable, a colon separated list
    # of items to prepend to the variable, and a colon separated list of items
    # to append to the variable.  If one of the lists is null, supply mungepath
    # with a null argument such as ''.  Be careful to keep the single quotes,
    # double quotes, and back ticks correct.
#    if (-f /usr/local/share/bin/mungepath) then
        # Prepend ~/bin and append /usr/lanl/gnu/bin to PATH.
#        eval `/usr/local/share/bin/mungepath PATH '' /usr/lanl/gnu/bin`

        # Prepend ~/man and append /usr/lanl/gnu/man to MANPATH.
#        eval `/usr/local/share/bin/mungepath MANPATH ~/man /usr/lanl/gnu/man`
#    endif
endif

# Disallow read/write/execute permission for group and others
# umask 077
umask 026

# Verify all removes, copies & moves.
alias rm 'rm -i'
alias mv 'mv -i'
switch( $HOSTTYPE )
case i386-linux:
case x86_64-linux:
	alias cp 'cp -i --preserve=mode,timestamp'
	breaksw
case power-mac:
case intel-mac:
	alias cp 'cp -i -p'
	breaksw
endsw

# Add ~ to the cdpath for easy access to top-level directories in ~.
switch( $HOSTTYPE )
case iris4d:
	set cdpath = (~ /scratch/monty)
	breaksw
case i386-linux:
        if( $HOST == "acme-fe" ) then
          set cdpath = (~ /scratch/monty /home/ees/nts/monty/)
        else
          set cdpath=( ~ /scratch/er/monty /scratch/ymp/monty /scratch/nusselt1/monty /scratch/rigel10/monty /scratch/indigo2/monty /scratch/fiesta2/monty )
        endif
	breaksw
case x86_64-linux:
	# eval `ssh-agent -c`
        set cdpath=( ~ /scratch/er/monty /scratch/ymp/monty /scratch/nts/monty /scratch/gwpa/monty /scratch/rigel10/monty /scratch/indigo2/monty /scratch/fiesta2/monty )
	setenv LD_LIBRARY_PATH /usr/lib:/usr/lib64:/usr/lanl/lib:/home/monty/local/lib
	setenv LIBRARY_PATH /usr/lib:/usr/lib64:/usr/lanl/lib:/home/monty/local/lib
	setenv CPATH /home/monty/local/include 
	breaksw
case alpha:
	set cdpath = (~ /scratch/monty /usr/projects/ees/nts/monty)
	breaksw
case sun4:
        set cdpath=( ~ /scratch/er/monty /scratch/ymp/monty /scratch/nusselt1/monty /scratch/rigel10/monty /scratch/indigo2/monty /scratch/fiesta2/monty )
        breaksw
case power-mac:
case intel-mac:
        set cdpath=( ~ ~/lanl ~/Documents )
	breaksw
endsw

source ~/source/alias
source ~/source/set
source ~/source/setenv
source ~/source/complete
source ~/.git-completion.tcsh
source ~/source/print
source ~/source/ps
# source ~/source/prompt
# source ~/source/remote
# source ~/source/scratch
# source ~/source/backup
# source ~/source/fortran
# source ~/source/tex
# source ~/source/pine
# source ~/source/fehm
