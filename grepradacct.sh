#!/bin/sh
# grepradacct: Quick and dirty script to grep FreeRADIUS accounting files
# Copyright (C) 2015 Daniele Albrizio - daniele@albrizio.it
#
# This program is free software; you can redistribute it and/or
# modify it under the terms of the GNU General Public License
# as published by the Free Software Foundation; either version 2
# of the License, or (at your option) any later version.
# 
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
# 
# You should have received a copy of the GNU General Public License
# along with this program; if not, write to the Free Software
# Foundation, Inc., 51 Franklin Street, Fifth Floor, Boston, MA  02110-1301, USA.


#set -x

GREPSTRING=$1

if [ $2 ]; then
 echo Results in $2 >&2
 cat $2 |\
 awk -F'\n' 'BEGIN {RS='\n\n'; ORS='\t'; OFS='\t';} { for (i=1; i<=NF; i++) print $i } { print "\n\n" }' |\
 grep -a "$GREPSTRING" |\
 awk -F'\t' 'BEGIN {OFS='\n';} {print "\n" $1; for (i=2; i<=NF; i++) print "\t" $i "" }'
else
 cat - |\
 awk -F'\n' 'BEGIN {RS='\n\n'; ORS='\t'; OFS='\t';} { for (i=1; i<=NF; i++) print $i } { print "\n\n" }' |\
 grep -a "$GREPSTRING" |\
 awk -F'\t' 'BEGIN {OFS='\n';} {print "\n" $1; for (i=2; i<=NF; i++) print "\t" $i "" }'
fi 

