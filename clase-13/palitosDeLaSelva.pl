% animal(Nombre, Clase, Medio).
animal(ballena, mamifero, acuatico).
animal(tiburon, pez, acuatico).
animal(lemur, mamifero, terrestre).
animal(golondrina, ave, aereo).
animal(tarantula, insecto, terrestre).
animal(lechuza, ave, aereo).
animal(orangutan, mamifero, terrestre).
animal(tucan, ave, aereo).
animal(puma, mamifero, terrestre).
animal(abeja, insecto, aereo).
animal(leon, mamifero, terrestre).
animal(lagartija, reptil, terrestre).

tiene(nico, ballena, 3).
tiene(nico, lemur, 2).
tiene(maiu, lemur, 1).
tiene(maiu, tarantula, 1).
tiene(maiu, tucan, 1).
tiene(maiu, leon, 2).
tiene(juanDS, golondrina, 1).
tiene(juanDS, lechuza, 1).
tiene(juanDS, puma, 1).
tiene(juanDS, lagartija, 1).
tiene(juanR, tiburon, 2).
tiene(nico, golondrina, 1).
tiene(juanR, orangutan, 1).
tiene(feche, tiburon, 1).

animalDificil(Animal):-
    animal(Animal, _, _),
    not(tiene(_, Animal, _)).

animalDificil(Animal):-
    tiene(Quien,Animal,1),
    not((tiene(Quien2,Animal,_), Quien \= Quien2)).

leGusta(nico, Animal):-
    animal(Animal, _, terrestre),
    Animal \= lemur.

leGusta(maiu, Animal):-
    animal(Animal,_,_),
    not(animal(Animal,insecto,_)).

leGusta(maiu,abeja).

leGusta(juanDS, Animal):-
    animal(Animal,_,acuatico).

leGusta(juanDS, Animal):-
    animal(Animal,ave,_).

leGusta(juanR,Animal):-
    tiene(juanR,Animal,_).

leGusta(feche, lechuza).

tieneParaIntercambiar(Persona, Animal):-
    tiene(Persona, Animal, _),
    not(leGusta(Persona, Animal)).

tieneParaIntercambiar(Persona, Animal):-
    tiene(Persona, Animal, Cantidad),
    Cantidad > 1.

tieneParaIntercambiar(juanR, Animal):-
    tiene(juanDS, Animal, _).

tieneParaOfrecerle(QuienOfrece, QuienRecibe):-
    tieneParaIntercambiar(QuienOfrece, Animal),
    leGusta(QuienRecibe, Animal),
    not(tiene(QuienRecibe, Animal, _)).

puedenNegociar(UnaPersona, OtraPersona):-
    tieneParaOfrecerle(UnaPersona, OtraPersona),
    tieneParaOfrecerle(OtraPersona, UnaPersona).

% no tiene ningun animal que le gusta

% estaTriste(Persona):-
%          % E. Animal / tiene(Persona, Animal) ^ leGusta(Persona, Animal)
%     % A . Animal / ~tiene(Persona, Animal) v ~leGusta(Persona, Animal)
%     % A . Animal / ~ (tiene(Persona, Animal) ^ leGusta(Persona, Animal))
%     not((tiene(Persona, Animal, _), leGusta(Persona, Animal))).

% solo tiene animales que        no le gustan
% todos los animales que tiene   no le gustan
estaTriste(Persona):-
    tiene(Persona, _, _),
    forall(tiene(Persona, Animal, _), not(leGusta(Persona, Animal))).

estaFeliz(Persona):-
    tiene(Persona,_, _),
    forall(tiene(Persona, Animal, _), leGusta(Persona, Animal)).

% tieneTodosDe(Persona, Medio):-
%     tiene(Persona, _, _),
%     animal(_, _, Medio),
%     forall(tiene(Persona, Animal, _), animal(Animal, _, Medio)).

% tieneTodosDe(Persona, Clase):-
%     tiene(Persona, _, _),
%     animal(_, Clase, _),
%     forall(tiene(Persona, Animal, _), animal(Animal, Clase, _)).

tieneTodosDe(Persona, ClaseOMedio):-
    tiene(Persona, _, _),
    esDeClaseOMedio(_, ClaseOMedio),
    forall(tiene(Persona, Animal, _), esDeClaseOMedio(Animal, ClaseOMedio)).

esDeClaseOMedio(Animal, Clase):-
    animal(Animal, Clase, _).
esDeClaseOMedio(Animal, Medio):-
    animal(Animal, _, Medio).


completoLaColeccion(Persona):-
    tiene(Persona, _, _),
    forall(animal(Animal, _, _), tiene(Persona, Animal, _)).

manejaElMercado(Persona):-
    tiene(Persona, _, _),
    forall((tiene(OtraPersona, _, _), Persona \= OtraPersona),
           tieneParaOfrecerle(Persona, OtraPersona)).

delQueMasTiene(Persona, Animal):-
    tiene(Persona, Animal, Cantidad),
    forall((tiene(Persona, OtroAnimal, Cantidad2), Animal \= OtroAnimal),
            Cantidad > Cantidad2).

:- begin_tests(palitos_de_la_selva).

test(un_animal_es_dificil_si_no_lo_tiene_nadie, nondet):-
    animalDificil(abeja).

test(un_animal_es_dificil_si_solo_una_persona_tiene_uno_de_ese_animal, nondet):-
    animalDificil(tarantula).

test(un_animal_no_es_dificil_si_dos_personas_lo_tienen, nondet):-
    not(animalDificil(lemur)).

test(a_nico_le_gustan_los_animales_terrestres_que_no_son_el_lemur):-
    leGusta(nico, leon).

test(a_nico_no_le_gusta_el_lemur):-
    not(leGusta(nico, lemur)).

test(a_maiu_no_le_gustan_los_insectos_que_no_sean_abejas):-
    not(leGusta(maiu, tarantula)).

test(a_maiu_le_gusta_cualquier_animal_que_no_sea_insecto, nondet):-
    leGusta(maiu, lemur).

test(a_maiu_le_gusta_la_abeja):-
    leGusta(maiu, abeja).

test(una_persona_puede_intercambiar_un_animal_que_tenga_pero_no_le_gusta, nondet):-
    tieneParaIntercambiar(maiu, tarantula).

test(una_persona_puede_intercambiar_un_animal_si_lo_tiene_repetido, nondet):-
    tieneParaIntercambiar(juanR, tiburon).

test(juanr_puede_intercambiar_los_que_tiene_juanDS):-
    tieneParaIntercambiar(juanR, lagartija).

test(una_persona_tiene_para_ofrecerle_un_animal_a_otra_si_lo_tiene_para_intercambiar_y_a_la_otra_persona_le_gusta_y_la_otra_persona_no_lo_tiene, nondet):-
    tieneParaOfrecerle(maiu, nico).

test(una_persona_puede_negociar_con_otra_si_ambas_tienen_para_ofrecerse_mutuamente, nondet):-
    puedenNegociar(nico, maiu),
    puedenNegociar(maiu, nico).

test(una_persona_no_puede_negociar_consigo_misma):-
    not(puedenNegociar(maiu, maiu)).

test(una_persona_esta_triste_si_solo_tiene_animales_que_no_le_gustan):-
    estaTriste(feche).

test(una_persona_no_esta_triste_si_tiene_algun_animal_que_le_gusta):-
    not(estaTriste(maiu)).

:- end_tests(palitos_de_la_selva).