# Until I master distutils better. It's good to have this around
# as an alternative
#: makes all SWIG-derived C files. (setup.py build_ext also does this)
all: pycdio_wrap.c pyiso9660_wrap.c

#: SWIGs pycdio.i - the CDIO module
pycdio_wrap.c: pycdio.i
	swig -python -o pycdio_wrap.c pycdio.i

#: SWIGs pycdio.i - ISO9660 module
pyiso9660_wrap.c: pyiso9660.i
	swig -python -o pyiso9660_wrap.c pyiso9660.i

# It is too much work to figure out how to add a new command to distutils
# to do the following. 
CLEAN_FILES = *.pyc py*_wrap.c

#: Remove all derived files.
clean: clean
	rm -f $(CLEAN_FILES) || true

#: whatever else you want to do retry it in the parent Makefile.
%: pyiso
	$(MAKE) -C .. $@
