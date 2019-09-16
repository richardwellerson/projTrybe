#!/bin/bash

LEITURA(){
read -p "Deseja Ler o $DOMINIO.info? S/N " op
if [ op=S ]
then
    less $DOMINIO.info
else
    echo "Obrigado por usar o programa!"
fi
}

DOMINIO=$1
DOMINIO_REGEXP="[Aa-Zz0-9]+(\.[Aa-Zz0-9]+)+"

if [ -z $DOMINIO ]
then
    echo "Uai,cadê o domínio?"
else
    if [[ $DOMINIO =~ $DOMINIO_REGEXP ]]
    then
        whois $DOMINIO > "$DOMINIO.info"
        LEITURA

    else
        echo "E isso lá é um domínio? Que viagem..."
    fi
fi
