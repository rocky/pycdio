# Compatibility for us old-timers.
PHONY=check clean dist distclean test
all: check
check: 
	nosetests
clean: 
	python ./setup.py $@
dist: 
	python ./setup.py sdist bdist

# It is too much work to figure out how to add a new command to distutils
# to do the following. I'm sure distutils will someday get there.
DISTCLEAN_FILES = build dist *.egg-info *.pyc *.so *.dll py*.py \
                  example/*.pyc example/COPYING swig/py*_wrap.c test/*.pyc 
distclean: clean
	-rm -fr $(DISTCLEAN_FILES) || true
install: 
	python ./setup.py install
test: check

ChangeLog:
	git log --pretty --numstat --summary | git2cl > $@

.PHONY: $(PHONY)
