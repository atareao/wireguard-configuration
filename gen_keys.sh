#!/bin/bash
if [ -z "$1" ] || [ -z "$2" ]
then
    echo "Need the name and the ip of the client or server"
else
    NAME=$1
    IP=$2
    source .env
    wg genkey > ${NAME}_private.key
    wg pubkey > ${NAME}_public.key < ${NAME}_private.key

    PRIVATE_KEY=$(cat ${NAME}_private.key)
    PUBLIC_KEY=$(cat ${NAME}_public.key)

    echo "[Interface]" > ${NAME}.conf
    echo "Address = ${IP}" >> ${NAME}.conf
    echo "PrivateKey = ${PRIVATE_KEY}" >> ${NAME}.conf
    echo "" >> ${NAME}.conf
    echo "[Peer]" >> ${NAME}.conf
    echo "Endpoint = ${SERVER_ENDPOINT}" >> ${NAME}.conf
    echo "PublicKey = ${SERVER_PUBLIC_KEY}" >> ${NAME}.conf
    echo "AllowedIPs = 0.0.0.0/0" >> ${NAME}.conf

    echo "[Peer]" >> ${NAME}_in_server.conf
    echo "PublicKey = ${PUBLIC_KEY}" >> ${NAME}_in_server.conf
    echo "AllowedIPs = ${IP}/32" >> ${NAME}_in_server.conf

    source ./get_qr.sh ${NAME}.conf
fi
