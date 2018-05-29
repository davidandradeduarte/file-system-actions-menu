#!/bin/bash

# Sub menu 2 script

function draw_menu {
    printf "\nCOMMANDS FOR TEXT PROCESSING\n\n"
    printf "1 – Search for a pattern in a file\n"
    printf "2 – Count lines, words, and characters in a file\n"
    printf "3 – Show differences between two files\n"
    printf "4 – Back to main menu\n\n"
    printf "Select an option: "
}

function read_option {
    read input
    if ! [[ "$input" =~ ^[1-4]+$ ]] ; 
    then
        #exec >&2;
        printf "ERROR: Invalid input option.\n\n"
        return
    fi

    case $input in
    1)
        printf "Enter the pattern you want to search for: "
        read pattern

        printf "Enter the name/path of the files (use a space to separate the name of each):"
        read files

        for file in $files; do
            if file_exists $file;
            then
                printf "\n\n"
                # -i Ignores the case (uppercase or lowercase) of letters when making comparisons.
                # -R Searches directories recursively. By default, links to directories are not followed.
                grep -Ri $pattern $file
                printf "\n\n"
            else
                printf "ERROR: $file does not exist or is not a valid file.\n"
            fi
        done
        ;;
    2)
        printf "Enter the name/path of the files (use a space to separate the name of each): "
        read files

        for file in $files; do
            if file_exists $file;
            then
                # TODO: remove filename printed by wc
                printf "\n"
                lines=$(wc -l $file)
                words=$(wc -w $file)
                chars=$(wc -m $file)
                printf "$file\n lines:${linhas}\n words:${palavras}\n chars:${carateres}"
                printf "\n"
            else
                printf "ERROR: $file does not exist or is not a valid file.\n"
            fi
        done
        ;;
    3)
        printf "Enter the name/path of the first file: "
        read file1

        while ! file_exists $file1; do
            printf "ERROR: $file1 does not exist or is not a valid file.\n"
            printf "Enter the name/path of the first file: "
            read file1
        done

        printf "Enter the name/path of the second file: "
        read file2

        while ! file_exists $file2; do
            printf "ERROR: $file2 does not exist or is not a valid file.\n"
            printf "Enter the name/path of the second file: "
            read file2
        done

        printf "\n"
        diff $file1 $file2
        printf "\n"
        ;;
    4)
        exit 42
        ;;
    *)
        printf "ERROR: Invalid input option.\n\n"
    esac
}

function file_exists {
    if [ -f "$1" ]
    then
        return 0;
    else
        return 1;
    fi
}

while true; do
    draw_menu
    read_option
done