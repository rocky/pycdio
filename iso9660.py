#!/usr/bin/python
#
#    $Id: iso9660.py,v 1.5 2006/03/23 17:18:14 rocky Exp $
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

class ISO9660:
    """ """
    class IFS:
        """ISO 9660 Filesystem image reading"""
        pass

    def __init__(self, source=None, iso_mask=pyiso9660.EXTENSION_NONE):

        """Create a new ISO 9660 object.  If source is given, open()
        is called using that and the optional iso_mask parameter;
        iso_mask is used only if source is specified.  If source is
        given but opening fails, undef is returned.  If source is not
        given, an object is always returned."""

        self.iso9660 = None
        if source is not None:
            self.open(source, iso_mask)

    def close(self):
        """close(self)->bool

        Close previously opened ISO 9660 image and free resources associated
        with ISO9660.  Call this when done using using an ISO 9660 image."""

        if self.iso9660 is not None:
            pyiso9660.close(self.iso9660)
        else:
            print "***No object to close"
        self.iso9660 = None

    def find_lsn(self, lsn):
        """find_lsn(self, lsn)->[stat_href]

        Find the filesystem entry that contains LSN and 
        return file stat information about it. None is returned on error."""

        if pycdio.VERSION_NUM <= 76:
            print "*** Routine available only in libcdio versions >= 0.76"
            return None
        
        filename, LSN, size, sec_size, is_dir = \
                  pyiso9660.ifs_find_lsn(self.iso9660, $lsn);
        return stat_array_to_href(filename, LSN, size, sec_size, is_dir)
    

    def sub get_application_id(self):
        """get_application_id(self)->id
    
        Get the application ID stored in the Primary Volume Descriptor.
        None is returned if there is some problem."""

        return pyiso9660.ifs_get_application_id(self.iso9660)

    def get_preparer_id(self):
        """get_preparer_id(self)->id

        Get the preparer ID stored in the Primary Volume Descriptor.
        None is returned if there is some problem."""

        return pyiso9660.ifs_get_preparer_id(self.iso9660)


    def get_publisher_id(self):
        """get_publisher_id()->id

        Get the publisher ID stored in the Primary Volume Descriptor.
        undef is returned if there is some problem."""

        return pyiso9660.ifs_get_publisher_id(self.iso9660)

    def get_root_lsn(self):
        """get_root_lsn(self)->lsn

        Get the Root LSN stored in the Primary Volume Descriptor.
        undef is returned if there is some problem."""

        return pyiso9660.ifs_get_root_lsn(self.iso9660)

    def get_system_id(self):
        """get_system_id(self)->id

        Get the Volume ID stored in the Primary Volume Descriptor.
        undef is returned if there is some problem."""

        return pyiso9660.ifs_get_system_id(self.iso9660)

    def get_volume_id(self):
        """get_volume_id()->id
        
        Get the Volume ID stored in the Primary Volume Descriptor.
        undef is returned if there is some problem."""
        
        return pyiso9660.ifs_get_volume_id(self.iso9660)

    def get_volumeset_id(self):
        """get_volume_id(self)->id

        Get the Volume ID stored in the Primary Volume Descriptor.
        undef is returned if there is some problem."""

        return pyiso9660.ifs_get_volumeset_id(self.iso9660);

    def open(self, source, iso_mask=pyiso9660::EXTENSION_MODE):
        """open(source, iso_mask=pyiso9660::EXTENSION_NONE)->bool

        Open an ISO 9660 image for reading. Subsequent operations will read
        from this ISO 9660 image.
        
        This should be called before using any other routine except possibly
        new. It is implicitly called when a new is done specifying a source.
        
        If device object was previously opened it is closed first.
        
        See also open_fuzzy."""

        if self.iso9660 is not None: self.close() 

        self.iso9660 = pyiso9660.open_ext(source, iso_mask)
        return self.iso9660 is not None
}

