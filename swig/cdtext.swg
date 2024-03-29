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

%feature("autodoc",1);

%constant int CDTEXT_ARRANGER              = CDTEXT_FIELD_ARRANGER;
%constant int CDTEXT_COMPOSER              = CDTEXT_FIELD_COMPOSER;
%constant int CDTEXT_DISCID                = CDTEXT_FIELD_DISCID;
%constant int CDTEXT_ISRC                  = CDTEXT_FIELD_ISRC;
%constant int CDTEXT_MESSAGE               = CDTEXT_FIELD_MESSAGE;
%constant int CDTEXT_PERFORMER             = CDTEXT_FIELD_PERFORMER;
%constant int CDTEXT_FIELD_TITLE           = CDTEXT_FIELD_TITLE;
%constant int CDTEXT_FIELD_SONGWRITER      = CDTEXT_FIELD_SONGWRITER;
%constant int CDTEXT_FIELD_UPC_EAN         = CDTEXT_FIELD_UPC_EAN;
%constant int CDTEXT_GENRE                 = CDTEXT_FIELD_GENRE;
%constant int CDTEXT_FIELD_INVALID         = CDTEXT_FIELD_INVALID;

%constant int CDTEXT_GENRE_UNUSED          = CDTEXT_GENRE_UNUSED;
%constant int CDTEXT_GENRE_UNDEFINED       = CDTEXT_GENRE_UNDEFINED;
%constant int CDTEXT_GENRE_ADULT_CONTEMP   = CDTEXT_GENRE_ADULT_CONTEMP;
%constant int CDTEXT_GENRE_ALT_ROCK        = CDTEXT_GENRE_ALT_ROCK;
%constant int CDTEXT_GENRE_CHILDRENS       = CDTEXT_GENRE_CHILDRENS;
%constant int CDTEXT_GENRE_CLASSIC         = CDTEXT_GENRE_CLASSIC;
%constant int CDTEXT_GENRE_CHRIST_CONTEMP  = CDTEXT_GENRE_CHRIST_CONTEMP;
%constant int CDTEXT_GENRE_COUNTRY         = CDTEXT_GENRE_COUNTRY;
%constant int CDTEXT_GENRE_DANCE           = CDTEXT_GENRE_DANCE;
%constant int CDTEXT_GENRE_EASY_LISTENING  = CDTEXT_GENRE_EASY_LISTENING;
%constant int CDTEXT_GENRE_EROTIC          = CDTEXT_GENRE_EROTIC;
%constant int CDTEXT_GENRE_FOLK            = CDTEXT_GENRE_FOLK;
%constant int CDTEXT_GENRE_GOSPEL          = CDTEXT_GENRE_GOSPEL;
%constant int CDTEXT_GENRE_HIPHOP          = CDTEXT_GENRE_HIPHOP;
%constant int CDTEXT_GENRE_JAZZ            = CDTEXT_GENRE_JAZZ;
%constant int CDTEXT_GENRE_LATIN           = CDTEXT_GENRE_LATIN;
%constant int CDTEXT_GENRE_MUSICAL         = CDTEXT_GENRE_MUSICAL;
%constant int CDTEXT_GENRE_NEWAGE          = CDTEXT_GENRE_NEWAGE;
%constant int CDTEXT_GENRE_OPERA           = CDTEXT_GENRE_OPERA;
%constant int CDTEXT_GENRE_OPERETTA        = CDTEXT_GENRE_OPERETTA;
%constant int CDTEXT_GENRE_POP             = CDTEXT_GENRE_POP;
%constant int CDTEXT_GENRE_RAP             = CDTEXT_GENRE_RAP;
%constant int CDTEXT_GENRE_REGGAE          = CDTEXT_GENRE_REGGAE;
%constant int CDTEXT_GENRE_ROCK            = CDTEXT_GENRE_ROCK;
%constant int CDTEXT_GENRE_RYTHMANDBLUES   = CDTEXT_GENRE_RYTHMANDBLUES;
%constant int CDTEXT_GENRE_SOUNDEFFECTS    = CDTEXT_GENRE_SOUNDEFFECTS;
%constant int CDTEXT_GENRE_SOUNDTRACK      = CDTEXT_GENRE_SOUNDTRACK;
%constant int CDTEXT_GENRE_SPOKEN_WORD     = CDTEXT_GENRE_SPOKEN_WORD;
%constant int CDTEXT_GENRE_WORLD_MUSIC     = CDTEXT_GENRE_WORLD_MUSIC;

