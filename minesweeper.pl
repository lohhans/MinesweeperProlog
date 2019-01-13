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
    putting A (line) and B (column) and verifying that house of the array of the minesweeper.

    6 - field/3
    PT-BR: Em field/3 sera usada essa declaracao: field(X,Y,N)
    onde X (linha) e Y (coluna) eh uma casa da matriz do campo minado e N eh o numero de bombas ao redor dela
    EN: In field/3 this statement will be used: field(X,Y,N)
    where X (line) and Y (column) is one house of the array of the minesweeper and N is the number of bombs around it
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

/*
    PT-BR: Terceiro passo (Remover checador "check/2" além dos limites de "minesweeper/2") :

    Em "minesweeper(Xmax,Ymax)" eh recebido o X e o Y maximo da matriz;

    Em "check(X,Y)" sera checado a casa (X,Y) da matriz do campo minado, e verificado se
    e somente se, as seguintes condicoes NAO forem satisfeitas, que estao definidas em
    "X < 1; Y < 1; X > Xmax; Y > Ymax", que nada mais eh que: X e Y nao podem ser menores
    ou maiores que o limite inferior e o superior da matriz, respectivamente.

    EN: Third step (Remove "check/2" beyond the "minesweeper/2" boundaries):

    In "minesweeper (Xmax,Ymax)" there is received the maximum X and Y of the array;

    In "check (X,Y)" will be checked the house (X,Y) of the array of the minesweeper, and checked if
    and only if, the following conditions are NOT met, which are defined in
    "X < 1; Y < 1; X > Xmax; Y > Ymax", which is nothing more than: X and Y can they can not be smaller
     or greater than the lower and upper limits of the array, respectively.
*/
minesweeper(Xmax,Ymax) \ check(X,Y) <=> X < 1; Y < 1; X > Xmax; Y > Ymax | true.

/*
    PT-BR: Quarto passo (Verificacao: Mina encontrada)

    Na expressao "check(X,Y), mine(X,Y) <=> write('Voce perdeu! Isso era uma bomba!'),
    eh verificado um campo com bomba que retorna a mensagem "Voce perdeu! Isso era uma bomba!"
    e acaba a execucao. (halt == break)

    EN: Fourth step (Check: Mine found)

    In the expression "check(X,Y), mine(X,Y) <=> write('Voce perdeu! Isso era uma bomba!')
    is checked a bomb field that returns the message "Voce perdeu! Isso era uma bomba!"
    and the execution is finished. (halt == break)
*/
check(X,Y), mine(X,Y) <=> write('Voce perdeu! Isso era uma bomba!'), nl, halt. %EN: 'You lose! That was a mine!'

/*
    PT-BR: Quinto passo (Verificacao: Contar minas vizinhas)

    Em "check(X,Y), mine(Xmine,Ymine)" sera checado a casa (X,Y) da matriz do campo minado, como tambem,
    sera comparado a uma coordenada (Xmine,Ymine) de uma bomba vizinha, que esteja ao redor desta casa (X,Y);

    Ou seja, nas duas expressoes, listadas abaixo, sao analisados os vizinhos da casa (X,Y) checada,
    ao verificar que ha bomba ele incrementa o 'contador de bombas vizinhas' com "field(X,Y,1)";

    Apos todas as checagens, em "field(X,Y,N1), field(X,Y,N2) <=> N is N1+N2 | field(X,Y,N)." eh substituido
    o valor de N da casa (X,Y) checada pela soma de todas as bombas encontradas.

    Obs: A soma eh feita a cada duas bombas encontradas, ou seja, se por exemplo houverem tres bombas ao redor, "A", "B" e "C",
    sera somada "A" + "B", 1 + 1, atualizando o valor de N da casa (X,Y) para 2, em seguida o codigo volta a somar
    o restante das bombas que faltam, neste caso somente mais uma, "C", entao sera somado o valor de N + 1,
    e entao sera atualizado novamente o valor de N para 3, que eh a quantidade de bombas ao redor desta casa (X,Y).

    EN: Fifth step (Check: Count neighboring mines)

    In "check(X,Y), mine(Xmine,Ymine)" the house (X,Y) from the array of the minesweeper will be checked, as also,
    will be compared to a coordinate (Xmine,Ymine) of a neighboring bomb that is around this house (X,Y);

    That is, in the two expressions, listed below, the neighbors of the house (X,Y) checked,
    when checking that there is a bomb it increases the 'neighboring bomb counter' with "field(X,Y,1)";

    After all the checks, in "field(X,Y,N1), field(X,Y,N2) <=> N is N1 + N2 | field(X,Y,N)." is replaced
    the value of N of the house (X,Y) checked by the sum of all the pumps found.

    Note: The sum is done every two bombs found, ie if there are three bombs around, "A", "B" and "C", for example,
    will be added "A" + "B", 1 + 1, updating the value of N of the house (X,Y) to 2, then the code returns to add
    the remainder of the missing bombs, in this case only one more, "C", then the value of N + 1 will be added,
    so the value of N will be 3, which is the number of pumps around this house (X,Y).
*/
check(X,Y), mine(Xmine,Ymine) ==>
  Xmine =< X+1, Xmine >= X-1,
  Ymine =< Y+1, Ymine >= Y-1 |
  field(X,Y,1).

field(X,Y,N1), field(X,Y,N2) <=> N is N1+N2 | field(X,Y,N).

/*
    PT-BR: Sexto passo (Verificacao: Adicionar padrao em "field/3")

    Na expressao, listada abaixo, todos os campos os quais nao ha bombas como vizinhos,
    recebem o valor de zero minas na vizinhanca do referido campo.

    Obs: Quando eh descoberto que nao ha bombas, eh mostrado um campo vazio " ".

    EN: Sixth step (Check: Add default field/3)

    In the expression, listed below, all fields which have no bombs as neighbors,
    receive the value of zero mines in the vicinity of said field.

    Note: When it is discovered that there are no bombs, an empty field  " " is shown.
*/
check(X,Y) ==> field(X,Y,0).

/*
    PT-BR: Setimo passo (Verificar todos os vizinhos do field(X,Y,0))

    Na expressao, listada abaixo, todos os campos vizinhos da casa (X,Y) da matriz do campo minado,
    sao verificados e atribuidos os devidos valores em relacao as bombas que a circunda, cada checagem eh
    realizada a partir da logica da checagem individual, descrita acima.

    EN: Seventh step (Check all neighbors of field(X,Y,0))

    In the expression, listed below, all the neighboring fields of the house (X,Y) of the array of the minesweeper,
    are checked and given the appropriate values ​​in relation to the bombs surrounding it,
    each check is performed from the logic of the individual check described above.
*/
check(X,Y), field(X,Y,0) ==> Xm is X-1, Xp is X+1, Ym is Y-1, Yp is Y+1,
  check(X,Ym), check(X,Yp),
  check(Xm,Y), check(Xp,Y),
  check(Xm,Ym), check(Xm,Yp),
  check(Xp,Ym), check(Xp,Yp).

:- include('play.pl').
