#!/bin/bash

FLOOR=111111111111
CEILING=999999999999

function postInstitution {
    NAME=$(cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 10 | head -n 1)

    curl -X POST \
    https://athena-bff.herokuapp.com/v1/institutions \
        -H 'cache-control: no-cache' \
        -H 'content-type: application/json' \
        -H 'postman-token: a0ff56d8-4393-d1a3-7960-fd27fc61edae' \
        -d '{
            "name": "Institution '"$NAME"'",
            "image_url": "https://www.insitution'"$NAME"'.com.br/images/logo.png",
            "website": "https://www.'"$NAME"'.com.br/",
            "cnpj": "59.069.914/0001-51",
            "address": "Rua '"$NAME"', '"$RANDOM"' - Barra Funda",
            "city": "São Paulo",
            "province": "SP",
            "emails": [
                "institution'"$NAME"'@gmail.com",
                "institution'"$NAME"'@institution.edu.br"
            ],
            "phones": [
                "+'"$(shuf -i $FLOOR-$CEILING -n 1)"'",
                "+'"$(shuf -i $FLOOR-$CEILING -n 1)"'"
            ]
        }'
}

echo How much institutions do you want to insert?

read institutions_quantity

for i in `seq 1 $institutions_quantity`;
do
    postInstitution
done
