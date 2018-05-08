#!/bin/bash

# Sub menu 3 script

function draw_menu {
    printf "\nCOMANDOS DE BACKUP\n\n"
    printf "1 – Cópia de proteção de diretório passado como parâmetro\n"
    printf "2 – Cópia de proteção do diretório HOME (necessita de permissões de administrador)\n"
    printf "3 – Sair: Retorno ao menu principal\n\n"
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
		printf "Introduza o destino (1º parâmetro) e o diretório que pretender efectuar backup (segundo parâmetro): "
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
            printf "ERRO: Número de parâmetros introduzidos errado.\n\n"
        else
            if folder_exists $SRCDIR;
            then
                mkdir -p $DESTDIR
                # sed -e 's/\//-/g -> Replace / with -
                FILENAME=backup-$(echo $SRCDIR | sed -e 's/\//-/g')-$(date +%-Y%-m%-d)-$(date +%-T).tgz
                tar --create -P --gzip --file=$DESTDIR$FILENAME $SRCDIR
                
                printf "Cópia de proteção do diretório $SRCDIR efetuado com sucesso.\n"
            else
                printf "ERRO: $SRCDIR não existe ou não é um ficheiro válido.\n"
            fi
        fi
		;;
	2)
        sudo mkdir -p /BACK/HOME
        SRC=$HOME
        DESTINATION="/BACK/HOME/"
        FILENAME=backup-$(echo $SRC | sed -e 's/\//+/g')-$(date +%-Y%-m%-d)-$(date +%-T).tgz
        sudo tar cvzf $DESTINATION$FILENAME -P $SRC
        
        printf "Cópia de proteção do diretório $SRC (\$HOME) efetuado com sucesso.\n"
		;;
	3)
		exit 42
		;;
    *)
        printf "ERRO: Opção de entrada inválida.\n\n"
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