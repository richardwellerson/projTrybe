#!/bin/bash

ARQUIVO=$1
REG_ARQ="[Aa-zZ0-9]+\.[t][x][t]"
if [ -e $ARQUIVO ]
then
   if [[ $ARQUIVO =~ $REG_ARQ ]]
   then
       word=`cat $ARQUIVO | wc -w`
       seg=60
       minutos=$[ $word / $seg ]
       echo " Estima-se a leitura do texto $ARQUIVO em $minutos minutos "
   else
       echo "Cadê o arquivo de texto?"
   fi
else
   echo "Uai, cadê o texto?"
fi
