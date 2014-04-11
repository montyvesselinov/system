#!/bin/tcsh -f

if( $#argv != 3 ) then
	echo "Usage: latexdiff_compile.sh OLD_TEX NEW_TEX TEX_OUT"
	exit 0
endif

latexdiff $1 $2 > $3
pdflatex --interaction=nonstopmode $3:r
bibtex $3:r
pdflatex --interaction=nonstopmode $3:r
pdflatex --interaction=nonstopmode $3:r
