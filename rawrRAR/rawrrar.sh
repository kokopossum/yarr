#!/bin/bash

usage() {
    echo "Usage: $0 -s <source_directory> -d <destination_directory>"
    exit 1
}

parallel_enabled=true
while getopts "s:d:p" opt; do
    case $opt in
        s) source_directory="$OPTARG" ;;
        d) destination_directory="$OPTARG" ;;
        p) parallel_enabled=false ;;
        *) usage ;;
    esac
done

[[ -z "$source_directory" || -z "$destination_directory" ]] && usage
command -v 7z &> /dev/null || { echo "Error: p7zip is not installed."; exit 1; }
[[ ! -d "$source_directory" ]] && { echo "Error: Source directory '$source_directory' does not exist."; exit 1; }

mkdir -p "$destination_directory"
shopt -s nullglob
rar_files=("$source_directory"/*.rar)

[[ ${#rar_files[@]} -eq 0 ]] && { echo "No .rar files found in the source directory."; exit 0; }

extract_file() {
    local rar_file="$1" target_dir="$2"
    mkdir -p "$target_dir" && { 
        echo "Extracting '$rar_file' into '$target_dir'..."
        7z x "$rar_file" -o"$target_dir" > /dev/null && echo "Successfully extracted '$rar_file.'" ||
        echo "Error: Failed to extract '$rar_file.'"
    } || echo "Error: Failed to create directory '$target_dir.'"
}

export -f extract_file

for rar_file in "${rar_files[@]}"; do
    target_dir="$destination_directory/${rar_file##*/}"
    target_dir="${target_dir%.rar}"
    extract_file "$rar_file" "$target_dir" & 
done

if $parallel_enabled; then wait; fi

