/**---------------------------------------**/
/**                                       **/
/**            GAME INTERFACE             **/
/**                                       **/
/**---------------------------------------**/

/*
    1 - chr_constraint
    PT-BR: Definindo a restricao de parâmetros para os metodos
    EN: Defining the parameter constraint for the methods

    2 - info/3
    PT-BR: Em info/3 sera usada essa declaracao: info(X,Y,Mines)
    onde X (linha) e Y (coluna) eh o limite da matriz do campo minado e N eh o numero de bombas
    EN: In info/3 this statement will be used: info(X,Y,Mines)
    where X (line) and Y (column) is the boundary of the array of the minesweeper and N eh the number of pumps
*/
:- chr_constraint info/3.
