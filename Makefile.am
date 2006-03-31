#   $Id: Makefile.am,v 1.24 2006/03/31 06:57:02 rocky Exp $
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
#    Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA
#    02110-1301 USA.
#
## Process this file with automake to produce Makefile.in
##   which configure then turns into a Makefile  ...
##     which make can then use to produce stuff. Isn't configuration simple? 

SWIG := @SWIG@
SWIG_FLAGS := @SWIG_FLAGS@
PYTHON_LIBS := @PYTHON_LIBS@
SO   := @SO@

# Note pycdio.swg has to come first.
CDIO_SRC = $(top_srcdir)/swig/pycdio.swg     \
	$(top_srcdir)/swig/Makefile          \
	$(top_srcdir)/swig/audio.swg         \
	$(top_srcdir)/swig/compat.swg        \
	$(top_srcdir)/swig/device.swg        \
	$(top_srcdir)/swig/device_const.swg  \
	$(top_srcdir)/swig/disc.swg          \
	$(top_srcdir)/swig/read.swg          \
	$(top_srcdir)/swig/track.swg         \
	$(top_srcdir)/swig/types.swg 

ISO_SRC = $(top_srcdir)/swig/pyiso9660.swg   \
	  $(top_srcdir)/swig/compat.swg      \
	  $(top_srcdir)/swig/types.swg 

TEST_FILES = \
	test/Makefile \
	test/cdda.bin \
	test/cdda.cue \
	test/cdda.cue \
	test/cdda.toc \
	test/cdiotest.py.in \
	test/isofs-m1.bin \
	test/isofs-m1.cue \
	test/isocopy.py.in \
	test/isotest.py.in

DATA_FILES = data/copying.iso data/isofs-m1.cue data/isofs-m1.bin

EXAMPLE_FILES = \
	example/Makefile \
	example/README \
	example/audio.py.in \
	example/cd-read.py.in \
	example/cdchange.py.in \
	example/device.py.in 
	example/eject.py.in \
	example/iso1.py.in \
	example/iso2.py.in \
	example/iso3.py.in \
	example/tracks.py.in

CDIO_C   := $(top_builddir)/pycdio_wrap.c
CDIO_OBJ := $(top_builddir)/pycdio_wrap.o

ISO_C    := $(top_builddir)/pyiso9660_wrap.c
ISO_OBJ  := $(top_builddir)/pyiso9660_wrap.o

EXTRA_DIST = $(CDIO_SRC) $(ISO_SRC) $(TEST_FILES) \
	     $(EXAMPLE_FILES) $(DATA_FILES) \
	     pycdio_wrap.c pycdio.py pyiso9660.py cdio.py \
	     iso9660.py pyiso9660_wrap.c pyiso9660.py \
	     include-path.py site-packages-path.py setup.py ChangeLog.1 \
	     get-cygwin-python-libs

 dist-hook:
	-rm $(top_distdir)/cdio.py $(top_distdir)/pycdio.py

pkgdata_DATA := _pycdio$(SO) _pyiso9660$(SO)
pkgdatadir = $(pythondir)

noinst_PYTHON = 
python_PYTHON := $(top_builddir)/pycdio.py $(top_srcdir)/cdio.py \
	         $(top_builddir)/pyiso9660.py $(top_srcdir)/iso9660.py

.PHONY: test check ChangeLog

all-am: _pycdio$(SO) _pyiso9660$(SO)

## I just can't take all the crap associated with libtool any more.
## Testing for C++, Fortran, compile and link options to those, 
## existence of C headers that aren't used, and that's just in the
## configuration section.
$(CDIO_OBJ): $(CDIO_C)
	$(CC) $(CFLAGS) $(libcdio_CFLAGS) -c $< -I@PYTHON_INC@

$(ISO_OBJ): $(ISO_C)
	$(CC) $(CFLAGS) $(libiso9660_CFLAGS) -c $< -I@PYTHON_INC@

_pycdio$(SO): $(top_builddir)/pycdio.py $(CDIO_OBJ)
	$(LDSHARED) $(CDIO_OBJ) $(PYTHON_LIBS) $(libcdio_LIBS) -o $@

_pyiso9660$(SO): $(top_builddir)/pyiso9660.py $(ISO_OBJ)
	$(LDSHARED) $(ISO_OBJ) $(PYTHON_LIBS) $(libiso9660_LIBS) -o $@

$(top_builddir)/pycdio.py: $(CDIO_SRC)
	$(SWIG) -o $(CDIO_C) -outdir $(top_builddir) -python $(SWIG_FLAGS) $<

$(top_builddir)/pyiso9660.py: $(ISO_SRC)
	$(SWIG) -o $(ISO_C) -outdir $(top_builddir) -python $(SWIG_FLAGS) $<

$(CDIO_C): $(CDIO_SRC)
	$(SWIG) -o $(CDIO_C) -outdir $(top_builddir) -python $(SWIG_FLAGS) $<

$(ISO_C): $(ISO_SRC)
	$(SWIG) -o $(ISO_C) -outdir $(top_builddir) -python $(SWIG_FLAGS) $<

check: test
test: test/cdiotest.py _pycdio$(SO) _pyiso9660$(SO)
	(cd test && python cdiotest.py --verbose)
	(cd test && python isocopy.py --verbose)
	(cd test && python isotest.py --verbose)

clean-generic: 
	-rm $(CDIO_C) $(CDIO_OBJ) \
	$(ISO_C) $(ISO_OBJ) \
	_pycdio$(SO) pycdio.py* cdio.py? \
	_pyiso9660$(SO) pyiso9660.py* iso9660.py?

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
