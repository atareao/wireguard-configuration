#!/bin/bash

calculate(){
    if [[ -n "$1" ]]
    then
        qrencode -t ansiutf8 < $1
    fi
}
if [ -z "$1" ]
then
    echo "Need the name of the configuration file"
else
    calculate $1
fi
