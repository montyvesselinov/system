#!/bin/tcsh
ls -R $1 | grep ':$' | sed -e 's/:$//' -e 's/[^-][^\/]*\//--/g' -e 's/^/   /' -e 's/-/\|/'
