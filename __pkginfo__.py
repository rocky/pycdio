# Copyright (C) 2006, 2008-2009, 2013, 2016, 2018 Rocky Bernstein <rocky@gnu.org>
#
#  This program is free software: you can redistribute it and/or modify
#  it under the terms of the GNU General Public License as published by
#  the Free Software Foundation, either version 3 of the License, or
#  (at your option) any later version.
#
#  This program is distributed in the hope that it will be useful,
#  but WITHOUT ANY WARRANTY; without even the implied warranty of
#  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
#  GNU General Public License for more details.
#
#  You should have received a copy of the GNU General Public License
#  along with this program.  If not, see <http://www.gnu.org/licenses/>.
"""pycdio packaging information"""

modname = 'pycdio'

# VERSION.py sets variable VERSION.
import os.path
exec(compile(open(os.path.join(os.path.dirname(__file__),
                               'VERSION.py')).read(),
             os.path.join(os.path.dirname(__file__), 'VERSION.py'), 'exec'))

license   = 'GPL'
copyright = '''Copyright (C) 2006, 2008-2010, 2013, 2018 Rocky Bernstein <rocky@gnu.org>.'''

short_desc = 'Python OO interface to libcdio (CD Input and Control library)'

author = "Rocky Bernstein"
author_email = "rocky@gnu.org"

web = 'http://www.gnu.org/software/libcdio'
ftp = "ftp://ftp.gnu.org/pub/gnu/libcdio/%s-%s.tar.gz" % (modname, VERSION)
mailinglist = "mailto:libcdio-pycdio-devel@gnu.org"

classifiers =  ['Development Status :: 5 - Production/Stable',
                'Intended Audience :: Developers',
                'License :: OSI Approved :: GNU General Public License (GPL)',
                'Programming Language :: Python',
                'Programming Language :: Python :: 2.4',
                'Programming Language :: Python :: 2.5',
                'Programming Language :: Python :: 2.6',
                'Programming Language :: Python :: 2.7',
                'Programming Language :: Python :: 3',
                'Programming Language :: Python :: 3.2',
                'Programming Language :: Python :: 3.3',
                'Programming Language :: Python :: 3.4',
                'Programming Language :: Python :: 3.5',
                'Programming Language :: Python :: 3.6',
                'Programming Language :: Python :: 3.7',
                ]
