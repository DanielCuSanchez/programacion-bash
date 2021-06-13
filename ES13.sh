#!/usr/bin/ksh
#######################################################################
#                         ITESM-CQ                                    #
#  Objetivo: ES13 Poner en práctica el uso de condicionales y ciclos  #
#  dentro de ciclo.                                                   #
#                                                                     #
# Ejemplo: $ ES13        UNIXAccountsFILE                             #
#                                                                     #
# Autor: Daniel Cu Sánchez # Fecha: 29 Abril 2021.                    #
#######################################################################

# Validar que se recibe 2 argumentos de posición
if test $# -eq 1
then
  #Verificar que el primer argumento sea un archivo
  if test -f $1
  then
  #Procesar el archivo de cuentas
    for Cuenta in `cat $1`
    do
      # Verificar si la cuenta existe
      EXISTE_CUENTA=`egrep $Cuenta /etc/passwd`
      if test $? -eq 0
      then
        # Obtener las conexiones realizadas en la fecha analizada
        NUMERO_CONEXIONES=`who -T | egrep "$Cuenta" | tr -s '[ ]' '[#*]' | cut -f3,7 -d# | egrep ':'> File_Conexiones`
        # Procesar cada conexion y determinar si hay actividad
        for CONEXION in `cat File_Conexiones`
        do
          PUERTO=`echo $CONEXION | cut -f1 -d#`
          TIEMPO_INACTIVIDAD=`echo $CONEXION | cut -f2 -d# | cut -f2 -d:`
          if test $TIEMPO_INACTIVIDAD -ge 5
            then
              # Matar la conexion
              ps -lu $Cuenta | egrep $PUERTO | tr -s '[ ]' '[#*]' | cut -f5 -d# > File_Procesos
              # Matar procesos
              kill -1 cat File_Procesos
          fi
        done
      else
        echo "\nThe UNIX account \" $1 \" does not exist in the system!!\a\n"
      fi
    done
    echo "\nThe UNIX account $1 does not exist in the system!!\a\n"
  else
    echo "\nERROR: The file $1 does not exist in the system!\a"
  fi
else
  echo "\nERROR: The script must receive \" $0 \" at least one argument (file of accounts)\a"
fi

#who | tr -s '[ ]' '[#*]' | cut -f1 -d# > Lista