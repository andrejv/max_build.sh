#!/bin/sh

set -e

###################################################################
###################################################################
####                                                           ####
####              ~ CONFIGURATION ~                            ####
####                                                           ####
####  Edit the options below.                                  ####

####  EDIT THE OPTIONS FOR THE INSTALLER                       ####

PREFIX=e:/maxima
USE_LISP=sbcl
#USE_LISP=ccl
TRANSLATIONS="es pt pt_BR"
#TRANSLATIONS=""

####  EDIT THE VARIABLES BELOW TO POINT TO THE CORRECT FILES   ####

LISP_SBCL=/C/Program\ Files/Steel\ Bank\ Common\ Lisp/1.2.7/sbcl.exe
LISP_CCL=/C/Users/andrej/Desktop/Dev/ccl/wx86cl.exe
HHC=/c/programs/hhw/hhc.exe
TCLKITSH=/c/programs/star/tclkitsh-8.6.3-win32-ix86.exe
TCLKIT_RUNTIME=/c/programs/star/tclkit-8.6.3-win32-ix86.exe
SDXKIT=/c/programs/star/sdx.kit
IMGKIT=/c/programs/star/img.kit
ISCC=/c/Program\ Files/Inno\ Setup\ 5/iscc.exe
WXMAXIMADIR=/c/programs/wxmaxima
GNUPLOTDIR=/c/programs/gnuplot

#### NO EDITING REQUIRED BELOW THIS LINE                       ####
####                                                           ####
###################################################################
###################################################################

#### Test variables! ###
if [ ! -e $TCLKITSH ]; then
    echo "ERROR: tclkitsh not found!"
    exit 0
fi
if [ ! -e $TCLKIT_RUNTIME ]; then
    echo "ERROR: tclkit not found!"
    exit 0
fi
if [ ! -e $SDXKIT ]; then
    echo "ERROR: sdx.kit not found!"
    exit 0
fi
if [ ! -e $IMGKIT ]; then
    echo "ERROR: img.kit not found!"
    exit 0
fi
if [ ! -e $HHC ]; then
    echo "ERROR: hhc.exe not found!"
    exit 0
fi
if [ ! -d $WXMAXIMADIR ]; then
    echo "ERROR: wxmaxima dir not found!"
    exit 0
fi
if [ ! -d $GNUPLOTDIR ]; then
    echo "ERROR: gnuplot dir not found!"
    exit 0
fi


MAKEVARS="TCLKITSH=\"$TCLKITSH\" TCLKIT_RUNTIME=\"$TCLKIT_RUNTIME\" SDXKIT=\"$SDXKIT\" IMGKIT=\"$IMGKIT\" WXMAXIMADIR=\"$WXMAXIMADIR\" GNUPLOTDIR=\"$GNUPLOTDIR\""

if [ $USE_LISP = "sbcl" ]; then
    if [ ! -e "$LISP_SBCL" ]; then
	echo "ERROR: sbcl not found!"
	exit 0
    fi
    if [ -z "$SBCL_HOME" ]; then
	echo "Setting SBCL_HOME"
	SBCL_HOME=`dirname "$LISP_SBCL"`
    fi
    LISP=--with-sbcl="$LISP_SBCL"
else
    if [ ! -e "$LISP_CCL" ]; then
	echo "ERROR: ccl not found!"
	exit 0
    fi
    LISP=--with-openmcl="$LISP_CCL"
fi

LANGS=
for l in $TRANSLATIONS
do
    LANGS="$LANGS --enable-lang-$l"
done

./configure --prefix=$PREFIX  \
     --enable-chm             \
     --with-hhc="$HHC"        \
     --enable-xmaxima-exe     \
     $LANGS                   \
     "$LISP"

make $MAKEVARS
make install $MAKEVARS
make iss $MAKEVARS

"$ISCC" maxima.iss
