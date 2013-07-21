#! /bin/sh

# Put everything possible in the path
PATH=/usr/ucb/bin:/usr/sysv/bin:/etc:/usr/etc
PATH=$PATH:/usr/local/bin:/usr/bin:/bin
PATH=$PATH:/usr/local/sbin:/usr/sbin:/sbin

##
## Get information about this machine, to help locate any boxes with
## problems
##

# Awk script to pull IPs and mac addresses from ifconfig
awkscript=/tmp/unixscan.$$.awk
cat > $awkscript <<'EOF'
{
  # Get IPs and mac addresses
  for (i = 1; i < NF + 1; i += 1) {
    # Strip any non-numeric stuff at the beginning
    field = $i;
    sub(/^(addr:)/, "", field);

    # Is it an IP?
    if ((field ~ /^[0-9]+\.[0-9]+\.[0-9]+\.[0-9]+$/) &&
        (field !~ /^(127|255)/) &&
        (field !~ /(0|255)$/)) {
      ip = field;
      gsub(/\./, "-", ip);
      if (ips) {
        ips = (ips "_" ip);
      } else {
        ips = ip;
      }
    }

    # Mac address?
    if ($i ~ /[0-9A-Fa-f]+[:.][0-9A-Fa-f]+[:.][0-9A-Fa-f]+[:.][0-9A-Fa-f]+[:.][0-9A-Fa-f]+[:.][0-9A-Fa-f]+$/) {
      mac = $i;
      gsub(/[:.]/, "-", mac);
      if (macs) {
        macs = (macs "_" mac);
      } else {
        macs = mac;
      }
    }
  }
}

END {
  if (! ips) {
    ips = "unk";
  }
  if (! macs) {
    macs = "unk";
  }
  print (ips "." macs);
}
EOF

echo "Trying to detect network information (you may see errors)"

awk=`command -v nawk 2>/dev/null`
if test "x$awk" = "x"; then
  awk=`command -v gawk 2>/dev/null`
fi
if test "x$awk" = "x"; then
  awk=`command -v mawk 2>/dev/null`
fi
if test "x$awk" = "x"; then
  awk=`command -v awk 2>/dev/null`
fi
if test "x$awk" = "x"; then
    echo "You don't appear to have awk, but that's okay."
    me=unk.unk
else
    # Get local IP/mac information from that awk script
    me="`ifconfig -a | $awk -f $awkscript`"

    # Maybe even that had a problem
    if test $? -ne 0; then
	echo "Awk had problems, but that's okay."
	me=unk.unk
    fi
fi

# Clean up that awk script
rm $awkscript

# Get OS type
ostype=`(uname -sr || echo 'unk') | sed 's/[^A-Za-z0-9]/-/g'`

# Put it all together
hostcommon="$me.$ostype.bogusdomain.net"


# Figure out local directories if they haven't been specified.
# This is a function because we don't always need to do it.
localdirs () {
    # Get a list of directories that are probably local
    dirs="`df | awk '{ if (NF == 1) { s = $0; getline; $0 = s \" \" $0; } if ((/^\//) && ($NF ~ /^\//)) { print $NF; } }'`"

    # Make sure they are actually directories
    for i in $dirs; do
	if test -d "$i/."; then
	    echo $i
	fi
    done
}

# On some platforms, we can cheat and only use local file systems, or
# file systems we suspect to be local.
s=`uname -sr`
case "x$s" in
    xDarwin*)
	findargs="/ ( ! -fstype local -prune )"
	;;
    xLinux*)
	ld="`localdirs`"
	findargs="$ld -xdev"
	;;
    xAIX*)
	findargs="/ ( ! -fstype jfs -prune )"
	;;
    xIRIX64*)
	findargs="/ ( ! -fstype xfs -prune )"
	;;
    xSunOS*5.*)
	findargs="/ ( ! -fstype ufs -prune )"
	;;
    *)
	findargs="/"
	;;
esac

##
## Now, try to locate the files in question
##


# Make sure the user knows what's about to happen.  I wish there were a
# better way to handle these conditions aside from letting the user
# worry about it, but there's just too much variance in Unix systems to
# cover all cases in one day's worth of coding.
if test "$findargs" = "/"; then
    cat <<EOF

======= WARNING ========

This script is about to run a recursive find.

If your machine has any NFS mounts, you should hit Control-C now, and
modify the script to run find with appropriate options for your OS.
Contact your system administrator for help.

EOF

    echo "Hit enter to continue"
    read p
fi

# Temporary file for find output
tmpfile="/tmp/unixscan.$$"

##
## Go find files
##
## Congratulations on reading the contents of the shell script.  You may
## be wondering why we are looking for .dll and .exe files on Unix
## systems.  I wonder that myself.  DOE HQ said we have to scan for
## them on all systems, so there you have it.
##
echo "Scanning..."
echo "  find $findargs"
find $findargs \
    \( -name bhoplugin.dll -o \
       -name hex2bin.exe -o \
       -name mslogon.dll -o \
       -name rar.gif -o \
       -name rdisk.dll -o \
       -name regsvr.dll -o \
       -name wauseru.dll -o \
       -name wauserv.dll -o \
       -name welcome.zip -o \
       -name wiaserv.dll \) -print > $tmpfile

if test $? -ne 0; then
    ping -c 1 error.$hostcommon > /dev/null 2> /dev/null &
    echo "Find had an error.  Did you run as root?"
fi

# Report back results
contents="`cat $tmpfile`"
if test "x$contents" = "x"; then
    ping -c 1 empty.$hostcommon > /dev/null 2> /dev/null &
    echo "Congratulations.  Nothing was found."
else
    for i in $contents; do
	e="`basename \"$i\"|sed 's/^\///; s/[^A-Za-z0-9]/-/g'`"
	ping -c 1 $e.$hostcommon > /dev/null 2> /dev/null &
    done

    echo "Files found: $contents"
    echo
    echo "Looks like you had some suspicious files.  Please"
    echo "contact your OCSR."
fi

# Clean up file
rm $tmpfile

