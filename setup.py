#!/usr/bin/env python
"""
distutils setup (setup.py) for pycdio.

This gets a bit of package info from __pkginfo__.py file
"""

# Get the required package information
from __pkginfo__ import modname, version, license, short_desc, \
     web, author, author_email, classifiers

from setuptools import setup
from distutils.core import setup, Extension
from distutils.command.build import build
from subprocess import *

import os
import shutil

top_dir = os.path.dirname(os.path.abspath(__file__))
README  = os.path.join(top_dir, 'README.txt')

def rm_file(*paths):
  global top_dir
  toast = os.path.join(top_dir, *paths)
  try:
    os.remove(toast)
  except:
    pass
  return

# Description in package will come from the README file.
long_description = open(README).read() + '\n\n'

# We store swig sources in ./swig, but we want the generated python
# module not to appear in that directory, but instead in the top-level
# directory where we have the other modules. I'd move *all* of the modules
# to their own directory if I knew how to do that in distutils.
swig_opts        = ['-outdir', top_dir]

# Account for API change after 0.83
ge_84 = call(['pkg-config','--atleast-version=0.84','libcdio'])
if ge_84 is 0:
  print("libcdio version > 0.83")
  shutil.copy('swig/cdtext_new.swg','swig/cdtext.swg')
else:
  print("libcdio version <= 0.83")
  shutil.copy('swig/cdtext_old.swg','swig/cdtext.swg')
  print("Note: you should have SWIG installed to build this package")
  for filename in ('pyiso9660_wrap.c', 'pycdio_wrap.c'):
    rm_file('swig', filename)
    pass
  pass

# Reorder build commands such that swig generated files are also copied.
build.sub_commands = [('build_ext', build.has_ext_modules),
	('build_py', build.has_pure_modules),
	('build_clib', build.has_c_libraries),
	('build_scripts', build.has_scripts)]

# Find runtime library directories for libcdio and libiso9660 using
# pkg-config. Then create the right Extension object lists which later
# get fed into setup()'s list of ext_modules.
modules = []
for lib_name in ('libcdio', 'libiso9660'):
    short_libname = lib_name[3:] # Strip off "lib" from name

    # FIXME: DRY this code.
    try:
        p = Popen(['pkg-config', '--libs-only-L', lib_name], stdout=PIPE)
    except:
        print("** Error trying to run pkg-config. Is it installed?")
        print("** If not, see http://pkg-config.freedesktop.org")
        raise
        pass

    if p.returncode is None:
        # Strip off blanks and initial '-L'
        dirs = p.communicate()[0].split(b'-L')[1:]
        runtime_lib_dirs = [d.strip() for d in dirs]
    else:
        print(("** Didn't the normal return code running pkg-config," +
               "on %s. got:\n\t%s" % [lib_name, p.returncode]))
        print("** Will try to add %s anyway." % short_libname)
        runtime_lib_dirs = None
    library_dirs = runtime_lib_dirs
    p = Popen(['pkg-config', '--cflags-only-I', lib_name], stdout=PIPE)
    if p.returncode is None:
	# String starts '-I' so the first entry is ''; Discard that,
	# the others we want.
        dirs = p.communicate()[0].split(b'-I')[1:]
        include_dirs = [d.strip() for d in dirs]
    p = Popen(['pkg-config', '--libs-only-l', lib_name], stdout=PIPE)
    if p.returncode is None:
	# String starts '-l' so the first entry is ''; Discard that,
	# the others we want.
        dirs = p.communicate()[0].split(b'-l')[1:]
        libraries = [d.strip().decode("utf-8") for d in dirs]
        pass
    py_shortname = 'py' + short_libname
    modules.append(Extension('_' + py_shortname,
                             libraries = libraries,
                             swig_opts = swig_opts,
                             include_dirs=include_dirs,
                             library_dirs=library_dirs,
                             runtime_library_dirs=runtime_lib_dirs,
                             sources=['swig/%s.i' % py_shortname]))

setup (author             = author,
       author_email       = author_email,
       classifiers        = classifiers,
       description        = short_desc,
       ext_modules        = modules,
       license            = license,
       long_description   = long_description,
       name               = modname,
       py_modules         = ['cdio', 'iso9660', 'pycdio', 'pyiso9660'],
       test_suite         = 'nose.collector',
       url                = web,
       version            = version,
       )
