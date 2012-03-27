/* -*- c -*-
  Copyright (C) 2009, Thomas Vander Stichele <thomas at apestaart dot org>

  This program is free software: you can redistribute it and/or modify
  it under the terms of the GNU General Public License as published by
  the Free Software Foundation, either version 3 of the License, or
  (at your option) any later version.

  This program is distributed in the hope that it will be useful,
  but WITHOUT ANY WARRANTY; without even the implied warranty of
  MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
  GNU General Public License for more details.

  You should have received a copy of the GNU General Public License
  along with this program.  If not, see <http://www.gnu.org/licenses/>.
*/

/* See <cdio/cdtext.h> For more extensive documentation */

%constant long int CDTEXT_ARRANGER   = CDTEXT_ARRANGER;
%constant long int CDTEXT_COMPOSER   = CDTEXT_COMPOSER;
%constant long int CDTEXT_DISCID     = CDTEXT_DISCID;
%constant long int CDTEXT_GENRE      = CDTEXT_GENRE;
%constant long int CDTEXT_MESSAGE    = CDTEXT_MESSAGE;
%constant long int CDTEXT_ISRC       = CDTEXT_ISRC;
%constant long int CDTEXT_PERFORMER  = CDTEXT_PERFORMER;
%constant long int CDTEXT_SIZE_INFO  = CDTEXT_SIZE_INFO;
%constant long int CDTEXT_SONGWRITER = CDTEXT_SONGWRITER;
%constant long int CDTEXT_TITLE      = CDTEXT_TITLE;
%constant long int CDTEXT_TOC_INFO   = CDTEXT_TOC_INFO;
%constant long int CDTEXT_TOC_INFO2  = CDTEXT_TOC_INFO2;
%constant long int CDTEXT_UPC_EAN    = CDTEXT_UPC_EAN;

%constant long int CDTEXT_INVALID    = CDTEXT_INVALID;
%constant long int MIN_CDTEXT_FIELD  = MIN_CDTEXT_FIELD;
%constant long int MAX_CDTEXT_FIELDS = MAX_CDTEXT_FIELDS;

typedef unsigned long int cdtext_field_t;

%feature("autodoc",
"cdtext_field2str(key)->string
Get the name of the key.");

const char *cdtext_field2str (cdtext_field_t key);

%feature("autodoc",
"cdtext_get(key, p_cdtext)->string
Get the value associated with key.");

const char *cdtext_get (cdtext_field_t key, const cdtext_t *cdtext);

%feature("autodoc",
"cdtext_is_keyword(string)->int
Returns enum value of keyword if the key is a CD-Text keyword,
returns MAX_CDTEXT_FIELDS otherwise.");

cdtext_field_t cdtext_is_keyword (const char *key);

%feature("autodoc",
"cdtext_set(key, string, p_cdtext)
Set the value associated with key.");

void cdtext_set (cdtext_field_t key, const char *value, cdtext_t *cdtext);


%rename cdio_get_cdtext get_cdtext;
%feature("autodoc",
"cdio_get_cdtext(track)->cdtext
    Get the CDText object for the given track number.
    Use track 0 for the disc's CDText object.");

cdtext_t *cdio_get_cdtext (CdIo_t *p_cdio, track_t i_track);