%constant int CDTEXT_LANGUAGE_UNKNOWN      = CDTEXT_LANGUAGE_UNKNOWN;
%constant int CDTEXT_LANGUAGE_ALBANIAN     = CDTEXT_LANGUAGE_ALBANIAN;
%constant int CDTEXT_LANGUAGE_BRETON       = CDTEXT_LANGUAGE_BRETON;
%constant int CDTEXT_LANGUAGE_CATALAN      = CDTEXT_LANGUAGE_CATALAN;
%constant int CDTEXT_LANGUAGE_CROATIAN     = CDTEXT_LANGUAGE_CROATIAN;
%constant int CDTEXT_LANGUAGE_WELSH        = CDTEXT_LANGUAGE_WELSH;
%constant int CDTEXT_LANGUAGE_CZECH        = CDTEXT_LANGUAGE_CZECH;
%constant int CDTEXT_LANGUAGE_DANISH       = CDTEXT_LANGUAGE_DANISH;
%constant int CDTEXT_LANGUAGE_GERMAN       = CDTEXT_LANGUAGE_GERMAN;
%constant int CDTEXT_LANGUAGE_ENGLISH      = CDTEXT_LANGUAGE_ENGLISH;
%constant int CDTEXT_LANGUAGE_SPANISH      = CDTEXT_LANGUAGE_SPANISH;
%constant int CDTEXT_LANGUAGE_ESPERANTO    = CDTEXT_LANGUAGE_ESPERANTO;
%constant int CDTEXT_LANGUAGE_ESTONIAN     = CDTEXT_LANGUAGE_ESTONIAN;
%constant int CDTEXT_LANGUAGE_BASQUE       = CDTEXT_LANGUAGE_BASQUE;
%constant int CDTEXT_LANGUAGE_FAROESE      = CDTEXT_LANGUAGE_FAROESE;
%constant int CDTEXT_LANGUAGE_FRENCH       = CDTEXT_LANGUAGE_FRENCH;
%constant int CDTEXT_LANGUAGE_FRISIAN      = CDTEXT_LANGUAGE_FRISIAN;
%constant int CDTEXT_LANGUAGE_IRISH        = CDTEXT_LANGUAGE_IRISH;
%constant int CDTEXT_LANGUAGE_GAELIC       = CDTEXT_LANGUAGE_GAELIC;
%constant int CDTEXT_LANGUAGE_GALICIAN     = CDTEXT_LANGUAGE_GALICIAN;
%constant int CDTEXT_LANGUAGE_ICELANDIC    = CDTEXT_LANGUAGE_ICELANDIC;
%constant int CDTEXT_LANGUAGE_ITALIAN      = CDTEXT_LANGUAGE_ITALIAN;
%constant int CDTEXT_LANGUAGE_LAPPISH      = CDTEXT_LANGUAGE_LAPPISH;
%constant int CDTEXT_LANGUAGE_LATIN        = CDTEXT_LANGUAGE_LATIN;
%constant int CDTEXT_LANGUAGE_LATVIAN      = CDTEXT_LANGUAGE_LATVIAN;
%constant int CDTEXT_LANGUAGE_LUXEMBOURGIAN = CDTEXT_LANGUAGE_LUXEMBOURGIAN;
%constant int CDTEXT_LANGUAGE_LITHUANIAN   = CDTEXT_LANGUAGE_LITHUANIAN;
%constant int CDTEXT_LANGUAGE_HUNGARIAN    = CDTEXT_LANGUAGE_HUNGARIAN;
%constant int CDTEXT_LANGUAGE_MALTESE      = CDTEXT_LANGUAGE_MALTESE;
%constant int CDTEXT_LANGUAGE_DUTCH        = CDTEXT_LANGUAGE_DUTCH;
%constant int CDTEXT_LANGUAGE_NORWEGIAN    = CDTEXT_LANGUAGE_NORWEGIAN;
%constant int CDTEXT_LANGUAGE_OCCITAN      = CDTEXT_LANGUAGE_OCCITAN;
%constant int CDTEXT_LANGUAGE_POLISH       = CDTEXT_LANGUAGE_POLISH;
%constant int CDTEXT_LANGUAGE_PORTUGUESE   = CDTEXT_LANGUAGE_PORTUGUESE;
%constant int CDTEXT_LANGUAGE_ROMANIAN     = CDTEXT_LANGUAGE_ROMANIAN;
%constant int CDTEXT_LANGUAGE_ROMANSH      = CDTEXT_LANGUAGE_ROMANSH;
%constant int CDTEXT_LANGUAGE_SERBIAN      = CDTEXT_LANGUAGE_SERBIAN;
%constant int CDTEXT_LANGUAGE_SLOVAK       = CDTEXT_LANGUAGE_SLOVAK;
%constant int CDTEXT_LANGUAGE_SLOVENIAN    = CDTEXT_LANGUAGE_SLOVENIAN;
%constant int CDTEXT_LANGUAGE_FINNISH      = CDTEXT_LANGUAGE_FINNISH;
%constant int CDTEXT_LANGUAGE_SWEDISH      = CDTEXT_LANGUAGE_SWEDISH;
%constant int CDTEXT_LANGUAGE_TURKISH      = CDTEXT_LANGUAGE_TURKISH;
%constant int CDTEXT_LANGUAGE_FLEMISH      = CDTEXT_LANGUAGE_FLEMISH;
%constant int CDTEXT_LANGUAGE_WALLON       = CDTEXT_LANGUAGE_WALLON;
%constant int CDTEXT_LANGUAGE_ZULU         = CDTEXT_LANGUAGE_ZULU;
%constant int CDTEXT_LANGUAGE_VIETNAMESE   = CDTEXT_LANGUAGE_VIETNAMESE;
%constant int CDTEXT_LANGUAGE_UZBEK        = CDTEXT_LANGUAGE_UZBEK;
%constant int CDTEXT_LANGUAGE_URDU         = CDTEXT_LANGUAGE_URDU;
%constant int CDTEXT_LANGUAGE_UKRAINIAN    = CDTEXT_LANGUAGE_UKRAINIAN;
%constant int CDTEXT_LANGUAGE_THAI         = CDTEXT_LANGUAGE_THAI;
%constant int CDTEXT_LANGUAGE_TELUGU       = CDTEXT_LANGUAGE_TELUGU;
%constant int CDTEXT_LANGUAGE_TATAR        = CDTEXT_LANGUAGE_TATAR;
%constant int CDTEXT_LANGUAGE_TAMIL        = CDTEXT_LANGUAGE_TAMIL;
%constant int CDTEXT_LANGUAGE_TADZHIK      = CDTEXT_LANGUAGE_TADZHIK;
%constant int CDTEXT_LANGUAGE_SWAHILI      = CDTEXT_LANGUAGE_SWAHILI;
%constant int CDTEXT_LANGUAGE_SRANANTONGO  = CDTEXT_LANGUAGE_SRANANTONGO;
%constant int CDTEXT_LANGUAGE_SOMALI       = CDTEXT_LANGUAGE_SOMALI;
%constant int CDTEXT_LANGUAGE_SINHALESE    = CDTEXT_LANGUAGE_SINHALESE;
%constant int CDTEXT_LANGUAGE_SHONA        = CDTEXT_LANGUAGE_SHONA;
%constant int CDTEXT_LANGUAGE_SERBO_CROAT  = CDTEXT_LANGUAGE_SERBO_CROAT;
%constant int CDTEXT_LANGUAGE_RUTHENIAN    = CDTEXT_LANGUAGE_RUTHENIAN;
%constant int CDTEXT_LANGUAGE_RUSSIAN      = CDTEXT_LANGUAGE_RUSSIAN;
%constant int CDTEXT_LANGUAGE_QUECHUA      = CDTEXT_LANGUAGE_QUECHUA;
%constant int CDTEXT_LANGUAGE_PUSHTU       = CDTEXT_LANGUAGE_PUSHTU;
%constant int CDTEXT_LANGUAGE_PUNJABI      = CDTEXT_LANGUAGE_PUNJABI;
%constant int CDTEXT_LANGUAGE_PERSIAN      = CDTEXT_LANGUAGE_PERSIAN;
%constant int CDTEXT_LANGUAGE_PAPAMIENTO   = CDTEXT_LANGUAGE_PAPAMIENTO;
%constant int CDTEXT_LANGUAGE_ORIYA        = CDTEXT_LANGUAGE_ORIYA;
%constant int CDTEXT_LANGUAGE_NEPALI       = CDTEXT_LANGUAGE_NEPALI;
%constant int CDTEXT_LANGUAGE_NDEBELE      = CDTEXT_LANGUAGE_NDEBELE;
%constant int CDTEXT_LANGUAGE_MARATHI      = CDTEXT_LANGUAGE_MARATHI;
%constant int CDTEXT_LANGUAGE_MOLDAVIAN    = CDTEXT_LANGUAGE_MOLDAVIAN;
%constant int CDTEXT_LANGUAGE_MALAYSIAN    = CDTEXT_LANGUAGE_MALAYSIAN;
%constant int CDTEXT_LANGUAGE_MALAGASAY    = CDTEXT_LANGUAGE_MALAGASAY;
%constant int CDTEXT_LANGUAGE_MACEDONIAN   = CDTEXT_LANGUAGE_MACEDONIAN;
%constant int CDTEXT_LANGUAGE_LAOTIAN      = CDTEXT_LANGUAGE_LAOTIAN;
%constant int CDTEXT_LANGUAGE_KOREAN       = CDTEXT_LANGUAGE_KOREAN;
%constant int CDTEXT_LANGUAGE_KHMER        = CDTEXT_LANGUAGE_KHMER;
%constant int CDTEXT_LANGUAGE_KAZAKH       = CDTEXT_LANGUAGE_KAZAKH;
%constant int CDTEXT_LANGUAGE_KANNADA      = CDTEXT_LANGUAGE_KANNADA;
%constant int CDTEXT_LANGUAGE_JAPANESE     = CDTEXT_LANGUAGE_JAPANESE;
%constant int CDTEXT_LANGUAGE_INDONESIAN   = CDTEXT_LANGUAGE_INDONESIAN;
%constant int CDTEXT_LANGUAGE_HINDI        = CDTEXT_LANGUAGE_HINDI;
%constant int CDTEXT_LANGUAGE_HEBREW       = CDTEXT_LANGUAGE_HEBREW;
%constant int CDTEXT_LANGUAGE_HAUSA        = CDTEXT_LANGUAGE_HAUSA;
%constant int CDTEXT_LANGUAGE_GURANI       = CDTEXT_LANGUAGE_GURANI;
%constant int CDTEXT_LANGUAGE_GUJURATI     = CDTEXT_LANGUAGE_GUJURATI;
%constant int CDTEXT_LANGUAGE_GREEK        = CDTEXT_LANGUAGE_GREEK;
%constant int CDTEXT_LANGUAGE_GEORGIAN     = CDTEXT_LANGUAGE_GEORGIAN;
%constant int CDTEXT_LANGUAGE_FULANI       = CDTEXT_LANGUAGE_FULANI;
%constant int CDTEXT_LANGUAGE_DARI         = CDTEXT_LANGUAGE_DARI;
%constant int CDTEXT_LANGUAGE_CHURASH      = CDTEXT_LANGUAGE_CHURASH;
%constant int CDTEXT_LANGUAGE_CHINESE      = CDTEXT_LANGUAGE_CHINESE;
%constant int CDTEXT_LANGUAGE_BURMESE      = CDTEXT_LANGUAGE_BURMESE;
%constant int CDTEXT_LANGUAGE_BULGARIAN    = CDTEXT_LANGUAGE_BULGARIAN;
%constant int CDTEXT_LANGUAGE_BENGALI      = CDTEXT_LANGUAGE_BENGALI;
%constant int CDTEXT_LANGUAGE_BIELORUSSIAN = CDTEXT_LANGUAGE_BIELORUSSIAN;
%constant int CDTEXT_LANGUAGE_BAMBORA      = CDTEXT_LANGUAGE_BAMBORA;
%constant int CDTEXT_LANGUAGE_AZERBAIJANI  = CDTEXT_LANGUAGE_AZERBAIJANI;
%constant int CDTEXT_LANGUAGE_ASSAMESE     = CDTEXT_LANGUAGE_ASSAMESE;
%constant int CDTEXT_LANGUAGE_ARMENIAN     = CDTEXT_LANGUAGE_ARMENIAN;
%constant int CDTEXT_LANGUAGE_ARABIC       = CDTEXT_LANGUAGE_ARABIC;
%constant int CDTEXT_LANGUAGE_AMHARIC      = CDTEXT_LANGUAGE_AMHARIC;
%constant int CDTEXT_LANGUAGE_INVALID      = CDTEXT_LANGUAGE_INVALID;
%constant int CDTEXT_LANGUAGE_BLOCK_UNUSED = CDTEXT_LANGUAGE_BLOCK_UNUSED;

