
#!/usr/bin/ksh
#######################################################################
#                         ITESM-CQ                                    #
#  Objetivo: Examen rápido 06                                          #
#                                                                     #
# Ejemplo: $ Q06_1703613 UNIXAccount                                  #
#                                                                     #
# Autor: Daniel Cu Sánchez # Fecha: 19 Abril 2021.                     #
#######################################################################

# Validar que se recibe 2 argumentos de posición
if [ $# -gt 1  ]
then
  NUMERO_BUSQUEDA=$1
  CONTADOR=0
  #Recorre la lista para empezar a contar
  while [ $# -gt 1 ]
  do
    #Compara el numero de busqueda
    if [ $NUMERO_BUSQUEDA -eq $2 ]
    then
      CONTADOR=`expr $CONTADOR + 1` #Incrementa el conteo del numero
    fi
    shift 1
  done
  echo "\nThe element \"$NUMERO_BUSQUEDA\" has $CONTADOR repetitions in the list."
else
  echo "\nThe script must receive at list two arguments!!!"
fi


