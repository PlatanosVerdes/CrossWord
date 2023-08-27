% ------------------------------------
%              CROSWORD
% ------------------------------------

%Acces als fitxer externs
:-consult(auxiliar).
:-consult(diccionari).

/* Obtenir, en forma de llista de caracters, totes les possibles paraules, siguin a
l'endret o al reves */
paraula(X):-
    member(Y,[democracia, encontrarse, emboscar, abordaje, convexo, evadirse, elevarse, escuela, cuerpo, jugar, juicio, error, vicio, rea]),
    atom_chars(Y, X).
paraula(X):-
    member(Y,[democracia, encontrarse, emboscar, abordaje, convexo, evadirse, elevarse, escuela, cuerpo, jugar, juicio, error, vicio, rea]),
    atom_chars(Y, Z), reverse(Z,X).

/* Igual que paraula(X), pero agafant les paraules del diccionari.pl */
paraula2(X):-
    paraula(_,_,Y,nom,comu,_,_,_,_,_,_,_,_,_,_),   % noms comuns
    paraula(_,_,Y,adjectiu,_,_,_,_,_,_,_,_,_,_,_), % adjectius
    paraula(_,_,Y,verb,_,_,_,_,_,_,_,_,_,_,_),     % verbs
    atom_chars(Y, X).
paraula2(X):-
    paraula(_,_,Y,nom,comu,_,_,_,_,_,_,_,_,_,_),   % noms comuns
    paraula(_,_,Y,adjectiu,_,_,_,_,_,_,_,_,_,_,_), % adjectius
    paraula(_,_,Y,verb,_,_,_,_,_,_,_,_,_,_,_),     % verbs
    atom_chars(Y, Z), reverse(Z,X).

/* Mirar si a una llista de paraules, hi ha una paraula repetida: */
repetides([X|L]):-
    member(X,L),!.
repetides([X|L]):-
    reverse(X,Y),
    member(Y,L),!.
repetides([_|L]):-
    repetides(L).

/* Dibuixa una paraula a la posicio que toca.
mostra(Paraula,Fila,Columna,Orientacio)

Horitzontal: 3 caracters en blanc
Vertical: 1 Fila en blanc
*/
mostra([],_,_,_).
mostra([P|L],X,Y,horitzontal):-
    gotoXY(X,Y),
    escriu(P,vermell),
    Y1 is Y+3,
    mostra(L,X,Y1,horitzontal).
mostra([P|L],X,Y,vertical):-
    gotoXY(X,Y),
    escriu(P,blau),
    X1 is X+1,
    mostra(L,X1,Y,vertical).

/* Compara la posició I1 de la paraula W1 amb la posició I2 de la paraula W2 */
interseccio(W1, W2, I1, I2):-
	nth0(I1, W1, E),
    nth0(I2, W2, E).

/* Resolucio del tauler del enunciat, comprovant les interseccions amb les paraules
corresponents. Adjuntam una imatge per una millor comprensio del codi */
creuats:-
    paraula(W1), length(W1,7),
    paraula(W2), length(W2,11),
    interseccio(W1,W2,4,0),
    not(repetides([W1,W2])),

    paraula(W3), length(W3,5),
    interseccio(W2,W3,2,2),
    not(repetides([W1,W2,W3])),

    paraula(W4), length(W4,7),
    interseccio(W2,W4,10,4),
    not(repetides([W1,W2,W3,W4])),

    paraula(W5), length(W5,3),
    interseccio(W4,W5,6,2),
    not(repetides([W1,W2,W3,W4,W5])),

    paraula(W6), length(W6,8),
    interseccio(W4,W6,2,5),
    not(repetides([W1,W2,W3,W4,W5,W6])),

    paraula(W7), length(W7,10),
    interseccio(W6,W7,7,5),
    not(repetides([W1,W2,W3,W4,W5,W6,W7])),

    paraula(W8), length(W8,8),
    interseccio(W6,W8,0,7),
    not(repetides([W1,W2,W3,W4,W5,W6,W7,W8])),

    paraula(W9), length(W9,6),
    interseccio(W8,W9,5,3),
    not(repetides([W1,W2,W3,W4,W5,W6,W7,W8,W9])),

    paraula(W10), length(W10,8),
    interseccio(W8,W10,3,4),
    not(repetides([W1,W2,W3,W4,W5,W6,W7,W8,W9,W10])),

    paraula(W11), length(W11,6),
    interseccio(W10,W11,2,5),
    not(repetides([W1,W2,W3,W4,W5,W6,W7,W8,W9,W10,W11])),

    paraula(W12), length(W12,5),
    interseccio(W11,W12,0,0),
    not(repetides([W1,W2,W3,W4,W5,W6,W7,W8,W9,W10,W11,W12])),

    paraula(W13), length(W13,8),
    interseccio(W8,W13,0,0),
    not(repetides([W1,W2,W3,W4,W5,W6,W7,W8,W9,W10,W11,W12,W13])),

    paraula(W14), length(W14,5),
    interseccio(W13,W14,5,1),
    not(repetides([W1,W2,W3,W4,W5,W6,W7,W8,W9,W10,W11,W12,W13,W14])),

    cls,
    mostra(W1,5,21,horitzontal),nl,
    mostra(W2,5,33,vertical),nl,
    mostra(W3,7,27,horitzontal),nl,
    mostra(W4,15,21,horitzontal),nl,
    mostra(W5,13,39,vertical),nl,
    mostra(W6,10,27,vertical),nl,
    mostra(W7,17,12,horitzontal),nl,
    mostra(W8,10,6,horitzontal),nl,
    mostra(W9,7,21,vertical),nl,
    mostra(W10,6,15,vertical),nl,
    mostra(W11,8,0,horitzontal),nl,
    mostra(W12,8,0,vertical),nl,
    mostra(W13,10,6,vertical),nl,
    mostra(W14,15,3,horitzontal),nl,

    gotoXY(18,0).

