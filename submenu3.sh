#!/bin/bash

# Sub menu 3 script

function draw_menu {
    printf "\nBACKUP COMMANDS\n\n"
    printf "1 – Directory protection copy passed as parameter\n"
    printf "2 – Protected copy of HOME directory (requires administrator permissions)\n"
    printf "3 – Back to main menu\n\n"
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
        printf "Enter the destination (1st parameter) and the directory you want to back up (second parameter): "
        read input
        params=( $input )
        params_count=${#params[@]}

        DESTDIR="${params[0]}"
        echo "${DESTDIR: -1}"
        # Last char of first parameter
        if [ "${DESTDIR: -1}" != "/" ]
        then
            DESTDIR+="/"
        fi

        SRCDIR="${params[1]}"

        if [ "$params_count" -gt 2 ] || [ "$params_count" -lt 2 ] ;
        then
            printf "ERROR: Invalid number of parameters.\n\n"
        else
            if folder_exists $SRCDIR;
            then
                mkdir -p $DESTDIR
                # sed -e 's/\//-/g -> Replace / with -
                FILENAME=backup-$(echo $SRCDIR | sed -e 's/\//-/g')-$(date +%-Y%-m%-d)-$(date +%-T).tgz
                tar --create -P --gzip --file=$DESTDIR$FILENAME $SRCDIR
                
                printf "Backup copy of $SRCDIR directory successfully completed.\n"
            else
                printf "ERROR: $SRCDIR does not exist or is not a valid file.\n"
            fi
        fi
        ;;
    2)
        sudo mkdir -p /BACK/HOME
        SRC=$HOME
        DESTINATION="/BACK/HOME/"
        FILENAME=backup-$(echo $SRC | sed -e 's/\//+/g')-$(date +%-Y%-m%-d)-$(date +%-T).tgz
        sudo tar cvzf $DESTINATION$FILENAME -P $SRC
        
        printf "Backup copy of $SRC (\$HOME) directory successfully completed.\n"
        ;;
    3)
        exit 42
        ;;
    *)
        printf "ERROR: Invalid input option.\n\n"
    esac
}

function folder_exists {
    if [ -d "$1" ]
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