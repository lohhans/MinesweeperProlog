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

/*
    Primeiro Passo - First Step:

    PT-BR: A sentenca de parada sera "mines(0) <=> true.", ou seja,
    que o metodo minesweeper vai parar de executar e a execucao do codigo prosseguira;

    Em minesweeper, recebe-se o X e o Y e a quantidade de bombas em N, em seguida,
    sera distribuida as bombas aleatoriamente no campo minado;

    Na condicao "mine(Xm,Ym), [..]" havera uma verificacao que sera explicada abaixo,
    e em "[..], mines(NN)." a execucao volta para a verificacao inicial do metodo, ate que
    chegue na condicao de parada, que eh nao ter mais bombas a distribuir ("mines(0) <=> true.")!

    EN: The stop statement will be "mines(0) <=> true.", that is,
    that the minesweeper method will stop executing and the code execution will continue;

    In minesweeper, the X and Y are received and the number of bombs there be setted in N,
    the bombs will be distributed randomly in the minefield;

    In the condition "mine (Xm, Ym), [..]" there will be a check which will be explained below,
    and in "[..], mines (NN)." execution returns to the initial verification of the method, until
    arrives in the stop condition, which is to have no more bombs to distribute ("mines (0) <=> true.")!
*/
mines(0) <=> true.
minesweeper(X,Y) \ mines(N) <=> NN is N-1,
    random_between(1,X,Xm), random_between(1,Y,Ym),
    mine(Xm,Ym), mines(NN).

/*
    PT-BR: Segundo passo (Substituir duplicados) :

    A expressao "mine(X,Y) \ mine(X,Y) <=> mines(1)." diz que ainda ha mais uma
    bomba a ser alocada no campo minado, o que induz a realocacao da bomba duplicada;

    Em seguida, a expressao "check(A,B) \ check(A,B) <=> true." coloca o valor "true"
    na checagem, removendo a bomba duplicada do campo minado.

    EN: Second step (Replace duplicates):

    The expression "mine(X,Y) \ mine(X,Y) <=> mines(1)." says there is still one more
    bomb to be allocated in the minesweeper, which induces the reallocation of the duplicate bomb;

    Then the expression "check(A,B) \ check(A,B) <=> true." sets the value "true"
    in checking, removing the duplicate bomb from the minefield.
*/
mine(X,Y) \ mine(X,Y) <=> mines(1). %Substituir duplicados /Replace Duplicates
check(A,B) \ check(A,B) <=> true. %Remove duplicados de check(A,B) / Remove Duplicates of check(A,B)
