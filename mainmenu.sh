#!/bin/bash

# Main menu script

function draw_menu {
    printf "\nLINUX HELP MAIN MENU\n\n"
    printf "1 – File Management Commands\n"
    printf "2 – Text Processing Commands\n"
    printf "3 – Backup Commands\n"
    printf "4 – Exit\n\n"
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
        sh ./submenu1.sh
        ;;
    2)
        sh ./submenu2.sh
        ;;
    3)
        sh ./submenu3.sh
        ;;
    4)
        exit 0
        ;;
    *)
        printf "ERROR: Invalid input option.\n\n"
    esac
}

while true; do
    draw_menu
    read_option
done