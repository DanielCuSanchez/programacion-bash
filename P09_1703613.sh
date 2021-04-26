#!/usr/bin/ksh
#######################################################################
#                         ITESM-CQ                                    #
#  Objetivo: Laboratorio del uso del condicional if-else-if, solución #
# de problemas que permiten gestionar información de UNIX.            #
#                                                                     #
# Ejemplo: $ P09_1703613 UNIXAccount                                  #
#                                                                     #
# Autor: Daniel Cu Sánchez # Fecha: 18 Abril 2021.                    #
#######################################################################
# Validar que se recibe 2 argumentos de posición
if [ $# -eq 2 ]
then
  Linea=`egrep $1 /etc/passwd`
  # Validar que la cuenta existe.
  if [ $? -eq 0 ]
  then
    IDLE=`who -T | egrep $1 | head -1 | tr -s '[ ]' '[#*]' | tr -s '[        ]' '[#*]' | cut -f6 -d# | cut -f2 -d:`
    # Validar el rango del numero de parametro
    if [[ ( $2 -ge 1 ) && ( $2 -lt 59 ) ]]
    then
      # Validar que la cuenta ha exedido el tiempo "downtime
      if [ $IDLE -ge $2 ]
      then
        echo "\nThe UNIX account $1 exceeds the allowed downtime!!!"
      else
        echo "\nThe account $1 DOES NOT exceeds downtime!!!!"
      fi
    else
      echo "\nThe inserted numeric value must be in the range of 1-59!!!!\a\n"
    fi
  else
    echo "\nThe UNIX account \"$1\" does not exist in the system!!\a\n"
  fi
else
  echo "\nThe script must receive two arguments!!"
fi

who -T | egrep A1703613 | head -1 | tr -s '[ ]' '[#*]' | tr -s '[        ]' '[#*]' | cut -f7 -d# | cut -f2 -d: