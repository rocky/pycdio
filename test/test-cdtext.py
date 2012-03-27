#!/usr/bin/env python
"""Unit test for cdtext."""

import unittest, sys, os

libdir = os.path.join(os.path.dirname(__file__), '..')
if libdir[-1] != os.path.sep:
    libdir += os.path.sep
sys.path.insert(0, libdir)
import pycdio
import cdio

class CDTextTests(unittest.TestCase):

    def test_keyword(self):
        """Test keywords"""
        if pycdio.VERSION_NUM > 83:
            self.assertEquals(pycdio.cdtext_field2str(
                pycdio.CDTEXT_FIELD_PERFORMER), "PERFORMER")
        else:
            self.assertEquals(pycdio.cdtext_field2str(pycdio.CDTEXT_PERFORMER),
                "PERFORMER")

    def test_get_set(self):
        """Test getting and setting CDText"""
        tocpath = os.path.join(os.path.dirname(__file__),
            "cdtext.toc")
        device = cdio.Device(tocpath, pycdio.DRIVER_CDRDAO)

        if pycdio.VERSION_NUM > 83:
            text = device.get_cdtext()
            self.assertEquals(text.get(pycdio.CDTEXT_FIELD_PERFORMER, 0), 'Performer')
            self.assertEquals(text.get(pycdio.CDTEXT_FIELD_TITLE, 0), 'CD Title')
            self.assertEquals(text.get(pycdio.CDTEXT_FIELD_DISCID, 0), 'XY12345')

            self.assertEquals(text.get(pycdio.CDTEXT_FIELD_PERFORMER, 1), 'Performer')
            self.assertEquals(text.get(pycdio.CDTEXT_FIELD_TITLE, 1), 'Track Title')

        else:
            disctext = device.get_track(0).get_cdtext()
            self.assertEquals(disctext.get(pycdio.CDTEXT_PERFORMER), 'Performer')
            self.assertEquals(disctext.get(pycdio.CDTEXT_TITLE), 'CD Title')
            self.assertEquals(disctext.get(pycdio.CDTEXT_DISCID), 'XY12345')

            track1text = device.get_track(1).get_cdtext()
            self.assertEquals(track1text.get(pycdio.CDTEXT_PERFORMER), 'Performer')
            self.assertEquals(track1text.get(pycdio.CDTEXT_TITLE), 'Track Title')

            track1text.set(pycdio.CDTEXT_PERFORMER, 'Someone')
            self.assertEquals(track1text.get(pycdio.CDTEXT_PERFORMER), 'Someone')

if __name__ == "__main__":
    unittest.main()
