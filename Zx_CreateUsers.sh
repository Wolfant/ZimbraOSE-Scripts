#!/bin/bash
# 
# Zx_CreateUsers.sh: script para crear usuarios en estado
#					 
#		  
#		Uso: 
#		Zx_CreateUsers.sh UserList 
#		UserList: Archivos con la lista de usuarios en formato:
#		Nombre:Apellido:mail:password
# 
#
# Copyrigth Antonio Insuasti - <antonio@insuasti.ec>
#
# This program is free software; you can redistribute it and/or modify
# it under the terms of the GNU General Public License as published by
# the Free Software Foundation; either version 2 of the License, or
# (at your option) any later version.
#
# This program is distributed in the hope that it will be useful,
# but WITHOUT ANY WARRANTY; without even the implied warranty of
# MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
# GNU General Public License for more details.
#
# You should have received a copy of the GNU General Public License
# along with this program.  If not, see <http://www.gnu.org/licenses/>.
#
# Author: Antonio Insuasti <antonio@insuasti.ec>
#

UserList=$1

if [ ! -r ${UserList} ] ; then
  usage
  exit;
fi

while read UserLine; 
 do
	user_Fname=$(echo "$UserLine" | cut -d: -f1)
	user_Lname=$(echo "$UserLine" | cut -d: -f2 )
	mail=$( echo "$UserLine" | cut -d: -f3 )
	password=$( echo "$UserLine" | cut -d: -f4 )
	
	echo "Se crea al usuario: $mail"
	zmprov ca $mail $passwordvenName displayName "$user_Fname $user_Lname" givenName "$user_Fname" cn "$user_Fname $user_Lname" 
    echo "user created"
	echo "-------------------"
done < ${UserList}