/* Solucio del tauler amb al diccionari extern */
creuats2:-
    paraula2(W1), length(W1,7),
    paraula2(W2), length(W2,11),
    interseccio(W1,W2,4,0),
    not(repetides([W1,W2])),

    paraula(W3), length(W3,5),
    interseccio(W2,W3,2,2),
    not(repetides([W1,W2,W3])),

    paraula2(W4), length(W4,7),
    interseccio(W2,W4,10,4),
    not(repetides([W1,W2,W3,W4])),

    paraula2(W5), length(W5,3),
    interseccio(W4,W5,6,2),
    not(repetides([W1,W2,W3,W4,W5])),

    paraula2(W6), length(W6,8),
    interseccio(W4,W6,2,5),
    not(repetides([W1,W2,W3,W4,W5,W6])),

    paraula2(W7), length(W7,10),
    interseccio(W6,W7,7,5),
    not(repetides([W1,W2,W3,W4,W5,W6,W7])),

    paraula2(W8), length(W8,8),
    interseccio(W6,W8,0,7),
    not(repetides([W1,W2,W3,W4,W5,W6,W7,W8])),

    paraula2(W9), length(W9,6),
    interseccio(W8,W9,5,3),
    not(repetides([W1,W2,W3,W4,W5,W6,W7,W8,W9])),

    paraula2(W10), length(W10,8),
    interseccio(W8,W10,3,4),
    not(repetides([W1,W2,W3,W4,W5,W6,W7,W8,W9,W10])),

    paraula2(W11), length(W11,6),
    interseccio(W10,W11,2,5),
    not(repetides([W1,W2,W3,W4,W5,W6,W7,W8,W9,W10,W11])),

    paraula2(W12), length(W12,5),
    interseccio(W11,W12,0,0),
    not(repetides([W1,W2,W3,W4,W5,W6,W7,W8,W9,W10,W11,W12])),

    paraula2(W13), length(W13,8),
    interseccio(W8,W13,0,0),
    not(repetides([W1,W2,W3,W4,W5,W6,W7,W8,W9,W10,W11,W12,W13])),

    paraula2(W14), length(W14,5),
    interseccio(W13,W14,5,1),
    not(repetides([W1,W2,W3,W4,W5,W6,W7,W8,W9,W10,W11,W12,W13,W14])),

    cls,
    mostra(W1,5,21,horitzontal),nl,
    mostra(W2,5,33,vertical),nl,
    mostra(W3,7,27,horitzontal),nl,
    mostra(W4,15,21,horitzontal),nl,
    mostra(W5,13,39,vertical),nl,
    mostra(W6,10,27,vertical),nl,
    mostra(W7,17,12,horitzontal),nl,
    mostra(W8,10,6,horitzontal),nl,
    mostra(W9,7,21,vertical),nl,
    mostra(W10,6,15,vertical),nl,
    mostra(W11,8,0,horitzontal),nl,
    mostra(W12,8,0,vertical),nl,
    mostra(W13,10,6,vertical),nl,
    mostra(W14,15,3,horitzontal),nl,

    gotoXY(18,0).
