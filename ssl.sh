#!/bin/bash
mkdir /usr/src/app/certs

openssl genrsa -out /usr/src/app/config/cert.key 4096

openssl req -x509 -new -nodes -key /usr/src/app/config/cert.key \
            -config "/usr/src/app/ssl.cnf" -days 365 \
            -out /usr/src/app/config/cert.crt