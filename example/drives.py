#!/usr/bin/python
"""Program to read CD blocks. See read-cd from the libcdio distribution
for a more complete program."""

#
#    Copyright (C) 2006, 2008, 2011, 2013 Rocky Bernstein <rocky@gnu.org>
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

import os, sys
libdir = os.path.join(os.path.dirname(__file__), '..')
if libdir[-1] != os.path.sep:
    libdir += os.path.sep
sys.path.insert(0, libdir)
import pycdio
import cdio

def print_drive_class(msg, bitmask, any_capability):
    """ run and show output of cdio.get_devices_with_cap() """
    drives = cdio.get_devices_with_cap(bitmask, any_capability)

    print("%s..." % msg)
    for d in drives: print("Drive %s" % d)
    print("-----")

cd_drives = cdio.get_devices(pycdio.DRIVER_DEVICE)
for drive in cd_drives: 
    print("Drive %s" % drive)

print("-----")

print_drive_class("All CD-ROM drives (again)", pycdio.FS_MATCH_ALL, False)
print_drive_class("All CD-DA drives...", pycdio.FS_AUDIO, False)
print_drive_class("All drives with ISO 9660...", pycdio.FS_ISO_9660, False)
print_drive_class("VCD drives...", 
                  (pycdio.FS_ANAL_SVCD|pycdio.FS_ANAL_CVD|
                   pycdio.FS_ANAL_VIDEOCD|pycdio.FS_UNKNOWN), True)
