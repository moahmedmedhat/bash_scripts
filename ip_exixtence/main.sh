#!/bin/bash
ip_check(){
success="100% packet loss"
for i in {100..115}; do
    res=`ping 192.168.8.${i} -c 1 -w 2`
    # echo ${res}
    # break
    if [[ ${res} == *${success}* ]]; then
    echo "ip 192.168.8.${i} is not exixt "
    else
    echo "ip 192.168.8.${i} is exixt "
    fi
done
}
main(){
    ip_check
}
main