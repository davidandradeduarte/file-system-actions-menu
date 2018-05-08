#!/bin/bash

# Sub menu 2 script

function draw_menu {
    printf "\nCOMANDOS PARA PROCESSAMENTO DE TEXTO\n\n"
    printf "1 – Procurar um padrão num ficheiro\n"
    printf "2 – Contar linhas, palavras e carateres de um ficheiro\n"
    printf "3 – Mostrar as diferenças entre dois ficheiros\n"
    printf "4 – Sair: Retorno ao menu principal\n\n"
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
		printf "Introduza o padrão que pretende procurar: "
		read pattern

        printf "Introduza o nome/caminho dos ficheiros (use um espaço para separar o nome de cada um): "
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
                printf "ERRO: $file não existe ou não é um ficheiro válido.\n"
            fi
        done
		;;
	2)
		printf "Introduza o nome/caminho dos ficheiros (use um espaço para separar o nome de cada um): "
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
                printf "ERRO: $file não existe ou não é um ficheiro válido.\n"
            fi
        done
		;;
	3)
		printf "Introduza o nome/caminho do primeiro ficheiro: "
	    read file1

        while ! file_exists $file1; do
            printf "ERRO: $file1 não existe ou não é um ficheiro válido.\n"
            printf "Introduza o nome/caminho do primeiro ficheiro: "
	        read file1
        done

        printf "Introduza o nome/caminho do segundo ficheiro: "
	    read file2

        while ! file_exists $file2; do
            printf "ERRO: $file2 não existe ou não é um ficheiro válido.\n"
            printf "Introduza o nome/caminho do segundo ficheiro: "
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
        printf "ERRO: Opção de entrada inválida.\n\n"
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