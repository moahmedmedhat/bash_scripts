#!/bin/bash

####### mohamed medhat mohamed ####### 
####### gmail to comnnucate : mohamedmedhatt2003@gmail.com ####### 

# Function to create directory if it doesn't exist
create_dir() {
    if [ ! -d "$1" ]; then
        mkdir -p "$1"
    fi
}

include_hidden_files(){
# Enable dotglob to include hidden files (those starting with a dot)
shopt -s dotglob
}

move_file(){
    mv "$1" "$2"
}

change_directory(){
    cd "$1"
}
# Iterate through each file in the current directory
file_orgnize(){
for i in * ; do
    if [ -f "${i}" ]; then
        echo "File \"${i}\" exists"
        
        # Determine file extension and basic name
        extension_1="${i##*.}"
        basic_name="${i%.*}"
        
        # Decide destination directory based on file type
        if [[ "${basic_name}" = "${extension_1}" || -z "${extension_1}" ]]; then
            # If filename is the same as extension, it has no extension
            create_dir "MISC"
            # Move file into MISC/ directory
            move_file "${i}" "MISC/"
        elif [[ -n "${extension_1}" ]]; then
            # If file has an extension
            create_dir "${extension_1}"
            # Move file into directory named after its extension
            move_file "${i}" "${extension_1}/"
        fi
    fi
done
}

main(){
    change_directory "$1"
    include_hidden_files
    file_orgnize

}

main "$1"



