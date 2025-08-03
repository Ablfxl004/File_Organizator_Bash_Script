#!/bin/bash


files_array=()

file_formats_array=()

shopt -s nullglob 
folders_array=(*/)
shopt -u nullglob

show_current_dir () {
    pwd=$(pwd)
    echo The current working directory is $pwd
}

create_files_array () {
    script_file_name="script.sh"

    shopt -s nullglob 

    for entry in *; do
        if [[ -f "$entry" ]] && [[ "$entry" != "$script_file_name" ]] && [[ "$entry" != "README.md" ]] && [[ "$entry" != "LICENSE.md" ]]; then
            files_array+=("$entry")
        fi
    done
    
    shopt -u nullglob 
}


show_files_array () {
    echo "Files in the current directory:"
    for file in "${files_array[@]}"; do
        echo "$file"
    done
}


create_file_formats_array() {
    for file in "${files_array[@]}"; do
        format="${file##*.}"
        if ! [[ "${file_formats_array[*]}" =~ "$format" ]]; then
        file_formats_array+=("$format")
        fi
    done
}

show_file_formats_array(){
    echo "File formats in the current directory:"
    for format in "${file_formats_array[@]}"; do
        echo "$format"
    done
}


show_exicted_folder() {
    echo "Folder names in the currect directory:"
    for folder in "${folders_array[@]}"; do
        echo "$folder"
    done
}


create_needed_format_folders() {
    for format in "${file_formats_array[@]}"; do
        upper_format="${format^^}"
        format_folder="${upper_format}_Folder"
        
        mkdir -p "$format_folder"
        if ! [[ "${folders_array[*]}" =~ "$format_folder" ]]; then
        echo "--- $format_folder created ---"
        folders_array+=("$format_folder")
        fi

    done
}

move_files_to_realated_folder() {
    for format in "${file_formats_array[@]}"; do
        for file in "${files_array[@]}"; do
            if [[ "${file##*.}" == "$format" ]]; then
                upper_format="${format^^}"
                format_folder="${upper_format}_Folder"
                mv -i "$file" "$format_folder"
            fi
        done

    done
}

file_organizer() {
    show_current_dir
    create_files_array
    show_files_array
    create_file_formats_array
    show_file_formats_array
    show_exicted_folder
    create_needed_format_folders
    move_files_to_realated_folder
}

file_organizer