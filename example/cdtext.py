#!/usr/bin/env python
"""Program to show cdtext, similar to examples/cdtext.c"""
#
#  Copyright (C) 2006, 2008, 2009, 2012 Rocky Bernstein <rocky@gnu.org>
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

import os, sys
libdir = os.path.join(os.path.dirname(__file__), '..')
if libdir[-1] != os.path.sep:
    libdir += os.path.sep
sys.path.insert(0, libdir)
import pycdio
import cdio

def print_cdtext_track_info_old(device, track, message):
    print(message)
    t = device.get_track(track)
    cdt = t.get_cdtext()

    for i in range(pycdio.MIN_CDTEXT_FIELDS, pycdio.MAX_CDTEXT_FIELDS):
        value = cdt.get(i)
        # value can be empty but exist, compared to NULL values
        if value is not None:
            print("\t%s: %s" % (pycdio.cdtext_field2str(i), value))
            pass
        pass
    return

def print_cdtext_info_new(device, message):
    print(message)
    cdt = device.get_cdtext()
    i_tracks = device.get_num_tracks()
    i_first_track = pycdio.get_first_track_num(device.cd)

    for t in range(i_first_track, i_tracks + i_first_track):
        for i in range(pycdio.MIN_CDTEXT_FIELD, pycdio.MAX_CDTEXT_FIELDS):
            value = cdt.get(i, t)
            # value can be empty but exist, compared to NULL values
            if value is not None:
                print("\t%s: %s" % (pycdio.cdtext_field2str(i), value))
                pass
            pass
        pass
    return

if sys.argv[1:]:
    try:
        drive_name = sys.argv[1]
        d = cdio.Device(sys.argv[1])
    except IOError:
        print("Problem opening CD-ROM: %s" % drive_name)
        sys.exit(1)
else:
    try:
        d = cdio.Device(driver_id=pycdio.DRIVER_UNKNOWN)
        drive_name = d.get_device()
    except IOError:
        print("Problem finding a CD-ROM")
        sys.exit(1)

if pycdio.VERSION_NUM < 83:
    i_tracks = d.get_num_tracks()
    i_first_track = pycdio.get_first_track_num(d.cd)
    print_cdtext_track_info_old(d, 0, 'CD-Text for Disc:')
    for i in range(i_first_track, i_tracks + i_first_track):
        print_cdtext_track_info_old(d, i, 'CD-Text for Track %d:' % i)
        pass
    pass
else:
    print_cdtext_info_new(d, 'CD-Text for disk')
    pass
