#!/bin/sh

#set -e

###################################################################
###################################################################
####                                                           ####
####              ~ CONFIGURATION ~                            ####
####                                                           ####
####  Edit the options below.                                  ####

####  EDIT THE OPTIONS FOR THE INSTALLER                       ####

USE_LISP=sbcl
#USE_LISP=ccl
#USE_LISP=clisp
TRANSLATIONS="es pt pt_BR"
PREFIX=c:/maxima-$USE_LISP
WIN64="true"

####  EDIT THE VARIABLES BELOW TO POINT TO THE CORRECT FILES   ####

#LISP_SBCL=/C/Program\ Files\ \(x86\)/Steel\ Bank\ Common\ Lisp/1.2.7/sbcl.exe
LISP_SBCL="/C/Program Files/Steel Bank Common Lisp/1.3.4/sbcl.exe"
LISP_CCL=/C/programs/ccl/wx86cl.exe
LISP_CLISP=/C/programs/clisp-2.49/clisp.exe
LISP_CLISP_RUNTIME=/C/programs/clisp-2.49/base/lisp.exe
HHC=/c/programs/hhw/hhc.exe
TCLKITSH=/c/programs/star/tclkitsh-8.6.3-win32-ix86.exe
TCLKIT_RUNTIME=/c/programs/star/tclkit-8.6.3-win32-ix86.exe
SDXKIT=/c/programs/star/sdx.kit
IMGKIT=/c/programs/star/img.kit
#ISCC=/c/Program\ Files/Inno\ Setup\ 5/iscc.exe
ISCC=/c/Program\ Files\ \(x86\)/Inno\ Setup\ 5/iscc.exe
WXMAXIMADIR=/c/programs/wxmaxima
GNUPLOTDIR=/c/programs/gnuplot
WINKILL64=/c/programs/winkill64

#### NO EDITING REQUIRED BELOW THIS LINE                       ####
####                                                           ####
###################################################################
###################################################################

EXTRA_ARGS=

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
if [ ! -f "$ISCC" ]; then
    echo "ERROR: iscc not fount!"
	exit 0
fi


MAKEVARS="TCLKITSH=\"$TCLKITSH\" TCLKIT_RUNTIME=\"$TCLKIT_RUNTIME\" SDXKIT=\"$SDXKIT\" IMGKIT=\"$IMGKIT\" WXMAXIMADIR=\"$WXMAXIMADIR\" GNUPLOTDIR=\"$GNUPLOTDIR\""

if [ $USE_LISP = "sbcl" ]; then
    if [ ! -e "$LISP_SBCL" ]; then
	echo "ERROR: sbcl not found! ($LISP_SBCL)"
	exit 0
    fi
    if [ -z "$SBCL_HOME" ]; then
	echo "Setting SBCL_HOME"
	export SBCL_HOME=`dirname "$LISP_SBCL"`
    fi
    LISP=--with-sbcl="$LISP_SBCL"
elif [ $USE_LISP = "ccl" ]; then
    if [ ! -e "$LISP_CCL" ]; then
	echo "ERROR: ccl not found!"
	exit 0
    fi
    LISP=--with-ccl="$LISP_CCL"
else
    if [ ! -e "$LISP_CLISP" ]; then
	echo "ERROR: clisp not found!"
	exit 0
    fi
    if [ ! -e "$LISP_CLISP_RUNTIME" ]; then
	echo "ERROR: clisp runtime not found!"
	exit 0
    fi
    LISP=--with-clisp="$LISP_CLISP"
    EXTRA_ARGS=--with-clisp-runtime="$LISP_CLISP_RUNTIME"
fi

LANGS=
for l in $TRANSLATIONS
do
    LANGS="$LANGS --enable-lang-$l"
done

# Make sure texi files are in unix format
#find . -name "*.texi" | xargs dos2unix

./configure --prefix=$PREFIX  \
     --enable-chm             \
     --with-hhc="$HHC"        \
     --enable-xmaxima-exe     \
     $LANGS                   \
     $EXTRA_ARGS              \
     "$LISP"

make $MAKEVARS
make install $MAKEVARS

if [ $WIN64 == "true" ]; then
	echo ""
	echo "Replacing winkill and winkill_lib.dll"
	echo ""
	cp -f $WINKILL64/winkill.exe $PREFIX/bin/
	cp -f $WINKILL64/winkill_lib.dll $PREFIX/bin/
fi

make iss $MAKEVARS

"$ISCC" maxima.iss