%constant int MIN_CDTEXT_FIELD             = MIN_CDTEXT_FIELD;
%constant int MAX_CDTEXT_FIELDS            = MAX_CDTEXT_FIELDS;

typedef int cdtext_field_t;
typedef int cdtext_lang_t;
typedef int cdtext_genre_t;

const char *cdtext_field2str (cdtext_field_t i);
const char *cdtext_lang2str (cdtext_lang_t i);
const char *cdtext_genre2str (cdtext_genre_t i);
cdtext_t *cdtext_init (void);
void cdtext_destroy (cdtext_t *p_cdtext);
const char *cdtext_get_const (const cdtext_t *p_cdtext, cdtext_field_t key, track_t track);
cdtext_lang_t cdtext_get_language (const cdtext_t *p_cdtext);
bool cdtext_select_language(cdtext_t *p_cdtext, cdtext_lang_t lang);
cdtext_lang_t *cdtext_list_languages (const cdtext_t *p_cdtext);
void cdtext_set (cdtext_t *p_cdtext, cdtext_field_t key, const uint8_t *value, track_t track, const char *charset);

%typemap(out) char *cdtext_get %{
  if ($1==NULL) {
     Py_RETURN_NONE;
  }
  $result = PyBytes_FromString($1);
%}
char *cdtext_get (const cdtext_t *p_cdtext, cdtext_field_t key, track_t track);

%typemap(out) cdtext_lang_t *cdtext_list_languages_v2 %{
  $result = PyList_New(8); /* list is always 8 items long */
  for (int i = 0; i < 8; ++i) {
    PyList_SetItem($result, i, PyLong_FromLong($1[i]));
  }
%}
cdtext_lang_t *cdtext_list_languages_v2 (const cdtext_t *p_cdtext);


%rename cdio_get_cdtext get_cdtext;
cdtext_t *cdio_get_cdtext (CdIo_t *p_cdio);
