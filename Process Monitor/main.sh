#!/usr/bin/bash -i
####### mohamed medhat mohamed ####### 
####### gmail to comnnucate : mohamedmedhatt2003@gmail.com ####### 
source process_monitor.conf

menu(){
    echo "1-process information"
    echo "2-kill process"
    echo "3-process statics"
    echo "4-real time monitor"
    echo "5-search "
    echo "6-exit "
    echo "###############################"
    echo -n "Enter your choice: " 
}
monitor_process(){
    #select all process -o is for format
    ps -eo pid,comm,pcpu,pmem,time --sort=-pcpu
}

process_info(){
    read -p "enter your pid " pid
    ps -p ${pid} -o pid,ppid,pcpu,pmem,time,cmd
}

kill_process(){
    read -p "please enter process id to kill" pid
    kill ${pid}
    if [ $? -eq 0 ]; then
        echo "successful terminated"
        echo "$(date): the pid ${pid} is terminated succusefuly " >> process_monitor.log 
    else
    echo "terminated failed" 
    fi
}

function check_alerts(){
    process=$(ps -eo pid,pcpu,pmem --sort=-pcpu)
    echo "$process" | while read -r line; do
        echo ${line}
        read -ra ADDR <<< $line
        pid=${ADDR[0]}
        pcpu=${ADDR[1]}
        pmem=${ADDR[2]}
        if [[ ${pcpu} > ${CPU_ALERT_THRESHOLD} || ${pmem} > ${MEMORY_ALERT_THRESHOLD} ]]; then
            echo "alert: pid ${pid} have mem ${pmem} and cpu ${pcpu}"
        fi
        
    done
}

statics(){
    echo "Total Number of Processes:"
    ps aux | wc -l
    echo "Memory Usage:"
    free -m
    echo "CPU Load:"
    uptime
}


real_time_monitor() {
    while true; do
        clear
        monitor_process
        sleep ${UPDATE_INTERVAL}
    done
}

search_processes() {
    read -p "enter you critirea" c
    ps -eo pid,comm,pcpu,pmem,time --sort=-pcpu | grep -i "${c}"
}

interactve(){
    monitor_process
    while true; do
        # body
    menu
    read choice
    case "${choice}" in
        1)
            process_info
        ;;
        2)
            kill_process 
        ;;
        3)
            statics
        ;;
        4)
            real_time_monitor
        ;;
        5)
        
            search_processes 
        ;;
        6) exit 
        ;;
        *) echo "Invalid choice" ;;
    esac
done
}

main() {
    interactve
    check_alerts
}

main

