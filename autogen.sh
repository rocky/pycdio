#!/bin/sh
#$Id: autogen.sh,v 1.1 2006/01/25 04:32:37 rocky Exp $
aclocal -I .
automake --add-missing
autoconf
