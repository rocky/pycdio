#!/usr/bin/python
#$Id: include-path.py,v 1.1 2006/01/25 04:32:38 rocky Exp $
"""Try to find where include-path is located.
"""
import os
import distutils.sysconfig
print distutils.sysconfig.get_python_inc().replace(os.sep,"/")
