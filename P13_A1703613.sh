#!/usr/bin/ksh
#######################################################################
#                         ITESM-CQ                                    #
#  Objetivo: Laboratorio 13: Recibe una lista y por cada usuario en   #
#  en ella reporta el tiempo que ha estado conectado al servidor      #
#                                                                     #
# Ejemplo: $ P13_1703613 Lista Mes                                    #
#                                                                     #
# Autor: Daniel Cu Sánchez # Fecha: 12 Mayo 2021.                     #
#######################################################################

#Crear el archivo de meses validos
echo "Jan Feb Mar Apr May Jun Jul Aug Sep Oct Nov Dec" > MesesValidos
# Validar que se recibe al menos 2 argumentos de posición
if test $# -eq 2
then
  #Verificar que el primer argumento sea un archivo
  if test -f $1
  then
    #Comparar que el segundo parametro sea un mes válido para la búsqueda.
    MES_VALIDO=`cat MesesValidos | grep -w $2`
    #Válidar que exista un mes válido para su ejecucion de script
    if test $? -eq 0
    then
      #Recorrer la lista de cuentas elementos (segundo argumento)
      for Cuenta in `cat $1`
      do
        # Verificar si la cuenta existe
        CUENTA_EXISTE=`egrep $Cuenta /etc/passwd`
        if test $? -eq 0
        then
          #Filtra por mes las conexiones
          GENERO_ACTIVIDAD=`last $Cuenta | egrep $2`
          if test $? -eq 0
          then
            MINUTOS=`last $Cuenta | egrep $2 | egrep sshd | tr -s '[(]' '[ ]' | tr -s '[)]' '[ ]' |  awk '{ print $10}' | awk -F':' '{suma +=$2;}END{print suma;}'`
            HORAS=`last $Cuenta | egrep $2 | egrep sshd | tr -s '[(]' '[ ]' | tr -s '[)]' '[ ]' |  awk '{ print $10}' | awk -F':' '{suma +=$1;}END{print suma;}'`
            HORAS_TOTALES=`expr \( $MINUTOS - \( $MINUTOS % 60 \) \) / 60 + $HORAS`
            MINUTOS_TOTALES=`expr $MINUTOS % 60`
            echo "\nEn \"$2\" \"`egrep $Cuenta /etc/passwd | cut -f5 -d:`\" ha acumulado $HORAS_TOTALES horas y $MINUTOS_TOTALES minuto(s) en el sistema"
          else
            HORAS_TOTALES=0
            MINUTOS_TOTALES=0
            echo "\nEn \"$2\" \"`egrep $Cuenta /etc/passwd | cut -f5 -d:`\" NO GENERO ACTIVIDAD, tuvo $HORAS_TOTALES horas y $MINUTOS_TOTALES minuto(s) en el sistema"
          fi
        else
          echo "\nLa cuenta \"$Cuenta\" no existe en el sistema!!!\a"
        fi
      done
    else
      echo "\nERROR: El mes $2 ingresado no es válido. Formato admitido: Mar  !!! \a"
    fi
  else
    echo "\nERROR: El archivo $1 no existe en el sistema!\a"
  fi
else
  echo "\nERROR: El script debe recibir 2 argumentos!\a"
fi
#Borra el archivo creado inicialmente
rm MesesValidos
