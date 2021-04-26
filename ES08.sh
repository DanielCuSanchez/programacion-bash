# !/usr/bin/ksh

#######################################################
#                       ITESM                         #
# Objetivo: Construir programas con el uso de ciclos. #
# Ejemplo: $ ES08 A01 A02 A03 ... An                  #
# Output: El programa regresa el promedio             #
# Autor: Daniel Cu Sánchez                           #
# Fecha: 15 de abril 2021.                            #
#######################################################


# Válida que se reciben exactamente dos argumentos.

if [ $# -gt 0 ]
then
  # Numero total calificaciones
  NumCal=$#
  # Lista completa de las calificaciones recibidas.
  LCal=$*
  Suma=0
  while [ $# -gt 0 ] # Ciclo controlado por evento que procesa la lista de calificaciones
  do
   Suma=`expr $Suma + $1`
   # Desplazar la lista.
   shift 1
  done
  Prom=`expr $Suma / $NumCal`
  clear
  echo "\n\n\nEl promedio de las calificaciones {$LCal} = $Prom\n\n"
else
  echo "ERROR: El script $0 debe recibir al menos una calificació   "
