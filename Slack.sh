#!/bin/bash


MESSAGE=$*
if [ -z $MESSAGE ]
then
    echo "Mensagem em branco..."
else
MESSAGE="$MESSAGE"
curl -X POST -H 'Content-type: application/json' --data "{\"text\":\"$MESSAGE\"}" https://hooks.slack.com/services/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
fi

#MESSAGE="Olá Trybe!\n Essa mensagem veio de um shell script. :stuck_out_tongue_winking_eye: \n"
#curl -X POST -H 'Content-type: application/json' --data "{\"text\":\"$MESSAGE\"}" https://hooks.slack.com/services/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