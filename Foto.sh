#!/bin/bash

pegarLINKS(){
    controle=3
    let i=QTY_RESULTS+3
    cont=1
    while [ $controle -lt $i ]; do
    url=`cut -d"{" -f$controle site.txt | cut -d'"' -f4`
    echo $url
    wget $url -o .jpg
    let controle=controle+1
    done
}


API_KEY=13623998-877c27bd53b6ba11c01fc45d6

SEARCH_TERM=$1
QTY_RESULTS=$2

if [ -z $QTY_RESULTS ]
then
    echo 'Digite o quer procurar e o numero de imagem. Ex: "Dog" 5 '
else
    if [ -e $SEARCH_TERM ]
    then
        cd $SEARCH_TERM
        echo "Entrando em $SEARCH_TERM"
        curl -s -G -L --data-urlencode "key=$API_KEY" --data-urlencode "q=$SEARCH_TERM" --data-urlencode "image_type=photo" --data-urlencode "per_page=$QTY_RESULTS" https://pixabay.com/api > site.txt
        pegarLINKS
        
    else
        mkdir $SEARCH_TERM
        echo "Diretorio $SEARCH_TERM criado"
        cd $SEARCH_TERM
        echo "Entrando em $SEARCH_TERM"
        curl -s -G -L --data-urlencode "key=$API_KEY" --data-urlencode "q=$SEARCH_TERM" --data-urlencode "image_type=photo" --data-urlencode "per_page=$QTY_RESULTS" https://pixabay.com/api > site.txt
        pegarLINKS
    fi
fi


