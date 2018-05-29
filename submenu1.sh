#!/bin/bash

# Sub menu 1 script

function draw_menu {
    printf "\nFILE MANAGEMENT COMMANDS\n\n"
    printf "1 – Show the contents of a file\n"
    printf "2 – Remove a file\n"
    printf "3 – Copy a file\n"
    printf "4 – List a file\n"
    printf "5 – Size of a file\n"
    printf "6 – Back to main menu\n\n"
    printf "Select an option: "
}

function read_option {
    read input
    if ! [[ "$input" =~ ^[1-6]+$ ]] ; 
    then
        #exec >&2;
        printf "ERROR: Invalid input option.\n\n"
        return
    fi

    case $input in
    1)
        printf "Enter the name/path of the files (use a space to separate the name of each): "
        read files

        for file in $files; do
            if file_exists $file;
            then
                printf "\n\n"
                cat $file;
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
                rm -f $file;
                printf "$file successfully removed.\n\n"
            else
                printf "ERROR: $file does not exist or is not a valid file.\n"
            fi
        done
        ;;
    3)
        printf "Enter the name/path of the files (use a space to separate the name of each): "
        read files
        for file in $files; do
            if file_exists $file;
            then
                printf "Enter the name/path where you want to copy the file $file: "
                read copy_path
                cp -rf $file $copy_path;
                printf "$file successfully copied to $copy_path."
            else
                printf "ERROR: $file does not exist or is not a valid file.\n"
            fi
        done	
        ;;
    4)
        printf "Enter the name/path of the files (use a space to separate the name of each): "
        read files
        for file in $files; do
            if file_exists $file;
            then
                ls -la $file;
            else
                printf "ERROR: $file does not exist or is not a valid file.\n"
            fi
        done
        ;;
    5)
    printf "Enter the name/path of the files (use a space to separate the name of each): "
        read files
        for file in $files; do
            if file_exists $file;
            then
                size=$(stat -f%z $file)
                printf "${size}kb $file\n"
            else
                printf "ERROR: $file does not exist or is not a valid file.\n"
            fi
        done
        ;;
    6)
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