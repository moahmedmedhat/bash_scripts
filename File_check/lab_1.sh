#!/bin/bash
check_if_no_arg(){
    if [ -z $1 -o -z $2 ]; then
    echo "usage is <file1> <file2>"
    exit 0
fi
}
compare_file(){
    file_1=`md5sum $1`
    file_2=`md5sum $2`
    read -ra ADDR1 <<< ${file_1}
    read -ra ADDR2 <<< ${file_2}
    test ${ADDR1[0]} = ${ADDR2[0]} && echo "file is similar" || echo "file is not similar"
    
}
main(){
    check_if_no_arg $1 $2 
    compare_file $1 $2
}

main $1 $2