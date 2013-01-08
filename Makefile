# Compatibility for us old-timers.
PHONY=check clean dist distclean test
all: build

#: Run all tests
check:  build
	nosetests

#: Remove OS- and platform-specific derived files. 
clean: 
	python ./setup.py clean --all

#: Create source and binary distribution
dist: 
	python ./setup.py sdist bdist

#: Do what it takes to build software locally
build: 
	python ./setup.py build

# It is too much work to figure out how to add a new command to distutils
# to do the following. I'm sure distutils will someday get there.
DISTCLEAN_FILES = build dist *.egg-info *.pyc *.so *.dll py*.py \
                  example/*.pyc example/COPYING swig/py*_wrap.c test/*.pyc 

#: Remove all derived files. Like "clean" on steroids.
distclean: clean
	-rm -fr $(DISTCLEAN_FILES) || true

#: Install package
install: 
	python ./setup.py install

#: Same as check
test: check

#: create ChangeLog fom git log via git2cl
ChangeLog:
	git log --pretty --numstat --summary | git2cl > $@

.PHONY: $(PHONY)
