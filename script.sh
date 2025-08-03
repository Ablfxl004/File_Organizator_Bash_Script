#!/bin/bash

pwd=$(pwd)
script_file_name="script.sh"
echo The current working directory is $pwd

shopt -s nullglob 

declare -a files_array=()

for entry in *; do
    if [[ -f "$entry" ]] && [[ "$entry" != "$script_file_name" ]] && [[ "$entry" != "README.md" ]] && [[ "$entry" != "LICENSE.md" ]]; then
        files_array+=("$entry")
    fi
done


echo "Files in the current directory:"
for file in "${files_array[@]}"; do
    echo "$file"
done

file_formats_array=()

echo "File formats in the current directory:"
for file in "${files_array[@]}"; do
    format="${file##*.}"
    if ! [[ "${file_formats_array[*]}" =~ "$format" ]]; then
  	file_formats_array+=("$format")
	echo "$format"
    fi
done


folders_array=(*/)

echo "Folder names in the currect directory:"
for folder in "${folders_array[@]}"; do
    echo "$folder"
done

shopt -u nullglob

for format in "${file_formats_array[@]}"; do
    upper_format="${format^^}"
    format_folder="${upper_format}_Folder"
    
    mkdir -p "$format_folder"
    if ! [[ "${folders_array[*]}" =~ "$format_folder" ]]; then
	echo "--- $format_folder created ---"
	folders_array+=("$format_folder")
    fi

done


for format in "${file_formats_array[@]}"; do
    for file in "${files_array[@]}"; do
        if [[ "${file##*.}" == "$format" ]]; then
            upper_format="${format^^}"
            format_folder="${upper_format}_Folder"

            mv -i "$file" "$format_folder"
        fi
    done

done

