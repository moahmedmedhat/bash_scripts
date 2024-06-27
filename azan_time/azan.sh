#!/bin/bash

azan_time(){
res=`curl "http://api.aladhan.com/v1/timingsByCity/05-06-2024?city=Banha&country=Arab+Rebuplic+Egypt"` #take boady of api
echo ${res} | jq '.data.timings' #monitr it as json object
}
main(){
azan_time
}
main
