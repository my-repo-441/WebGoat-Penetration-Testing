#!/bin/bash

privateKey=$1
privateKey=$(echo $privateKey | tr -d '[:space:]')

echo "-----BEGIN PRIVATE KEY-----" > private.key
echo $privateKey | sed -e "s/.\{64\}/&\n/g" >> private.key
echo "-----END PRIVATE KEY-----" >> private.key

echo
echo
cat private.key
echo
echo
sleep 1
mod=$(openssl rsa -in private.key -noout -modulus | cut -d'=' -f2)
echo Modulus: $mod
sleep 1
echo
echo Starting Java Signature Process...
java -Dkey=$privateKey -Dmod=$mod GetSignature.java
