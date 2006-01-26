/* -*- c -*-
    $Id: device.swg,v 1.1 2006/01/25 04:32:39 rocky Exp $

    Copyright (C) 2006 Rocky Bernstein <rocky@panix.com>

    This program is free software; you can redistribute it and/or modify
    it under the terms of the GNU General Public License as published by
    the Free Software Foundation; either version 2 of the License, or
    (at your option) any later version.

    This program is distributed in the hope that it will be useful,
    but WITHOUT ANY WARRANTY; without even the implied warranty of
    MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
    GNU General Public License for more details.

    You should have received a copy of the GNU General Public License
    along with this program; if not, write to the Free Software
    Foundation, Inc., 59 Temple Place, Suite 330, Boston, MA  02111-1307  USA
*/
/* See <cdio/device.h> for more extensive documentation. */

%include "device_const.swg"

%rename cdio_close_tray close_tray;
%feature("autodoc", 
"close_tray(drive=None, driver_id=None) -> [status, driver_id]

close media tray in CD drive if there is a routine to do so. 
The driver id is returned. An exception is thrown on error.");
%apply int *INOUT { driver_id_t *p_driver_id };
driver_return_code_t cdio_close_tray(const char *psz_drive=NULL, 
				     driver_id_t *p_driver_id=NULL);

%rename cdio_destroy close;
%feature("autodoc",
"destroy(p_cdio)
Free resources associated with p_cdio.  Call this when done using
using CD reading/control operations for the current device.
");
void cdio_destroy(CdIo_t *p_cdio);

%feature("autodoc",
"eject_media(cdio)->return_code

Eject media in CD drive if there is a routine to do so. 
");
driver_return_code_t eject_media (CdIo_t *p_cdio);
%inline %{
driver_return_code_t 
eject_media (CdIo_t *p_cdio) 
{
  /* libcdio routines uses a Cdio_t **p_cdio, so we have to pass in
     something it can clobber.
   */
  CdIo_t **pp_cdio = &p_cdio;
  return cdio_eject_media (pp_cdio);
}
%}


%rename cdio_eject_media_drive eject_media_drive;
%feature("autodoc", 
"eject_media_drive(drive=None)->return_code
Eject media in CD drive if there is a routine to do so. 
  
psz_drive: the name of the device to be acted upon. 
The operation status is returned.");
driver_return_code_t cdio_eject_media_drive (const char *psz_drive=NULL);

%rename cdio_get_arg get_arg;
%feature("autodoc",
"get_arg(p_cdio, key)->string

 Get the value associatied with key.");
const char *cdio_get_arg (const CdIo_t *p_cdio, const char key[]);

%newobject cdio_get_default_device; // free malloc'd return value
%rename cdio_get_default_device get_device; 
%feature("autodoc",
"get_device(cdio)->str

Get the CD device associated with cdio.
If cdio is NULL (we haven't initialized a specific device driver), 
then find a suitable one and return the default device for that.
    
In some situations of drivers or OS's we can't find a CD device if
there is no media in it and it is possible for this routine to return
None even though there may be a hardware CD-ROM.");
char *cdio_get_default_device (const CdIo_t *p_cdio=NULL);

%newobject get_default_device_driver; // free malloc'd return value
%feature("autodoc",
"get_default_device_driver(driver_id=None)->[device, driver]
Return a string containing the default CD device if none is specified.
if p_driver_id is DRIVER_UNKNOWN or DRIVER_DEVICE then find a suitable
one set the default device for that.
    
None is returned as the device if we couldn't get a default device.");
char *get_default_device_driver (driver_id_t p_driver_id=DRIVER_DEVICE);
%inline %{
char *
get_default_device_driver(driver_id_t driver_id) 
{
  /* In libcdio we can return the driver_id. Don't
     know how to easily do that here yet.
   */
  return cdio_get_default_device_driver(&driver_id);
}
%}

%rename cdio_get_drive_cap get_drive_cap;
%feature("autodoc",
"get_drive_cap()->(read_cap, write_cap, misc_cap)

Get drive capabilities of device.

In some situations of drivers or OS's we can't find a CD device if
there is no media in it. In this situation capabilities will show up as 
empty even though there is a hardware CD-ROM.");
%apply int *OUTPUT { unsigned int *p_read_cap, 
                     unsigned int *p_write_cap, 
                     unsigned int *p_misc_cap };
void cdio_get_drive_cap (const CdIo_t *p_cdio, 
			 unsigned int *p_read_cap, 
			 unsigned int *p_write_cap, 
			 unsigned int *p_misc_cap);
  
%rename cdio_get_drive_cap_dev get_drive_cap;
%feature("autodoc",
"get_drive_cap_dev()->(read_cap, write_cap, misc_cap)

Get drive capabilities of device.

In some situations of drivers or OS's we can't find a CD device if
there is no media in it. In this situation capabilities will show up as 
empty even though there is a hardware CD-ROM.");

void cdio_get_drive_cap_dev(const char *device=NULL, 
			    unsigned int *p_read_cap, 
			    unsigned int *p_write_cap, 
			    unsigned int *p_misc_cap);
  
%rename cdio_get_driver_name get_driver_name;
%feature("autodoc",
"get_driver_name(cdio)-> string

return a string containing the name of the driver in use.

An IOError exception is raised on error.
");
%exception cdio_get_driver_name {
  $action
    if (NULL == result) {
      PyErr_SetString(PyExc_IOError, "Error getting driver name.");
      return NULL;
    }
}
const char *cdio_get_driver_name (const CdIo_t *p_cdio);

%rename cdio_get_driver_id get_driver_id;
%feature("autodoc",
"get_driver_id(cdio)-> int

Return the driver id of the driver in use.
if cdio has not been initialized or is None, 
return pycdio.DRIVER_UNKNOWN.");
driver_id_t cdio_get_driver_id (const CdIo_t *p_cdio);

%rename cdio_get_last_session get_last_session;
%feature("autodoc",
"get_last_session(p_cdio) -> int
Get the LSN of the first track of the last session of on the CD.
An exception is thrown on error.");
%apply int *OUTPUT { lsn_t *i_last_session };
driver_return_code_t cdio_get_last_session (CdIo_t *p_cdio, 
					    lsn_t *i_last_session);

%feature("autodoc",
"have_driver(driver_id) -> int

Return 1 if we have driver driver_id, 0 if not and -1 
if driver id is out of range.");
%inline %{
int
have_driver (unsigned int driver_id)
{
  if (driver_id < CDIO_MIN_DRIVER || driver_id > CDIO_MAX_DRIVER)
    return -1;
  if (cdio_have_driver(driver_id)) return 1;
  return 0;
}
%}
  
%feature("autodoc", 
"have_ATAPI(CdIo_t *p_cdio)->bool
return True if CD-ROM understand ATAPI commands.");
%inline %{
/*! True if CD-ROM understand ATAPI commands. */
bool 
have_ATAPI (CdIo_t *p_cdio)
{
  return cdio_have_atapi(p_cdio) == yep;
}
%}

%newobject cdio_is_binfile; // free malloc'd return value
%rename cdio_is_binfile is_binfile;
%feature("autodoc",
"is_binfile(binfile_name)->cue_name

Determine if binfile_name is the BIN file part of a CDRWIN CD disk
image.

Return the corresponding CUE file if bin_name is a BIN file or
None if not a BIN file.");
char *cdio_is_binfile(const char *bin_name);

%newobject cdio_is_cuefile; // free malloc'd return value
%rename cdio_is_cuefile is_cuefile;
%feature("autodoc",
"is_cuefile(cuefile_name)->bin_name

Determine if cuefile_name is the CUE file part of a CDRWIN CD disk
image.

Return the corresponding BIN file if bin_name is a CUE file or
None if not a CUE file.");
char *cdio_is_cuefile(const char *cue_name);

%rename cdio_is_device is_device;
%feature("autodoc",
"is_device(source, driver_id=None)->bool
Return True if source refers to a real hardware CD-ROM.");
bool cdio_is_device(const char *psz_source, 
		    driver_id_t driver_id=DRIVER_UNKNOWN);

%rename cdio_is_nrg is_nrg;
%newobject cdio_is_nrg; // free malloc'd return value
%feature("autodoc",
"is_nrg(cue_name)->bool

Determine if nrg_name is a Nero CD disc image");
bool cdio_is_nrg(const char *nrg_name);

%rename cdio_is_tocfile is_tocfile;
%feature("autodoc",
"is_tocfile(tocfile_name)->bool

Determine if tocfile_name is a cdrdao CD disc image");
bool cdio_is_tocfile(const char *tocfile_name);

%rename cdio_get_media_changed get_media_changed;
%feature("autodoc",
"get_media_changed(cdio) -> int

Find out if media has changed since the last call.
Return 1 if media has changed since last call, 0 if not. Error
return codes are the same as driver_return_code_t");
int cdio_get_media_changed(CdIo_t *p_cdio);

#if 0
%exception get_hwinfo {
  $action
    if (!b_got_hwinfo) {
      PyErr_SetString(PyExc_IOError, "error getting device hardware info.");
      return NULL;
    }
}
%feature("autodoc",
"get_hwinfo(p_cdio)->[vendor, model, release]
Get the CD-ROM hardware info via a SCSI MMC INQUIRY command.
An exception is raised if we had an error.");
%cstring_output_allocate(char **s, free(*$1));
void get_hwinfo ( const CdIo_t *p_cdio, 
		  char **s, char **s, char **s );
#endif

%rename cdio_set_blocksize set_blocksize;
%feature("autodoc", 
"set_blocksize(cdio, blocksize)->return_status

Set the blocksize for subsequent reads.");
driver_return_code_t cdio_set_blocksize ( const CdIo_t *p_cdio, 
					  int i_blocksize );

%rename cdio_set_speed set_speed;
%feature("autodoc", 
"cdio_set_speed(cdio, speed)->return_status
Set the drive speed.");
driver_return_code_t cdio_set_speed ( const CdIo_t *p_cdio, int i_speed );


/** FIXME: the below works, but is clunky. 

    In the next release of libcdio (or CVS right now) we have a way to
    get the strings from the exception code so we don't need the switch
    statement.
*/
%exception {
  $action
  if (DRIVER_OP_SUCCESS == drc) goto out;
  set_python_errstring(drc);
  return NULL;
 out: ;
}


/*=================================================================*
  NOTE: ALL ROUTINES DEFINED BELOW CAN GIVE A DRIVER_RETURN_CODE_T 
  EXCEPTION.
*=================================================================*/

/**** Using the name open() conflicts with some C routine.
      So we use open_cd() instead.
***/
%feature("autodoc",
"open_cd(source=NULL, driver_id=None, access_mode=None)

Sets up to read from place specified by source, driver_id and
access mode. This should be called before using any other routine
except those that act on a CD-ROM drive by name. 

If None is given as the source, we'll use the default driver device.
If None is given as the driver_id, we'll find a suitable device driver.

Return the a pointer than can be used in subsequent operations or 
None on error or no device.");
CdIo_t *open_cd(const char *psz_source=NULL, 
		driver_id_t driver_id=DRIVER_UNKNOWN, 
		const char *psz_access_mode=NULL);

%inline %{

/* FIXME: Instead of a static variable drc which doesn't allow for
   multiple threads, we should change the C code to return the status
   parameter and have the exception handling code work off of this.
   Although this is easily done in C and the SWIG-generated C wrapper
   code, I don't the SWIG lingo to make the generated C wrapper do
   this.

   Basically, we need a way to tell SWIG not to translate the %inline
   C code return value into a Python return value, but save the value
   anyway to pick it value up in the SWIG %exception.
*/
static driver_return_code_t drc = DRIVER_OP_SUCCESS;

static void 
set_python_errstring(driver_return_code_t drc) 
{
  switch(drc) {
    case DRIVER_OP_SUCCESS: 
      break;
    case DRIVER_OP_ERROR:
      PyErr_SetString(PyExc_IOError, "driver I/O error.");
      break;
    case DRIVER_OP_UNINIT:
      PyErr_SetString(PyExc_IOError, "driver not initialized.");
      break;
    case DRIVER_OP_UNSUPPORTED:
      PyErr_SetString(PyExc_IOError, "driver operatation not supported.");
      break;
    case DRIVER_OP_NOT_PERMITTED:
      PyErr_SetString(PyExc_IOError, "driver operatation not permitted.");
      break;
    case DRIVER_OP_BAD_PARAMETER:
      PyErr_SetString(PyExc_IOError, "bad parameter passed.");
      break;
    case DRIVER_OP_BAD_POINTER:
      PyErr_SetString(PyExc_IOError, "bad pointer to memory area.");
      break;
    case DRIVER_OP_NO_DRIVER:
      PyErr_SetString(PyExc_IOError, "driver not available.");
      break;
    default:
      PyErr_SetString(PyExc_IOError, "unknown error.");
      break;
  }
 }
 
CdIo_t *open_cd(const char *psz_source, driver_id_t driver_id, 
		const char *psz_access_mode) {
  /* FIXME: On error we return a funny "NULL" Object.
   */
  CdIo_t *p_cdio = cdio_open_am(psz_source, driver_id, psz_access_mode);
  if (NULL == p_cdio) {
    drc = DRIVER_OP_BAD_PARAMETER;
  } else {
    drc = DRIVER_OP_SUCCESS;
  }
  return p_cdio;
 }

#if 0
static bool b_got_hwinfo;
void get_hwinfo ( const CdIo_t *p_cdio, 
		  char **psz_vendor, char **psz_model, char **psz_revision ) 
{
  cdio_hwinfo_t hw_info;
  b_got_hwinfo = cdio_get_hwinfo(p_cdio, &hw_info);
  printf("+++ b_got_hwinfo: %d, vendor: %s, model: %s, rev: %s\n",
	 b_got_hwinfo, 
	 hw_info.psz_vendor, hw_info.psz_model, hw_info.psz_revision);
	 
  if (b_got_hwinfo) {
    *psz_vendor   = strdup(hw_info.psz_vendor);
    *psz_model    = strdup(hw_info.psz_model);
    *psz_revision = strdup(hw_info.psz_revision);
  }
}
#endif
%}