# Campo Minado

> [English version below](https://github.com/lohhans/MinesweeperProlog#english-below)

Aplicação simples de Campo Minado escrita em Prolog e Regras de Manipulação de Restrições (CHR). Foi criado como um exercício para a disciplina "Paradigmas de Linguagens de Programação", no curso de [Ciência da Computação na Universidade Federal Rural de Pernambuco](http://bcc.uag.ufrpe.br/~portal/).

## Uso

O programa completo pode ser usado programaticamente especificando algumas restrições `minesweeper/2`, `mine/2` (or `mines/1`) e `check/2`.

Para iniciar um jogo Minesweeper com esta implementação Prolog/CHR, você pode simplesmente usar o predicado `main`. Primeiro carregue o código fonte, por exemplo com [SWI-Prolog](http://www.swi-prolog.org/):

	$ swipl -s minesweeper -g main

Então inicializará um novo jogo após escolher as condições de início *(exemplo 8x8)*:

	[Inicializacao]
      Numero de linhas:  |: 8.
      Numero de colunas: |: 8.
      Numero de minas:   |: 10.

    [Tempo atual: 0 segundos]
	   | 1 2 3 4 5 6 7 8 |   
	---+-----------------+---
	 1 | . . . . . . . . | 1
	 2 | . . . . . . . . | 2
	 3 | . . . . . . . . | 3
	 4 | . . . . . . . . | 4
	 5 | . . . . . . . . | 5
	 6 | . . . . . . . . | 6
	 7 | . . . . . . . . | 7
	 8 | . . . . . . . . | 8
	---+-----------------+---
	   | 1 2 3 4 5 6 7 8 |   

Agora você pode escolher campos desconhecidos, especificando suas linhas e colunas:

    [Escolher localizacao]
      Linha:    |: 1.
      Coluna:   |: 1.

	[Tempo atual: 2 segundos]
	   | 1 2 3 4 5 6 7 8 |   
	---+-----------------+---
	 1 |     1 . . . . . | 1
	 2 |     1 . . . . . | 2
	 3 | 1 1 1 . . . . . | 3
	 4 | . . . . . . . . | 4
	 5 | . . . . . . . . | 5
	 6 | . . . . . . . . | 6
	 7 | . . . . . . . . | 7
	 8 | . . . . . . . . | 8
	---+-----------------+---
	   | 1 2 3 4 5 6 7 8 |   

Além da versão original, você não pode sinalizar minas, então você deve ter isso em mente.

## Passo a passo

O Minesweeper é um simples jogo de computador, ganhou popularidade principalmente por estar instalado na plataforma Windows por padrão. O objetivo do jogo é buscar as minas em um campo de jogo usando algum raciocínio.

Portanto, o jogador pode revelar alguns campos. Se houver uma mina neste campo, o jogo está perdido. Caso contrário, haverá um número que representa as minas vizinhas. Este número pode, portanto, ser 8 no máximo.

Queremos implementar a lógica de jogo por trás do Minesweeper no Prolog/CHR para criar um aplicativo baseado em texto. O dado `play.pl` já contém os predicados do Prolog necessários para a entrada e saída. É usado pelo dado `minesweeper.pl` que deve ser completado nos seguintes passos.

Para lembrar o tamanho do campo de jogo, usamos uma restrição `minesweeper/2`. Um campo de jogo com 6 linhas e 8 colunas pode ser modelado da seguinte forma:

	?- minesweeper(6,8).
	minesweeper(6,8)
	true.

#### 1 - Gerar minas

Uma única mina é modelada por uma restrição `mine/2`. Portanto, `mine(3,5)` representa uma mina na terceira linha e quinta coluna. As minas devem ser geradas aleatoriamente. Portanto, uma restrição `mines/1` com a quantidade de minas pode ser dada. Use esta restrição para criar recursivamente as minas no campo de jogo. A restrição `mines(0)` restante deve ser removida do repositório de restrições.

**Dica:**
Use o predicado pré-definido do Prolog `random_between(1,X,R)` para criar um inteiro aleatório `R` entre`1` e `X`. Usando a restrição `minesweeper/2` você pode obter as coordenadas máximas da mina.

**Exemplo com minas aleatórias:**

	?- minesweeper(6,8), mines(4).
	minesweeper(6,8)
	mine(4,1)
	mine(5,5)
	mine(4,1)
	mine(6,4)
	true .

#### 2 - Substituir duplicados

Como você pode ver no exemplo anterior, pode haver várias minas com as mesmas coordenadas. Adicione uma regra para substituir essa duplicata por uma nova mina.

**Exemplo com minas aleatórias:**

	?- minesweeper(6,8), mine(4,1), mine(4,1).
	minesweeper(6,8)
	mine(6,6)
	mine(4,1)
	true .

#### 3 - Remova `check/2` além dos limites de `minesweeper/2`  <sub>(não verifique além do limite da matriz)</sub>

A revelação de um campo pelo jogador é modelada por uma restrição `check/2`. `check (3,4)` significa que o jogador abre a terceira linha e a quarta coluna. Para evitar múltiplas revelações do mesmo campo, usamos a seguinte [regra de simpatia](http://www.swi-prolog.org/pldoc/man?section=SyntaxAndSemantics) para removê-las:

	check(A,B) \ check(A,B) <=> true.

Além disso, nós removemos todas as restrições `check/2` fora do campo de jogo dadas por `minesweeper/2`. Implemente isso por uma ou mais [regras de simpatia](http://www.swi-prolog.org/pldoc/man?section=SyntaxAndSemantics).

**Exemplo:**

	?- minesweeper(6,8), check(4,9), check(0,3), check(3,4), check(5,-1).
	minesweeper(6,8)
	check(3,4)
	true .

#### 4 - Verificar: Mina encontrada

Agora queremos testar se existe uma mina na posição dada por `check/2`. Implemente uma regra que escreva `Voce perdeu! Ai tinha uma bomba!` para a saída padrão e termine o programa via `halt/0` neste caso.

**Exemplo:**

	?- mine(3,4), check(3,4).
	That was a mine!%

#### 5 - Verificar: contar minas vizinhas

Se não houver mina na posição dada por `check/2`, o número de minas vizinhas deve ser calculado. Este número `Mines` deve ser mantido em uma restrição `field(X,Y,Mines)` para a posição`(X,Y)`.

**Dica:** Propagar para cada vizinho um campo `(X,Y,1)`. Depois, essas restrições podem ser somadas.

**Exemplo:**

	?- mine(3,3), mine(1,4), mine(2,4), check(3,4), check(6,6).
	mine(2,4)
	mine(1,4)
	mine(3,3)
	field(3,4,2)
	check(6,6)
	check(3,4)
	true .

#### 6 - Verificar: Adicionar restrição padrão `field/3`

Para criar uma restrição `field/3` para os campos sem qualquer mina vizinha, você deve criar uma restrição `field(X,Y,0)` também. Implemente uma regra de propagação que crie essas restrições.

**Exemplo:**

	?- mine(3,3), mine(1,4), mine(2,4), check(3,4), check(6,6).
	mine(2,4)
	mine(1,4)
	mine(3,3)
	field(6,6,0)
	field(3,4,2)
	check(6,6)
	check(3,4)
	true .

#### 7 - Verifique todos os vizinhos de `field(X,Y,0)`

Se os jogadores revelarem um campo sem qualquer mina vizinha, apenas uma restrição de `field(X,Y,0)` será criada. Na representação ASCII, este campo estará vazio. Como esse campo não tem mina vizinha, o player abrirá os campos vizinhos, desde que nenhum número maior que 0 apareça. Por isso, seus campos vizinhos são revelados na versão do Windows por padrão.

Implemente uma regra que revele todos os campos vizinhos para a restrição `check/2` atual, uma vez que ela não tem o meu vizinho.

<sub>Graças ao template compartilhado [neste repositório](https://github.com/fnogatz/CHR-Minesweeper/)</sub>

---

## **English below:**

---

# Minesweeper

Simple Minesweeper application written in Prolog and Constraint Handling Rules (CHR). It was created as an exercise for the "Paradigms of Programming Languages" discipline, in the course of [Computer Science at the Federal Rural University of Pernambuco](http://bcc.uag.ufrpe.br/~portal/).

## Usage

The complete program can be programmatically used by specifying some `minesweeper/2`, `mine/2` (or `mines/1`) and `check/2` constraints.

To start a Minesweeper game with this Prolog/CHR implementation you can simply use the `main` predicate. First load the source code, for example with [SWI-Prolog](http://www.swi-prolog.org/):

	$ swipl -s minesweeper -g main

You will then start a new game after choosing the start conditions *(example 8x8)*:

	?- main.
	[Initialization]
	  Number of Rows:    8.
	  Number of Columns: 8.
	  Number of Mines:   10.
	[Current Field - 0 Seconds]
	   | 1 2 3 4 5 6 7 8 |   
	---+-----------------+---
	 1 | . . . . . . . . | 1
	 2 | . . . . . . . . | 2
	 3 | . . . . . . . . | 3
	 4 | . . . . . . . . | 4
	 5 | . . . . . . . . | 5
	 6 | . . . . . . . . | 6
	 7 | . . . . . . . . | 7
	 8 | . . . . . . . . | 8
	---+-----------------+---
	   | 1 2 3 4 5 6 7 8 |   

Now you can check unknown fields by specifying their row and column:

	[Check Location]
	  Row:    1.
	  Column: 1.

	[Current Field - 2 Seconds]
	   | 1 2 3 4 5 6 7 8 |   
	---+-----------------+---
	 1 |     1 . . . . . | 1
	 2 |     1 . . . . . | 2
	 3 | 1 1 1 . . . . . | 3
	 4 | . . . . . . . . | 4
	 5 | . . . . . . . . | 5
	 6 | . . . . . . . . | 6
	 7 | . . . . . . . . | 7
	 8 | . . . . . . . . | 8
	---+-----------------+---
	   | 1 2 3 4 5 6 7 8 |   

Other than the original version you can not flag mines, so you have to keep them in mind.

## Step by step

Minesweeper is a simple computer game, gained its popularity especially from being installed at the Windows platform by default. The aim of the game is to seek the mines on a playing field by using some reasoning.

Therefor the player can reveal some fields. If there is a mine on this field, the game is lost. Otherwise there will be a number which stands for the neighboring mines. This number can therefor be 8 at its maximum.

We want to implement the playing logic behind Minesweeper in Prolog/CHR to create a text-based application. The given `play.pl` already contains the required Prolog predicates for the input and output. It is used by the given `minesweeper.pl` which has to be completed in the following tasks.

To remember the size of the playing field, we use a `minesweeper/2` constraint. A playing field with 6 rows and 8 columns can therefor be modelled as follows:

	?- minesweeper(6,8).
	minesweeper(6,8)
	true.

#### 1 - Generate Mines

A single mine is modelled by a `mine/2` constraint. Therefor `mine(3,5)` represents a mine in the third row and fifth column. The mines should be generated randomly. Therefor a `mines/1` constraint with the amount of mines might be given. Use this constraint to recursively create the mines at the playing field. The remaining `mines(0)` constraint should be removed from the constraint store.

**Tip:**
Use Prolog's predefined predicate `random_between(1,X,R)` to create a random integer `R` between `1` and `X`. By using the `minesweeper/2` constraint you can get the maximum coordinates of the mine.

**Example with random mines:**

	?- minesweeper(6,8), mines(4).
	minesweeper(6,8)
	mine(4,1)
	mine(5,5)
	mine(4,1)
	mine(6,4)
	true .

#### 2 - Replace duplicates

As you can see in the previous example, there might be multiples mines with the same coordinates. Add a rule to replace such a duplicate by a new mine.

**Example with random mines:**

	?- minesweeper(6,8), mine(4,1), mine(4,1).
	minesweeper(6,8)
	mine(6,6)
	mine(4,1)
	true .

#### 3 - Remove `check/2` beyond the `minesweeper/2` boundaries <sub>(don't check beyond the boundary of the array)</sub>

The revelation of a field by the player is modelled by a `check/2` constraint. `check(3,4)` therefor means, that the the player opens the the third row and fourth column. To prevent multiple revelations of the same field, we use the following [simpagation rule](http://www.swi-prolog.org/pldoc/man?section=SyntaxAndSemantics) to remove them:

	check(A,B) \ check(A,B) <=> true.

Besides that we wand to remove all `check/2` constraints outside of the playing field given by `minesweeper/2`. Implement this by one or more [simpagation rules](http://www.swi-prolog.org/pldoc/man?section=SyntaxAndSemantics).

**Example:**

	?- minesweeper(6,8), check(4,9), check(0,3), check(3,4), check(5,-1).
	minesweeper(6,8)
	check(3,4)
	true .

#### 4 - Check: Mine found

Now we want to test if there is a mine at the position given by `check/2`. Implement a rule that writes `That was a mine!` to the standard output and terminates the program via `halt/0` in this case.

**Example:**

	?- mine(3,4), check(3,4).
	That was a mine!%

#### 5 - Check: Count neighboring Mines

If there is no mine at the position given by `check/2`, the number of neighboring mines must be calculated. This number `Mines` should be hold in a `field(X,Y,Mines)` constraint for the position `(X,Y)`.

**Hint:**
Propage for each neighboring a `field(X,Y,1)`. Afterwards these constraints can be summed.

**Example:**

	?- mine(3,3), mine(1,4), mine(2,4), check(3,4), check(6,6).
	mine(2,4)
	mine(1,4)
	mine(3,3)
	field(3,4,2)
	check(6,6)
	check(3,4)
	true .

#### 6 - Check: Add default `field/3` Constraint

To create a `field/3` constraint for the fields without any neighboring mine you have to create a `field(X,Y,0)` constraint too. Implement a propagation rule that creates these constraints.

**Example:**

	?- mine(3,3), mine(1,4), mine(2,4), check(3,4), check(6,6).
	mine(2,4)
	mine(1,4)
	mine(3,3)
	field(6,6,0)
	field(3,4,2)
	check(6,6)
	check(3,4)
	true .

#### 7 - Check all neighbors of `field(X,Y,0)`

If the players reveals a field without any neighboring mine, only a `field(X,Y,0)` constraint will be created. In the ASCII representation this field will be empty. Because this field has no neighboring mine, the player will consequently open the neighboring fields as long as no number greater than 0 appears. Therefor its neighboring fields are revealed in the Windows version by default.

Implement a rule that reveals all the neighboring fields for the current `check/2` constraint once it has no neighboring mine.

<sub>Thanks to the shared template on [this repository](https://github.com/fnogatz/CHR-Minesweeper/)</sub>
