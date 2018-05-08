#!/bin/bash

# Main menu script

function draw_menu {
    printf "\nMENU PRINCIPAL DE AJUDA DO LINUX\n\n"
    printf "1 – Comandos de Gestão de Ficheiros\n"
    printf "2 – Comandos para Processamento de Texto\n"
    printf "3 – Comandos de Backup\n"
    printf "4 – Sair\n\n"
    printf "Selecione uma opção: "
}

function read_option {
    read input
    if ! [[ "$input" =~ ^[1-4]+$ ]] ; 
    then
        #exec >&2;
        printf "ERRO: Opção de entrada inválida.\n\n"
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
        printf "ERRO: Opção de entrada inválida.\n\n"
    esac
}

while true; do
    draw_menu
    read_option
done