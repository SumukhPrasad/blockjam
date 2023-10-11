#!/bin/bash
mkdir /usr/src/app/certs
CONFIG="
HOME            = /usr/src/app
[ req ]
default_bits        = 4096
default_md          = sha256
distinguished_name  = req_distinguished_name
prompt              = no
x509_extensions         = v3_req
[ req_distinguished_name ]
countryName=        IN
stateOrProvinceName=    Karnataka
localityName=       Bangalore
organizationName=   Company
organizationalUnitName= Unit
commonName=     *
[ v3_req ]
basicConstraints = CA:FALSE
keyUsage = digitalSignature, keyEncipherment
extendedKeyUsage = serverAuth
subjectAltName = email:admin@localhost

"

openssl genrsa -out /usr/src/app/config/cert.key 4096

openssl req -x509 -new -nodes -key /usr/src/app/config/cert.key \
            -config $CONFIG -days 365 \
            -out /usr/src/app/config/cert.crt