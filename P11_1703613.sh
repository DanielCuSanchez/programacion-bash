#!/usr/bin/ksh
#######################################################################
#                         ITESM-CQ                                    #
#  Objetivo: Laboratorio 11                                           #
#                                                                     #
# Ejemplo: $ P11_1703613 UNIXAccount                                  #
#                                                                     #
# Autor: Daniel Cu Sánchez # Fecha: 19 Abril 2021.                    #
#######################################################################

# Datos de pruebas con Listita
# A2020007
#ltrejo
# lredes
# A1703442
# a1234567
# al320838
# A1703613

# Validar que se recibe al menos 2 argumentos de posición
if test $# -eq 2
then
  #Verificar que el primer argumento sea un archivo
  if test -f $1
  then
    #Recorrer la lista de cuentas elementos (segundo argumento)
    for Cuenta in `cat $1`
    do
      # Verificar si la cuenta existe
      CUENTA_EXISTE=`egrep $Cuenta /etc/passwd`
      if test $? -eq 0
      then
        if test -d /export/home/alumnos/$Cuenta
        then
          # Valida si tiene privilegios
          if test -x /export/home/alumnos/$Cuenta
          then
            #Extraer datos del directorio
            ls -la /export/home/alumnos/$Cuenta > Archivo_LS
            # Verificar si existe el archivo
            EXISTE_ARCHIVO=`cat Archivo_LS | egrep "$2" | head -1 | wc -l`
            if test $EXISTE_ARCHIVO -eq 1
            then
              # Extraer ultima modificiacion de archivo
              egrep "$2" Archivo_LS | head -1 | tr -s '[ ]' '[#*]' | tr -s '[ ]' '[#*]' > OUTPUT_RESULTADO
              # Extraer el usuario de la cuenta
              USUARIO=`egrep $Cuenta /etc/passwd | cut -f5 -d:`
              echo "\n$USUARIO modificó \"$2\" por última ocasión [`cat OUTPUT_RESULTADO | cut -f6-8 -d# | tr -s '[#]' '[ *]'`]"
            else
              echo "\nLa cuenta $Cuenta no ha creado el archivo \"$2\"\a"
            fi
          else
            echo "\nUsted no tiene permisos para revisar la cuenta \"$Cuenta\" !!!\a"
          fi
        else
        echo "\nLa cuenta \"$Cuenta\" no tiene carpeta en alumnos!!!\a"
        fi
      else
        echo "\nLa cuenta \"$Cuenta\" no existe en el sistema!!!\a"
      fi
    done
  else
    echo "\nERROR: El archivo $1 no existe en el sistema!\a"
  fi
else
  echo "\nERROR: El script debe recibir 2 argumentos!\a"
fi
#Borra los archivos creados de forma temporal
# rm OUTPUT_RESULTADO Archivo_LS



