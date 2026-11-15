% Lab 9 Activity: The Name Game
:- dynamic letter/1.

% Initial set of letters
letter(a).
letter(b).
letter(c).

start :-
    nl,
    write('Hi, This is the "Name Game".'), nl,
    write('You will be given a set of English letters in which you will add, delete or move to create your name.'), nl,
    menu.

menu :-
    nl,
    write('Choose from the following:'), nl,
    write('1- Display the current set of letters'), nl,
    write('2- Add a letter'), nl,
    write('3- Add a letter at the top'), nl,
    write('4- Add a letter at the bottom'), nl,
    write('5- Delete a letter'), nl,
    write('6- Delete all letters'), nl,
    write('7- Exit'), nl,
    write('Enter your choice....'), nl,
    read(Choice),
    choice(Choice).

% 7 = exit: stop the loop (no call to menu)
choice(7) :- !, write('Goodbye!'), nl.

choice(C) :- option(C), !, menu.

choice(_) :- write('Invalid choice, try again.'), nl, menu.

% 1- Display
option(1) :-
    write('Current letters: '),
    display_letters.

% 2- Add a letter (assert = added at the end)
option(2) :-
    write('Enter the letter: '), nl,
    read(L),
    assert(letter(L)),
    write(L), write(' added.'), nl.

% 3- Add at the top (asserta)
option(3) :-
    write('Enter the letter: '), nl,
    read(L),
    asserta(letter(L)),
    write(L), write(' added at the top.'), nl.

% 4- Add at the bottom (assertz)
option(4) :-
    write('Enter the letter: '), nl,
    read(L),
    assertz(letter(L)),
    write(L), write(' added at the bottom.'), nl.

% 5- Delete a letter (retract removes the first match)
option(5) :-
    write('Enter the letter to delete: '), nl,
    read(L),
    (   retract(letter(L))
    ->  write(L), write(' deleted.'), nl
    ;   write(L), write(' is not in the set.'), nl
    ).

% 6- Delete all (retractall always succeeds)
option(6) :-
    retractall(letter(_)),
    write('All letters deleted.'), nl.

% Print every letter on one line, using fail-driven backtracking
display_letters :-
    \+ letter(_), !,
    write('(empty)'), nl.
display_letters :-
    letter(X), write(X), tab(1), fail.
display_letters :-
    nl.
