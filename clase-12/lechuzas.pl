% Registramos las caracterísicas de las lechuzas de la zona (nombre, sospechosidad y nobleza) con un predicado lechuza/3.

% Necesitamos saber:
% 1-¿Qué tan violenta es una lechuza?
% Se calcula como 5 * sospechosidad + 42 / nobleza.
% 2- Si una lechuza es vengativa. Lo es si su violencia es mayor a 100.
% 3- Si una lechuza es mafiosa, que se cumple si no es buena gente o su sospechosidad es al menos 75. Decimos que es buena gente si no es vengativa y su nobleza es mayor a 50.

% lechuza(Nombre, Sospechosidad, Nobleza)
lechuza(hootHoot, 5, 21).
lechuza(coo, 10, 15).
lechuza(rowlet, 20, 42). % es vengativa, por lo tanto no es buena gente => es mafiosa
lechuza(noctowl, 0, 84). % es buena gente y no tiene sosp. alta => no es mafiosa
lechuza(duolingo, 75, 1). % su sosp. es al menos 75 => es mafiosa

violencia(Nombre, Violencia):-
    lechuza(Nombre, Sospechosidad, Nobleza),
    Violencia is 5 * Sospechosidad + 42 / Nobleza.

vengativa(Nombre):-
    violencia(Nombre, Violencia),
    Violencia > 100.

mafiosa(Lechuza) :-
    lechuza(Lechuza, Sospechosidad, _),
    Sospechosidad >= 75.

mafiosa(Lechuza) :-
    lechuza(Lechuza, _, _),
    not(esBuenaGente(Lechuza)).

esBuenaGente(Nombre):-
    lechuza(Nombre,_,Nobleza),
    not(vengativa(Nombre)),
    Nobleza>50.

:- begin_tests(lechuzas).

test(la_violencia_de_una_lechuza_es_5_por_su_sospechosidad_mas_42_dividido_su_nobleza):-
    violencia(hootHoot, 27).

test(una_lechuza_es_vengativa_si_su_violencia_es_mayor_a_100):-
    vengativa(rowlet).

test(una_lechuza_no_es_vengativa_si_su_violencia_es_menor_a_100):-
    not(vengativa(hootHoot)).

% Si una lechuza es mafiosa, que se cumple si no es buena gente o su sospechosidad es al menos 75.

test(una_lechuza_mafiosa_si_su_sospechosidad_es_al_menos_75):-
    mafiosa(duolingo).

test(una_lechuza_no_es_mafiosa_si_es_buena_gente_y_su_sospechosidad_es_menos_de_75):-
    not(mafiosa(noctowl)).

test(una_lechuza_es_buena_gente_si_no_es_vengativa_y_su_nobleza_es_mayor_a_50):-
    esBuenaGente(noctowl).

test(una_lechuza_es_mafiosa_si_no_es_buena_gente) :-
    mafiosa(rowlet).

:- end_tests(lechuzas).

