#!/bin/bash

SERVICES=("https://aiolia.herokuapp.com/" "https://dohko.herokuapp.com/" "https://saga-student.herokuapp.com/" "https://shaka-course.herokuapp.com/")

function requestService {
    echo "sending request to [$url]..."

    STATUS_CODE=$(curl -s -o /dev/null -w "%{http_code}" $url)
    if [ "$STATUS_CODE" -ne "200" ]; then
        requestService $url
    fi
}

for url in "${SERVICES[@]}";
do
    requestService "$url"
done
