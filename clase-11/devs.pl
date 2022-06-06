programaEn(nahuel, javascript).
programaEn(juan, haskell).
programaEn(juan, ruby).
programaEn(caro, haskell).
programaEn(caro, scala).

% programaEn(Estudiante, _).
% Estudiante = nahuel ;
% Estudiante = juan ;
% Estudiante = juan ;
% Estudiante = caro ;
% Estudiante = caro.

colegas(Persona, Colega):-
    programaEn(Persona, Lenguaje),
    programaEn(Colega, Lenguaje),
    Persona \= Colega.

% Queremos implementar si una persona puede
% aprender un lenguaje de otra.
%
% Esto se cumple cuando la primera
% no programa en ese lenguaje y la segunda sí.

puedeAprenderDe(Estudiante, Mentor, Lenguaje):-
    programaEn(Estudiante, _),
    programaEn(Mentor, Lenguaje),
    not(programaEn(Estudiante, Lenguaje)).

% Estudiante = nahuel ; Lenguaje = haskell
% Estudiante = nahuel ; Lenguaje = scala
% Estudiante = juan ; Lenguaje = scala
% Estudiante = juan ; Lenguaje = scala

:-begin_tests(clase1).

test(si_usan_el_mismo_lenguaje_son_colegas, nondet):-
    colegas(juan, caro).

test(si_no_usan_el_mismo_lenguaje_no_son_colegas):-
    \+ colegas(nahuel, juan).

test(un_estudiante_puede_aprender_un_lenguaje_de_un_mentor_si_el_estudiante_no_lo_conoce_y_el_mentor_si):-
    puedeAprenderDe(nahuel, caro, scala).

test(un_estudiante_no_puede_aprender_un_lenguaje_si_ya_lo_conoce):-
    \+ puedeAprenderDe(caro, juan, haskell).

test(un_mentor_no_puede_enseniar_un_lenguaje_si_no_lo_conoce):-
    \+ puedeAprenderDe(caro, nahuel, ruby).

test(una_persona_no_puede_ser_mentora_de_si_misma):-
    \+ puedeAprenderDe(caro, caro, haskell).

:-end_tests(clase1).


% instrucciones para el interprete de prolog

% abrir prolog: swipl en la terminal

% todos estos comandos son adentro de swipl:
% salir de swipl: halt.
% recargar el codigo en swipl: make.
% correr los tests: run_tests(NombreSuiteDeTests).