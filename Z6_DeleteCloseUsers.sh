#!/bin/bash
# 
# Bz6DeleteClused_user.sh: script para borrar usuarios en estado
#					 Closed de Zimbra 6
#		  
#		Uso: 
#		Bz6Closed_user.sh Dominio 
#		Dominio: Dominio de lo suarios a borrar <usuario@domionio>
#		
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




function usage {
   echo "$0 : You must specify Domain name "
   echo "Try  $0 Dominio  "
   echo "Ex. $0 dep.gob.ec "
}


domain=$1


# Validacion de parametros

if [ -z $domain ] ; then
  usage
  exit;
fi



echo "dominio a usar: $domain "

for zuser in $( zmaccts | grep closed | awk {'print $1'} | cut -d@ -f1  ) ;
do
   echo "Se elimina el usuario: ${zuser}@${domain} "
   zmprov da ${zuser}@${domain} 

done