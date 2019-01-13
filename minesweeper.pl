/*
    PT-BR: Importa o modulo de CHR disponivel em SWI-PROLOG
    EN: Import the CHR module available in SWI-PROLOG
*/
:- use_module(library(chr)).

/*
    1 - chr_constraint
    PT-BR: Definindo a restricao de parâmetros para os metodos
    EN: Defining the parameter constraint for the methods

    2 - mines/1
    PT-BR: Em mines/1 sera usada essa declaracao: mines(X)
    definindo em X a quantidade de bombas no campo minado.
    EN: At mines/1 this statement will be used: mines (X)
    defining in X the number of bombs in the minesweeper.

    3 - mine/2
    PT-BR: Em mine/2 sera usada essa declaracao: mine(X, Y)
    definindo em X (linha) e Y (coluna) onde tera uma bomba no campo minado.
    EN: At mines/1 this statement will be used: mines (X, Y)
    defining in X (line) and Y (column) where it will have a bomb in the minesweeper.

    4 - minesweeper/2
    PT-BR: Em minesweeper/2 sera usada essa declaracao: minesweeper(X,Y)
    definindo as dimencoes X (linhas) e Y (colunas) do campo minado.
    EN: At minesweeper/2 this statement will be used: minesweeper(X,Y)
    defining the dimensions X (rows) and Y (columns) of the minesweeper field.

    5 - check/2
    PT-BR: Em check/2 sera usada essa declaracao: check(A,B)
    passando A (linha) e B (coluna) e vericando aquela casa da matriz do campo minado.
    EN: At check/2 this statement will be used: check(A, B)
    putting A (line) and B (column) and verifying that house of the matrix of the minesweeper.

    6 - field/3
    PT-BR: Em field/3 sera usada essa declaracao: field(X,Y,N)
    onde X (linha) e Y (coluna) eh uma casa da matriz do campo minado e N eh o numero de bombas ao redor dela
    EN: In field/3 this statement will be used: field(X,Y,N)
    where X (line) and Y (column) is one house of the matrix of the minesweeper and N is the number of bombs around it
*/
:- chr_constraint mines/1, mine/2, minesweeper/2, check/2, field/3.
