#!/bin/bash

FLOOR=111111111111
CEILING=999999999999
PERIODS=("nightly" "morning")
DEGREES=("Bachelor" "Graduate" "Master's" "Doctoral")

function postCourse {
	NAME=$(cat /dev/urandom | tr -dc 'a-zA-Z0-9' | fold -w 10 | head -n 1)
	PERIOD=${PERIODS[$RANDOM % ${#RANDOM[*]}]}
	DEGREE=${DEGREES[$RANDOM % ${#RANDOM[*]}]}

	curl -X POST \
		https://athena-bff.herokuapp.com/v1/courses \
	  	-H 'cache-control: no-cache' \
	  	-H 'content-type: application/json' \
	  	-H 'postman-token: a0ff56d8-4393-d1a3-7960-fd27fc61edae' \
	  	-d '{
			"course_name": "Course '"$NAME"'",
			"course_type": "'"$DEGREE"'",
			"course_periods": ["'"$PERIOD"'"],
			"course_time_to_graduate_range": ['"$(shuf -i 4-10 -n 1)"'],
			"course_monthly_value_range": ['"$(shuf -i 550-1800 -n 1)"', '"$(shuf -i 550-1800 -n 1)"'],
			"institution_id": '"$RANDOM"',
			"institution_name": "Institution '"$NAME"'"
	   	}'
}

echo How much courses do you want to insert?

read courses_quantity

for i in `seq 1 $courses_quantity`;
do
	postCourse
done
