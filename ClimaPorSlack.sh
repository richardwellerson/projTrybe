#!/bin/bash
export LANG=C.UTF-8
criararquivo(){

    controle=1   
    while [ $controle -lt 20 ]; do
    cut -d"{" -f$controle list1.txt >> dados.txt 
    let controle=controle+1
    done

}

arquivotemp(){

    grep temp dados.txt > dados2.txt
    controle=1
    
    while [ $controle -lt 6 ]; do
    cut -d"," -f$controle dados2.txt >> dadostemp.txt
    let controle=controle+1
    done

    temp=`head -1 dadostemp.txt | cut -d":" -f2`
    tempMAX=`grep temp_max dadostemp.txt | sed 's/}/:/g' |cut -d":" -f2` 
    tempMIN=`grep temp_min dadostemp.txt | cut -d":" -f2`
    rm dados2.txt dadostemp.txt
}
arquivopos(){

    grep lon dados.txt > dados2.txt
    cut -d"," -f1 dados2.txt >> dadospos.txt
    cut -d"," -f2 dados2.txt >> dadospos.txt

    long=`head -1 dadospos.txt | cut -d":" -f2`
    lati=`grep lat dadospos.txt | sed 's/}/:/g' | cut -d":" -f2`
    rm dados2.txt dadospos.txt
}


VALORES(){
    arquivotemp
        arquivopos
        kelvin=273.15
        tempatual=$(echo "scale=2; $temp - $kelvin " | bc)
        temMX=$(echo "scale=2; $tempMAX - $kelvin " | bc)
        temMN=$(echo "scale=2; $tempMIN - $kelvin " | bc)
        echo "Temperatura atual de $CIDADE: $tempatual°" 
        echo "Temperatura Maxima: $temMX°"
        echo "Temperatura Minima: $temMN°"
        echo "Latitude: $lati"
        echo "Longitude: $long"
    
}

CIDADE=$*
API_KEY=5ff2f2aaf23ad640503a718cc55b3721

if [ -z "$CIDADE" ]
then
    echo "Digite a cidade!"
else
    curl -s -G --data-urlencode "appid=$API_KEY" --data-urlencode "q=$CIDADE" http://api.openweathermap.org/data/2.5/weather > list1.txt
    cod=`cut -d"," -f1 list1.txt | cut -d":" -f2`
    criararquivo
    if [ $cod != '"404"' ]
    then
        VALORES
        read -p "Deseja enviar os dados para o Projeto Shell Script? (S/N) " op
        if [ op="s" ]
            then        
            MESSAGE=$*
            MESSAGE="Temperatura atual de $CIDADE: $tempatual°\nTemperatura Maxima: $temMX°\nTemperatura Minima: $temMN°\nLatitude: $lati\nLongitude: $long"
            curl -X POST -H 'Content-type: application/json' --data "{\"text\":\"$MESSAGE\"}" https://hooks.slack.com/services/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
            rm dados.txt list1.txt
            else
            exit
        fi

    else
        echo "Conheço $CIDADE não, meu fi."
        
    fi
fi



