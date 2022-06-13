programaEn(nahuel, javascript).
programaEn(juan, haskell).
programaEn(juan, ruby).
programaEn(caro, haskell).
programaEn(caro, scala).
programaEn(caro, javascript).
programaEn(Persona, c):-
    persona(Persona).
persona(nahuel).
persona(juan).
persona(caro).

irremplazable(Persona):-
    programaEn(Persona, Lenguaje),
    not((programaEn(OtraPersona, Lenguaje), Persona \= OtraPersona)).

% irremplazable(Persona):-
%     programaEn(Persona, Lenguaje),
%     not(programaEnLenguajeYNoEs(Persona, Lenguaje, OtraPersona)).

programaEnLenguajeYNoEs(Persona, Lenguaje, OtraPersona):-
    programaEn(OtraPersona, Lenguaje),
    Persona \= OtraPersona.

programaEnHaskellYScala(Persona):-
    programaEn(Persona, haskell),
    programaEn(Persona, scala).

% not(programaEn(Persona, javascript)).
% podria parecer que se esta preguntando:
% cuales Personas no programan en javascript
% ERROR

% como se resuelve el not?
% not(programaEn(Persona, javacript)).

% primero se resuelve programaEn(Persona, javascript) -> va a dar true o false
% segundo, el not da vuelta el valor de verdad de esa consulta.
