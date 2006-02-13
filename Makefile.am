#   $Id: Makefile.am,v 1.9 2006/02/13 21:26:02 rocky Exp $
#
#    Copyright (C) 2006 Rocky Bernstein <rocky@panix.com>
#
#    This program is free software; you can redistribute it and/or modify
#    it under the terms of the GNU General Public License as published by
#    the Free Software Foundation; either version 2 of the License, or
#    (at your option) any later version.
#
#    This program is distributed in the hope that it will be useful,
#    but WITHOUT ANY WARRANTY; without even the implied warranty of
#    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#    GNU General Public License for more details.
#
#    You should have received a copy of the GNU General Public License
#    along with this program; if not, write to the Free Software
#    Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
#
## Process this file with automake to produce Makefile.in
##   which configure then turns into a Makefile  ...
##     which make can then use to produce stuff. Isn't configuration simple? 

SWIG := @SWIG@
SWIG_FLAGS := @SWIG_FLAGS@
PYTHON_LIBS := @PYTHON_LIBS@
SO   := @SO@

# Note pycdio.swg has to come first.
SWIG_SRC = $(top_srcdir)/swig/pycdio.swg     \
	$(top_srcdir)/swig/Makefile          \
	$(top_srcdir)/swig/audio.swg         \
	$(top_srcdir)/swig/compat.swg        \
	$(top_srcdir)/swig/device.swg        \
	$(top_srcdir)/swig/device_const.swg  \
	$(top_srcdir)/swig/disc.swg          \
	$(top_srcdir)/swig/read.swg          \
	$(top_srcdir)/swig/track.swg         \
	$(top_srcdir)/swig/types.swg 

TEST_FILES = \
	test/Makefile \
	test/cdda.bin \
	test/cdda.cue \
	test/cdda.toc \
	test/isofs-m1.bin \
	test/isofs-m1.cue

EXAMPLE_FILES = \
	example/Makefile \
	example/README \
	example/audio.py.in \
	example/cd-read.py.in \
	example/cdchange.py.in \
	example/device.py.in 
	example/eject.py.in \
	example/tracks.py.in

SWIG_OBJ := $(top_builddir)/pycdio_wrap.o
SWIG_C   := $(top_builddir)/pycdio_wrap.c

EXTRA_DIST = $(SWIG_SRC) $(TEST_FILES) $(EXAMPLE_FILES) \
	     cdio.py.in pycdio_wrap.c pycdio.py \
	     include-path.py site-packages-path.py setup.py ChangeLog.1

dist-hook:
	-rm $(top_distdir)/cdio.py $(top_distdir)/pycdio.py

pkgdata_DATA := _pycdio$(SO)
pkgdatadir = $(pythondir)

noinst_PYTHON = 
python_PYTHON := $(top_builddir)/pycdio.py $(top_builddir)/cdio.py

.PHONY: test check ChangeLog

all-am: _pycdio$(SO)

## I just can't take all the crap associated with libtool any more.
## Testing for C++, Fortran, compile and link options to those, 
## existence of C headers that aren't used, and that's just in the
## configuration section.
$(SWIG_OBJ): $(SWIG_C)
	$(CC) $(CFLAGS) $(libcdio_CFLAGS) -c $< -I@PYTHON_INC@

_pycdio$(SO): $(top_builddir)/pycdio.py $(SWIG_OBJ)
	$(LDSHARED) $(SWIG_OBJ) $(libcdio_LIBS) $(PYTHON_LIBS) -o $@

$(top_builddir)/pycdio.py: $(SWIG_SRC)
	$(SWIG) -o $(SWIG_C) -outdir $(top_builddir) -python $(SWIG_FLAGS) $<

$(SWIG_C): $(SWIG_SRC)
	$(SWIG) -o $(SWIG_C) -outdir $(top_builddir) -python $(SWIG_FLAGS) $<

check: test
test: test/cdiotest.py _pycdio$(SO)
	(cd test && python cdiotest.py --verbose)

clean-generic: 
	-rm $(SWIG_C) $(SWIG_OBJ) _pycdio$(SO) pycdio.py* cdio.pyc cdio.py

# From libtool documentation amended with guidance from N. Boullis: 
#
#  1. Start with version information of `0:0:0' for each libtool library.
#
#  2. It is probably not a good idea to update the version information 
#     several times between public releases, but rather once per public
#     release. (This seems to be more an aesthetic consideration than
#     a hard technical one.)
#
#  3. If the library source code has changed at all since the last
#     update, then increment REVISION (`C:R:A' becomes `C:R+1:A').
#
#  4. If any interfaces have been added, removed, or changed since the
#     last update, increment CURRENT, and set REVISION to 0.
#
#  5. If any interfaces have been added since the last public release,
#     then increment AGE.
#
#  6. If any interfaces have been removed or changed since the last
#     public release, then set AGE to 0. A changed interface means an
#     incompatibility with previous versions.

## pycdio_la_CURRENT := 0
## pybcdio_la_REVISION := 0
## pybcdio_la_AGE := 0

## pycdio_libnum := $(pycdio_la_CURRENT):$(pycdio_la_REVISION):$(pycdio_la_AGE)

##install-exec-hook:
##	$(LN_S) ${prefix}/lib/libpycdio$(SO).$(pycdio_libnum) ${prefix}/lib/pycdio$(SO)

# cvs2cl
MAINTAINERCLEANFILES = ChangeLog

if MAINTAINER_MODE

ChangeLog:
	$(CVS2CL) -W 450 --header $(srcdir)/cvs2cl_header --utc -w -I ChangeLog --usermap $(srcdir)/cvs2cl_usermap -P 

ACLOCAL_AMFLAGS=-I .

endif
