max_build.sh
=============

A [bash script][1] for building a [maxima](http://maxima.sf.net/)
installer on Windows.

[1]: https://raw.githubusercontent.com/andrejv/max_build.sh/master/max_build.sh

### Download dependencies

Several programs should be installed to build the installer.

* [MinGW+MSYS](http://mingw.org/)
* A lisp: either [sbcl](http://www.sbcl.org) or [ccl](http://ccl.clozure.com).
* [TclKit](http://tclkits.rkeene.org/fossil/wiki?name=Downloads):
`tclkit.exe` and `tclkitsh.exe`.  Download the binaries and put them
in `C:/programs/star`.
* [starkits](http://www.tcl.tk/starkits): `sdx.kit` and `img.kit`.
Download the starkits and put them in `C:/programs/star`.
* [gnuplot](http://gnuplot.info): tested with version 4.6.6.
Put the gnuplot directory in `C:/programs/`.
* [wxmaxima](http://andrejv.github.io/wxmaxima/):
put the wxMaxima binary directory in `C:/programs/`.
* [HTML Help Workshop](http://www.microsoft.com/en-us/download/details.aspx?id=21138):
download the file `htmlhelp.exe` and install it.
* [Python](http://www.python.org)
* [INNO Setup](http://www.jrsoftware.org/isinfo.php)

### Configure mingw/msys

Download `mingw-get-setup` and install it. During the installation you
will be asked which packages to install. Select at least:

* `mingw-developer-tools`
* `mingw32-base`
* `msys-base`

The mingw shell is usually started from `C:/MinGW/msys/1.0/msys.bat`.

### Running the shell script

Download the source for maxima and unarchive it. Put the script into
the root directory of the sources. Edit the script so that the
variables at the top of the script point to the correct
destinations. Run the script from a msys shell.
