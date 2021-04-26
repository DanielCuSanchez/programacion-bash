#!/usr/bin/ksh
#######################################################################
#                         ITESM-CQ                                    #
#  Objetivo: Laboratorio 10                                           #
#                                                                     #
# Ejemplo: $ P10_1703613 UNIXAccount                                  #
#                                                                     #
# Autor: Daniel Cu Sánchez # Fecha: 19 Abril 2021.                    #
#######################################################################

# Validar que se recibe al menos 2 argumentos de posición
if [ $# -gt 1  ]
then
  #Recorre la lista para empezar a evaluar si tiene procesos huerfanos
  while [ $# -gt 0 ]
  do
    Linea=`egrep $1 /etc/passwd`
    #Verifica si la cuenta existe
    if [ $? -eq 0 ]
    then
      # Extrae los procesos huerfanos por cada cuenta valida
      ORPHAN_PROCESS=`ps -fu $1 | tr -s '[ ]' '[#*]' | tr -s '[ ]' '[#*]' | cut -f3 -d# | grep -w 1 | wc -l | sed 's/^[ \t]*//;s/[ \t]*$//'`
      echo "\nThe UNIX account \"$1\" of \"`egrep "$1" /etc/passwd | cut -f5 -d:`\" has $ORPHAN_PROCESS orphans processes."
    else
      echo "\nERROR: The UNIX account \"$1\" is not registered in the system!!\a"
    fi
    shift 1
  done
else
  echo "\nERROR: The script must receive at least two arguments or more!!\a"
fi


# Pruebas

# P10_1703613  al911911   a1234567  A2020007   herosaqro   ltrejo   LFlores


# ps -fu herosaqro | tr -s '[ ]' '[#*]' | tr -s '[ ]' '[#*]' | cut -f3 -d# | grep -w 1 | wc -l
# ps -fu A1703613 | tr -s '[ ]' '[#*]' | tr -s '[ ]' '[#*]' | cut -f3 -d# | grep -w 1 | wc -l