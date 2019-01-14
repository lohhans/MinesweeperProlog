#!/bin/bash
# EN: Starting the game...
echo "Iniciando jogo..."
echo ""
if ! swipl -s minesweeper -g main
then
    # EN: Could not start the game. Make sure you have Prolog installed and all the necessary files!
    echo ""
    echo "Não foi possível iniciar o jogo. Verifique se você possui o Prolog instalado e todos o arquivos necessários!"
    exit 1
fi
