#!/usr/bin/ksh
# Crea archivo con meses
echo "Jan Feb Mar Apr May Jun Jul Agu Sep Oct Nov Dec" > Meses
# Validar que se recibe dos argumentos de posición
if [ $# -eq 2 ]
then
   # Verificar que el primer argumento sea un archivo y existe
   if test -f $1
   then
     # Verificar que el segundo argumento 2 tenga 3 caracteres
     if [ ${#2} -eq 3 ]
     then
       Mes=`cat Meses | egrep $2`
       if [ $? -eq 0 ]
       then
          
          for Cuenta in `cat $1`
          do

             #Verificar si la cuenta existe
             Res=`egrep $Cuenta /etc/passwd`
             if test $? -eq 0
             then
               H=`last $Cuenta | egrep sshd | egrep $2 | tr -s '[ ]' '[#*]' | cut -f10 -d# | cut -f1 -d: | tr -s '[(]' '[ ]' > Hora`
               Hour=`paste -sd+ Hora /export/home/alumnos/A1208926 | bc`
               M=`last $Cuenta | egrep sshd | egrep $2 | tr -s '[ ]' '[#*]' | cut -f10 -d# | cut -f2 -d: | tr -s '[)]' '[ ]' > Minu`
               Min=`paste -sd+ Minu /export/home/alumnos/A1208926 | bc`
              
   			   HorMin=`expr $Min / 60`
               Htot=`expr $Hour + $HorMin`
               Minrest=`expr $HorMin \* 60`
               Mintot=`expr $Min - $Minrest`

               echo "En \"$2\" \"`egrep $Cuenta /etc/passwd | cut -f5 -d:`\" ha acumulado $Htot horas y $Mintot minuto(s) en el sistema"

               
             else
             echo "La cuenta $Cuenta no existe en el sistema!!!"
             fi
            
          done
       else
        echo " El segundo argumento invalido\a"
       fi
       
     else
     echo " El segundo argumento debe tener 3 caracteres \a"
     fi


   else
   echo "\nERROR: El archivo no existe en el sistema!\a"
   fi
else
   echo "\nError El script debe recibir dos parámetros de posición"
fi