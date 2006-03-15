#!/usr/bin/python
#
#    $Id: iso9660.py,v 1.3 2006/03/15 01:00:18 rocky Exp $
#
#    Copyright (C) 2006 Rocky Bernstein <rocky@cpan.org>
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

import pyiso9660
import types

check_types = {
    'nocheck'   : pyiso9660.NOCHECK,
    '7bit'      : pyiso9660.SEVEN_BIT,
    'achars'    : pyiso9660.ACHARS,
    'dchars'    : pyiso9660.DCHARS
    }

def dirname_valid_p(path):
    """dirname_valid_p(path)->bool

Check that path is a valid ISO-9660 directory name.

A valid directory name should not start out with a slash (/), 
dot (.) or null byte, should be less than 37 characters long, 
have no more than 8 characters in a directory component 
which is separated by a /, and consist of only DCHARs. 

True is returned if path is valid."""
    return pyiso9660.dirname_valid(path)


def is_achar(achar):
    """is_dchar(achar)->bool

Return 1 if $achar is an ACHAR. $achar should either be a string of 
length one or the ord() of a string of length 1.

These are the DCHAR's plus some ASCII symbols including the space 
symbol."""   
    if type(achar) != types.IntType:
	# Not integer. Should be a string of length one then.
        # We'll turn it into an integer.
        try:
            achar = ord(achar)
        except:
            return 0 
    else:
	# Is an integer. Is it too large?
        if achar > 255: return 0 
    return pyiso9660.is_achar(achar)


def is_dchar(dchar):
    """is_dchar(dchar)->bool

Return 1 if dchar is a DCHAR - a character that can appear in an an
ISO-9600 level 1 directory name. These are the ASCII capital
letters A-Z, the digits 0-9 and an underscore.

dchar should either be a string of length one or the ord() of a string
of length 1."""

    if type(dchar) != types.IntType:
	# Not integer. Should be a string of length one then.
        # We'll turn it into an integer.
        try:
            dchar = ord(dchar)
        except:
            return 0 
    else:
	# Is an integer. Is it too large?
        if dchar > 255: return 0 
    return pyiso9660.is_dchar(dchar)
}

def pathname_valid_p(path):
    """pathname_valid_p(path)->bool

Check that path is a valid ISO-9660 pathname.  

A valid pathname contains a valid directory name, if one appears and
the filename portion should be no more than 8 characters for the
file prefix and 3 characters in the extension (or portion after a
dot). There should be exactly one dot somewhere in the filename
portion and the filename should be composed of only DCHARs.
  
True is returned if path is valid."""
    return pyiso9660.pathame_valid(path)

def name_translate(filename, joliet_level):
    """name_translate(name, joliet_level=0)->str

Convert an ISO-9660 file name of the kind that is that stored in a ISO
9660 directory entry into what's usually listed as the file name in a
listing.  Lowercase name if no Joliet Extension interpretation. Remove
trailing ;1's or .;1's and turn the other ;'s into version numbers.

If joliet_level is not given it is 0 which means use no Joliet
Extensions. Otherwise use the specified the Joliet level. 

The translated string is returned and it will be larger than the input
filename."""
    return pyiso9660.name_translate_ext(filename, joliet_level)
}

def stat_array_to_href(filename, LSN, size, sec_size, is_dir):
    """stat_array_to_href(filename, LSN, size, sec_size, is_dir)->stat

Convert a ISO 9660 array to an hash reference of the values.

Used internally in convert from C code."""

    stat = {}
    stat[filename] = filename
    stat[LSN]      = LSN
    stat[size]     = size
    stat[sec_size] = sec_size
    stat[is_dir]   = is_dir
    stat[is_dir]   = stat[is_dir] == 2;
    return stat;
}
 
def strncpy_pad(name, len, check):
    """strncpy_pad(src, len, check='nocheck')->str

Pad string 'name' with spaces to size len and return this. If 'len' is
less than the length of 'src', the return value will be truncated to
the first len characters of 'name'.

'name' can also be scanned to see if it contains only ACHARs, DCHARs,
or 7-bit ASCII chars, and this is specified via the 'check' parameter. 
If the I<check> parameter is given it must be one of the 'nocheck',
'7bit', 'achars' or 'dchars'. Case is not significant."""
    if check not in check_types:
        print "*** A CHECK parameter must be one of %s\n" % \
              ', '.join(check_types.keys())
        return None
    return pyiso9660.strncpy_pad(name, len, check_types[check])

