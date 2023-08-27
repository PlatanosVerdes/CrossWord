elements([],0).
elements([_|Y],N):-elements(Y,N1), N is N1+1.

pertany(X,[X|_]).
pertany(X,[_|L]):-pertany(X,L).

afegir([],L,L).
afegir([X|L1],L2,[X|L3]):-afegir(L1,L2,L3).

darrer([X],X).
darrer([_|Y],X):-darrer(Y,X).

invertir([],[]).
invertir([X|L1],L2):-invertir(L1,L3), afegir(L3,[X],L2).

esborrar(_,[],[]).
%Si el elemento primero es igual, devuelve Y
esborrar(X,[X|Y],Y).
%Ponemos el X\=E por que no significa que no tengan valores diferentes
esborrar(X,[E|Y],[E|L2]):- X\=E,esborrar(X,Y,L2).
%Borrar TODOS los elementos:
%esborrar(_,[],[]).
%esborrar(X,[X|Y],L):-esborrar(X,Y,L).
%esborrar(X,[X1|Y],L):-X\=X1, esborrar(X,Y,L2), L=[X1|L2].

%Sumar elementos de una lista
sumar([],0).
sumar([X|Y],N):-sumar(Y,L),N is L+X.

%Maximo de una lista
maxim([X],X).
maxim([X,Y|L],Z):- Y>=X, !, maxim([Y|L],Z).
maxim([X,_|L],Z):-maxim([X|L],Z).

%Permutaciones d'un lista
inserir(E,L,[E|L]).
inserir(E,[X|Y],[X|Z]):-inserir(E,Y,Z).
permutacio([],[]).
permutacio([X|Y],Z):-permutacio(Y,L),inserir(X,L,Z).

repetides([]):-false.
repetides([X|L]):-member(X,L),repetides(L).

