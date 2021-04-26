#!/usr/bin/ksh
#######################################################################
#                         ITESM-CQ                                    #
#  Objetivo: ES12                                                     #
#                                                                     #
# Ejemplo: $ ES12        UNIXAccount                                  #
#                                                                     #
# Autor: Daniel Cu Sánchez # Fecha: 22 Abril 2021.                    #
#######################################################################

# Validar que se recibe 2 argumentos de posición
if test $# -eq 2
then
  #Verificar que el primer argumento sea un archivo
  if test -f $1
  then
    for Cuenta in `cat $1`
    do
      # Verificar si la cuenta existe
      Linea=`egrep $Cuenta /etc/passwd`
      if test $? -eq 0
      then
        # Obtener las conexiones realizadas en la fecha analizada
        NumeroConexiones=`last $Cuenta | egrep "$2" | egrep sshd | wc -l | tr -d ' '`
        echo "\n The user [`egrep "$Cuenta" /etc/passwd | cut -f5 -d:`] had $NumeroConexiones connections on $2"
      else
        echo "\nThe UNIX account $1 does not exist in the system!!\a\n"
      fi
    done
    echo "\nThe UNIX account $1 does not exist in the system!!\a\n"
  else
    echo "\nERROR: The file does not exist in the system!\a"
  fi
else
  echo "\nThe script must receive at least one argument or more"
fi


# who | tr -s '[ ]' '[#*]' | cut -f1 -d# | uniq > ListaAlumnis