"""
=pod

=head2 open_fuzzy

open_fuzzy(source, iso_mask=$libiso9660::EXTENSION_NONE, fuzz=20)->bool

Open an ISO 9660 image for reading. Subsequent operations will read
from this ISO 9660 image. Some tolerence allowed for positioning the
ISO9660 image. We scan for $pyiso9660.STANDARD_ID and use that to
set the eventual offset to adjust by (as long as that is <= $fuzz).

This should be called before using any other routine except possibly
new (which must be called first. It is implicitly called when a new is
done specifying a source.

See also open.

=cut

sub open_fuzzy {
    my($self,@p) = @_;
    my($source, $iso_mask, $fuzz) = 
	_rearrange(['SOURCE', 'ISO_MASK', 'FUZZ'], @p);
    
    self.close() if defined(self.iso9660);
    $iso_mask = $pyiso9660.EXTENSION_NONE if !defined($iso_mask);

    if (!defined($fuzz)) {
	$fuzz = 20;
    } elsif ($fuzz !~ m{\A\d+\Z}) {
	print "*** Expecting fuzz to be an integer; got '$fuzz'\n";
	return 0;
    }

    self.iso9660 = pyiso9660.open_fuzzy_ext($source, $iso_mask, $fuzz);
    return defined(self.iso9660);
}

=pod

=head2 read_fuzzy_superblock

read_fuzzy_superblock(iso_mask=$libiso9660::EXTENSION_NONE, fuzz=20)->bool

Read the Super block of an ISO 9660 image but determine framesize
and datastart and a possible additional offset. Generally here we are
not reading an ISO 9660 image but a CD-Image which contains an ISO 9660
filesystem.

=cut

sub read_fuzzy_superblock {
    my($self,@p) = @_;
    my($iso_mask, $fuzz) = 
	_rearrange(['ISO_MASK', 'FUZZ'], @p);
    
    $iso_mask = $pyiso9660.EXTENSION_NONE if !defined($iso_mask);

    if (!defined($fuzz)) {
	$fuzz = 20;
    } elsif ($fuzz !~ m{\A\d+\Z}) {
	print "*** Expecting fuzz to be an integer; got '$fuzz'\n";
	return 0;
    }

    return pyiso9660.ifs_fuzzy_read_superblock(self.iso9660,
						  $iso_mask, $fuzz);
}

=pod

=head2 readdir

readdir(dirname)->@iso_stat

Read path (a directory) and return a list of iso9660 stat references

Each item of @iso_stat is a hash reference which contains

=over 4

=item LSN 

the Logical sector number (an integer)

=item size 

the total size of the file in bytes

=item  sec_size 

the number of sectors allocated

=item  filename

the file name of the statbuf entry

=item XA

if the file has XA attributes; 0 if not

=item is_dir 

1 if a directory; 0 if a not;

=back

FIXME: If you look at iso9660.h you'll see more fields, such as for
Rock-Ridge specific fields or XA specific fields. Eventually these
will be added. Volunteers? 

=cut

sub readdir {
    my($self,@p) = @_;

    my($dirname, @args) = _rearrange(['DIRNAME'], @p);
    return undef if _extra_args(@args);

    if (!defined($dirname)) {
      print "*** A directory name must be given\n";
      return undef;
    }

    my @values = pyiso9660.ifs_readdir(self.iso9660, $dirname);

    # Remove the two input parameters
    splice(@values, 0, 2) if @values > 2;

    my @result = ();
    while (@values) {
	push @result, Device::Cdio::ISO9660::stat_array_to_href(@values);
	splice(@values, 0, 5);
    }	    
    return @result;
}

=pod

=head2 read_pvd

read_pvd()->pvd

Read the Super block of an ISO 9660 image. This is the Primary Volume
Descriptor (PVD) and perhaps a Supplemental Volume Descriptor if
(Joliet) extensions are acceptable.

=cut

sub read_pvd {
    my($self,@p) = @_;
    return 0 if !_check_arg_count($#_, 0);

    # FIXME call new on PVD object
    return pyiso9660.ifs_read_pvd(self.iso9660);
}

=pod

=head2 read_superblock

read_superblock(iso_mask=$libiso9660::EXTENSION_NONE)->bool

Read the Super block of an ISO 9660 image. This is the Primary Volume
Descriptor (PVD) and perhaps a Supplemental Volume Descriptor if
(Joliet) extensions are acceptable.

=cut

sub read_superblock {
    my($self,@p) = @_;
    my($iso_mask) = _rearrange(['ISO_MASK'], @p);
    
    $iso_mask = $pyiso9660.EXTENSION_NONE if !defined($iso_mask);

    return pyiso9660.ifs_read_superblock(self.iso9660, $iso_mask);
}

=pod 

=head2 seek_read

seek_read(start, size=1)->(size, str)

Seek to a position and then read n bytes. Size read is returned.

=cut

sub seek_read {
    my($self,@p) = @_;
    my($start, $size, @args) = _rearrange(['START', 'SIZE'], @p);
    return undef if _extra_args(@args);

    $size = 1 if !defined($size);
    
    (my $data, $size) = pyiso9660.seek_read(self.iso9660, $start, 
					       $size);
    return wantarray ? ($data, $size) : $data;
}

=pod

=head2 stat

stat(path, translate=0)->\%stat

Return file status for path name psz_path. NULL is returned on error.

If translate is 1,  version numbers in the ISO 9660 name are dropped, i.e. ;1
is removed and if level 1 ISO-9660 names are lowercased.

Each item of @iso_stat is a hash reference which contains

=over 4

=item LSN 

the Logical sector number (an integer)

=item size 

the total size of the file in bytes

=item  sec_size 

the number of sectors allocated

=item  filename

the file name of the statbuf entry

=item XA

if the file has XA attributes; 0 if not

=item is_dir 

1 if a directory; 0 if a not;

=back

=cut

sub stat {
    my($self, @p) = @_;
    my($path, $translate, @args) = _rearrange(['PATH', 'TRANSLATE'], @p);
    
    return undef if _extra_args(@args);
    $translate = 0 if !defined($translate);

    if (!defined($path)) {
      print "*** An ISO-9660 file path must be given\n";
      return undef;
    }

    my @values;
    if ($translate) {
	@values = pyiso9660.ifs_stat_translate(self.iso9660, $path);
    } else {
	@values = pyiso9660.ifs_stat(self.iso9660, $path);
    }

    # Remove the input parameters
    splice(@values, 0, 2) if @values > 2;

    return undef if !@values;
    return Device::Cdio::ISO9660::stat_array_to_href(@values);
}

"""
