#######################################################################
#                         ITESM-CQ                                    #
#  Objetivo: Práctica 15:   Ejecuta el SCRIPT e identifica conexiones #
#  sospechosas y mata los procesos uno por uno y por seguridad se     #
#  cambia la contraseña.                                              #
#  Ejemplo: $ PF_1703613                                              #
#                                                                     #
# Autor: Daniel Cu Sánchez # Fecha: 1 de Junio 2021.                  #
#######################################################################


# 1- Identifica puerto actual desde donde se ejecuta este script

PUERTO_ACTUAL=`ps | tr -s [' '] ['#*'] | egrep "ksh" | cut -f3 -d#` 2> /dev/null
USUARIO=`who | egrep "$PUERTO_ACTUAL" |  tr -s [' '] ['#*'] | cut -f1 -d#` 2> /dev/null

echo "USUARIO: $USUARIO" 2> /dev/null

# 2- Identifica todas los procesos ejecutados desde otras conexiones y filtra todas las conexiones que vamos a terminar
PARENT_ID=`ps -lu $USUARIO | egrep "$PUERTO_ACTUAL" | egrep "ksh" | tr -s [' '] ['#*'] | cut -f6 -d#` 2> /dev/null
# 3- Guarda las conexiones que deseamos terminar y las ordena según el orden de creación
ps -lu $USUARIO | egrep -v "$PUERTO_ACTUAL | $PARENT_ID" | tr -s [' '] ['#*'] | sed '1d' | cut -f5 -d# | sort -nr > archivo_conexiones_matar 2> /dev/null

# 4- Recorre la lista de las conexiones a terminar
for CONEXION in `cat archivo_conexiones_matar`
do
  kill -1 $CONEXION 2> /dev/null
  if test $? -eq 1
  then
    kill -15 $CONEXION 2> /dev/null
    if test $? -eq 1
    then
      kill -9 $CONEXION 2> /dev/null
    fi
  fi
done
# 5- Cambia la contraseña en base a que si detecto conexiones
cat archivo_conexiones_matar | wc -lc > CANTIDAD_CONEXIONES  2> /dev/null
if test ` awk '{print $1}' CANTIDAD_CONEXIONES` -gt 0
then
  echo "POR SEGURIDAD CAMBIAREMOS TU PASSWORD PORQUE HABIA OTRAS CONEXIONES SOSPECHOSAS"
  passwd
else
  echo "TU CUENTA ESTA SEGURA, NO SE DETECTARON CONEXIONES SOSPECHOSAS."
  echo "Si quieres hacer una simulación abre otra terminal."
fi
echo "SCRIPT FINALIZADO"
# 6- Eliminar archivos temporales para ejecución del script
rm CANTIDAD_CONEXIONES
rm archivo_conexiones_matar
