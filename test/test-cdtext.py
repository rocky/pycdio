#!/usr/bin/env python
#  Copyright (C) 2015, 2021 Rocky Bernstein <rocky@gnu.org>
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

"""Unit test for cdtext."""

import unittest, sys, os

libdir = os.path.join(os.path.dirname(__file__), "..")
if libdir[-1] != os.path.sep:
    libdir += os.path.sep
sys.path.insert(0, libdir)
import pycdio
import cdio


class CDTextTests(unittest.TestCase):
    def test_keyword(self):
        """Test keywords"""
        self.assertEquals(
            pycdio.cdtext_field2str(pycdio.CDTEXT_FIELD_PERFORMER), "PERFORMER"
        )

    def test_get_set(self):
        """Test getting and setting CDText"""
        tocpath = os.path.join(os.path.dirname(__file__), "cdtext.toc")
        device = cdio.Device(tocpath, pycdio.DRIVER_CDRDAO)

        text = device.get_cdtext()
        self.assertEquals(text.get(pycdio.CDTEXT_FIELD_PERFORMER, 0), "Performer")
        self.assertEquals(text.get(pycdio.CDTEXT_FIELD_TITLE, 0), "CD Title")
        self.assertEquals(text.get(pycdio.CDTEXT_FIELD_DISCID, 0), "XY12345")

        self.assertEquals(text.get(pycdio.CDTEXT_FIELD_PERFORMER, 1), "Performer")
        self.assertEquals(text.get(pycdio.CDTEXT_FIELD_TITLE, 1), "Track Title")


if __name__ == "__main__":
    unittest.main()
