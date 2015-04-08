#!/bin/bash
# 
# Z6_BackCloseUsers.sh: script para obtener respaldos de usuarios en estado
#                                        Closed de Zimbra 6
#                 
#               Uso: 
#               Z6_BackCloseUsers.sh.sh Dominio BackUpPath
#               Dominio: Dominio de lo suarios a respaldar usuario@domionio
#               BackUpPath: Direccion donde se almacenara los respaldos,
#
#               Nota: El BackUpPath debe tener permiso de escritura para el               
#               usuario zimbra.           
#               El arhivo Bz6Closed_user.sh debe tener permiso de ejecucion               
#               tanto para root como para el usuario zimbra
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
   echo "$0 : You must specify Domain name and Backup Path  "
   echo "Try  $0 Dominio BackUpPaht "
   echo "Ex. $0 dep.gob.ec /opt/backup "
}


domain=$1
bpath=$2

# Validacion de parametros

if [ -z $domain ] ; then
  usage
  exit;
fi

if [ -z $bpath ] ; then
  usage
  exit;
fi

if [ ! -w $bpath ] ; then
  echo "$bpath is not writable ";
  usage
  exit;
fi


echo "dominio a usar: $domain , Path $bpath"

for zuser in $( zmaccts | grep closed | awk {'print $1'} | cut -d@ -f1  ) ;
do
   echo "se activa el usario de forma temporal $zuser"
   zmprov ma ${zuser}@${domain} zimbraAccountStatus active
   echo "obteniendo respaldo de ${zuser}"
   zmmailbox -z -m ${zuser}@$domain getRestURL "?fmt=tgz" >${bpath}/${zuser}.tgz
   echo "correo: ${zuser}@$domain archivo: ${bpath}/${zuser}.tgz"
   echo "se desactiva el usario $zuser"
   zmprov ma ${zuser}@${domain} zimbraAccountStatus closed
   echo "done respaldo $user"

done
