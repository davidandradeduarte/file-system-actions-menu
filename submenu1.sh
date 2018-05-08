#!/bin/bash

# Sub menu 1 script

function draw_menu {
    printf "\nCOMANDOS DE GESTÃO DE FICHEIROS\n\n"
    printf "1 – Mostra o conteúdo de um ficheiro\n"
    printf "2 – Remover um ficheiro\n"
    printf "3 – Copiar um ficheiro\n"
    printf "4 – Listar um ficheiro\n"
    printf "5 – Tamanho de um ficheiro\n"
    printf "6 – Sair: Retorno ao menu principal\n\n"
    printf "Selecione uma opção: "
}

function read_option {
    read input
    if ! [[ "$input" =~ ^[1-6]+$ ]] ; 
    then
        #exec >&2;
        printf "ERRO: Opção de entrada inválida.\n\n"
        return
    fi

    case $input in
	1)
        printf "Introduza o nome/caminho dos ficheiros (use um espaço para separar o nome de cada um): "
		read files

        for file in $files; do
            if file_exists $file;
            then
                printf "\n\n"
                cat $file;
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
                rm -f $file;
                printf "$file removido com sucesso.\n\n"
            else
                printf "ERRO: $file não existe ou não é um ficheiro válido.\n"
            fi
        done
		;;
	3)
        printf "Introduza o nome/caminho dos ficheiros (use um espaço para separar o nome de cada um): "
		read files
        for file in $files; do
            if file_exists $file;
            then
                printf "Introduza o nome/caminho para onde pretende copiar o ficheiro $file: "
                read copy_path
                cp -rf $file $copy_path;
                printf "$file copiado com sucesso para $copy_path."
            else
                printf "ERRO: $file não existe ou não é um ficheiro válido.\n"
            fi
        done	
		;;
    4)
        printf "Introduza o nome/caminho dos ficheiros (use um espaço para separar o nome de cada um): "
		read files
        for file in $files; do
            if file_exists $file;
            then
                ls -la $file;
            else
                printf "ERRO: $file não existe ou não é um ficheiro válido.\n"
            fi
        done
        ;;
    5)
    printf "Introduza o nome/caminho dos ficheiros (use um espaço para separar o nome de cada um): "
		read files
        for file in $files; do
            if file_exists $file;
            then
                size=$(stat -f%z $file)
                printf "${size}kb $file\n"
            else
                printf "ERRO: $file não existe ou não é um ficheiro válido.\n"
            fi
        done
        ;;
    6)
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