#!/usr/bin/ksh

# Recibe un argumento y valida que es numero este [1...9]

# Validar el numero de argumentos

if [ ! \( $# -eq 1 \) ]
then
  echo "ERROR\a"
else
  # Condicion compuesta por un AND
  if [ $1 -ge 1 -a $1 -lt 10 ]
  then
     echo "Correcto "
  else
     echo "ERROR\a"
  fi
fi

