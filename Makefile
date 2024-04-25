# Compatibility for us old-timers.

# Note: This makefile include remake-style target comments.
# These comments before the targets start with #:
# remake --tasks to shows the targets and the comments

PHONY=build check clean dist distclean test
GIT2CL ?= git2cl
PYTHON ?= python

#: Default target. Same as "build"
all: build

#: Run all tests
check:  build
	./setup.py nosetests

#: Remove OS- and platform-specific derived files.
clean:
	$(PYTHON) ./setup.py clean --all && rm -f *.so || /bin/true
	$(RM) -r wheelhouse

#: Create source and binary distribution
dist:
	$(PYTHON) ./setup.py sdist bdist

#: Do what it takes to build software locally
build:
	$(PYTHON) ./setup.py build

# It is too much work to figure out how to add a new command to distutils
# to do the following. I'm sure distutils will someday get there.
DISTCLEAN_FILES = build dist *.egg-info *.pyc *.so *.dll py*.py \
		  swig/cdtext.swg pycdio.py pyiso9660.py \
                  example/*.pyc example/copying swig/py*_wrap.c test/*.pyc

#: Remove all derived files. Like "clean" on steroids.
distclean: clean
	-rm -fr $(DISTCLEAN_FILES) || true

#: Install package
install:
	$(PYTHON) ./setup.py install

#: Same as check
test: check

#: create ChangeLog fom git log via git2cl
ChangeLog:
	git log --pretty --numstat --summary | $(GIT2CL) >$@

.PHONY: $(PHONY)
