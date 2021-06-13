#!/usr/bin/ksh
#######################################################################
#                         ITESM-CQ                                    #
#  Objetivo: Laboratorio 12                                           #
#                                                                     #
# Ejemplo: $ P12_1703613 UNIXAccount                                  #
#                                                                     #
# Autor: Daniel Cu Sánchez # Fecha: 09 Mayo 2021.                     #
#######################################################################

# Datos de pruebas con Listita
# $ P12_1703613 A2020007 ltrejo herosaqro A1700396 a1234567 al911911 A1703613

# Validar que se recibe al menos 1 argumento de entrada
if test $# -gt 0
then
  # Recorrer los argumentos de entrada a partir de la posición 1
  while test $# -gt 0
  do
    # Verificar si la cuenta existe y exextraemos la cuenta
    CUENTA_EXISTE=`egrep $1 /etc/passwd`
    if test $? -eq 0
    then
      # Valida si la cuenta esta loggeada o no
      ESTA_LOGGEADO=`who | egrep $1`
      if test $? -eq 0
      then
        #Extraer las instancias de procesos
        ps -u $1 | tr -s '[ ]' '[#*]' | tr -s '[ ]' '[#*]' | sed "1d" | uniq -c | tr -s '[ ]' '[#*]' > procesosCuenta$1
        #Extraer usuario
        USUARIO=`egrep $1 /etc/passwd | cut -f5 -d:`
        #cat procesosCuenta$1
        #Salida de usuario
        echo "\n\n\"$USUARIO\" is executing:"
        #Cantidad de procesos por usuario
        for PROCESO in `cat procesosCuenta$1`
        do
          #Extraer cantidad de instancias
          CANTIDAD_INSTACIAS=`cat procesosCuenta$1 | grep -w "$PROCESO" | cut -f2 -d#`
          #Extraer el nombre del proceso
          NOMBRE_PROCESO=`cat procesosCuenta$1 | grep -w "$PROCESO" | cut -f6 -d#`
          echo "$CANTIDAD_INSTACIAS instance(s) of $NOMBRE_PROCESO"
          #rm procesosCuenta$1
        done
      else
        echo "\nThe UNIX account \"$1 \"is not logged on in the system!!!\a"
      fi
    else
      echo "\nThe UNIX account \"$1 \"does not exist in the system!!!\a"
    fi
    shift 1
  done
else
  echo "\nERROR: The script \" $0 \" must get at least one UNIX account for processing it !!!\a"
fi


