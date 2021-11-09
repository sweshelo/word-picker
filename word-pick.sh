#!/bin/bash

function pick_words(){
    cat dict.txt | grep "^${1}[A-z ]*\S" | sort -R | head -n 5 | awk -F'\t' '{print "[\""$1"\",\""$2"\"],"}'| sort -R | head -n 5
}

export -f pick_words

function response(){
    echo "HTTP/1.0 200 OK"
    echo "Content-Type: application/json"
    echo ""
    echo ${1} | sed 's/\/?char=//g' | xargs -I@ bash -c 'echo "{`pick_words @`}"'
}

response $1
