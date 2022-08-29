jugador(amarillo).
jugador(magenta).
jugador(azul).
jugador(verde).
jugador(negro).
jugador(rojo).

continente(americaDelSur).
continente(americaDelNorte).
continente(asia).
continente(oceania).
continente(europa).
continente(africa).

estaEn(americaDelSur, argentina).
estaEn(americaDelSur, brasil).
estaEn(americaDelSur, chile).
estaEn(americaDelSur, uruguay).
estaEn(americaDelSur, peru).
estaEn(americaDelSur, colombia).

estaEn(americaDelNorte, alaska).
estaEn(americaDelNorte, yukon).
estaEn(americaDelNorte, canada).
estaEn(americaDelNorte, oregon).
estaEn(americaDelNorte, nuevaYork).
estaEn(americaDelNorte, terranova).
estaEn(americaDelNorte, labrador).
estaEn(americaDelNorte, mexico).
estaEn(americaDelNorte, groenlandia).
estaEn(americaDelNorte, california).

estaEn(europa, islandia).
estaEn(europa, granBretania).
estaEn(europa, suecia).
estaEn(europa, rusia).
estaEn(europa, polonia).
estaEn(europa, alemania).
estaEn(europa, italia).
estaEn(europa, francia).
estaEn(europa, espania).

estaEn(asia, aral).
estaEn(asia, tartaria).
estaEn(asia, taimir).
estaEn(asia, kamchatka).
estaEn(asia, china).
estaEn(asia, siberia).
estaEn(asia, japon).
estaEn(asia, mongolia).
estaEn(asia, iran).
estaEn(asia, gobi).
estaEn(asia, india).
estaEn(asia, malasia).
estaEn(asia, turquia).
estaEn(asia, israel).
estaEn(asia, arabia).

estaEn(oceania, australia).
estaEn(oceania, sumatra).
estaEn(oceania, java).
estaEn(oceania, borneo).

estaEn(africa, sahara).
estaEn(africa, egipto).
estaEn(africa, etiopia).
estaEn(africa, madagascar).
estaEn(africa, sudafrica).
estaEn(africa, zaire).

ocupa(aral, magenta).

ocupa(alaska, amarillo).
ocupa(yukon, amarillo).
ocupa(oregon, amarillo).
ocupa(canada, amarillo).
ocupa(groenlandia, amarillo).
ocupa(labrador, amarillo).
ocupa(terranova, amarillo).
ocupa(nuevaYork, amarillo).
ocupa(california, amarillo).
ocupa(mexico, amarillo).

ocupa(islandia, amarillo).
ocupa(suecia, amarillo).
ocupa(rusia, amarillo).
ocupa(polonia, amarillo).

ocupa(turquia, amarillo).

ocupa(sahara, amarillo).
ocupa(egipto, amarillo).
ocupa(etiopia, amarillo).
ocupa(zaire, amarillo).
ocupa(madagascar, amarillo).
ocupa(sudafrica, amarillo).

ocupa(argentina, azul).
ocupa(chile, azul).
ocupa(uruguay, azul).

ocupa(china, azul).
ocupa(japon, azul).
ocupa(iran, azul).
ocupa(india, azul).
ocupa(malasia, azul).
ocupa(gobi, azul).

ocupa(australia, azul).
ocupa(borneo, azul).
ocupa(java, azul).
ocupa(sumatra, azul).

ocupa(israel, negro).
ocupa(arabia, negro).

ocupa(mongolia, verde).
ocupa(taimir, verde).
ocupa(tartaria, verde).
ocupa(siberia, rojo).
ocupa(kamchatka, verde).

ocupa(italia, verde).

ocupa(brasil, verde).
ocupa(colombia, verde).
ocupa(peru, verde).

ocupa(francia, rojo).
ocupa(granBretania, rojo).
ocupa(espania, rojo).
ocupa(alemania, rojo).

% estaPeleado(Continente):-
%     continente(Continente),
%     jugadores(Jugadores),
%     forall(member(Jugador, Jugadores),
%            ocupaContinente(Jugador, Continente)).

estaPeleado(Continente):-
    continente(Continente),
    forall(jugador(Jugador),
           ocupaContinente(Jugador, Continente)).

ocupaContinente(Jugador, Continente):-
    estaEn(Continente, Pais),
    ocupa(Pais, Jugador).

% - Si un jugador ocupa cierto continente, que es verdad
% si el jugador ocupa todos los paises del mismo.

ocupaTodoElContinente(Jugador, Continente):-
    continente(Continente),
    jugador(Jugador),
    forall(estaEn(Continente, Pais),
           ocupa(Pais, Jugador)).

ejercitosQueIncorpora(Jugador, CantidadEjercitos):-
    ejercitosQueIncorporaPorPaises(Jugador, CantidadEjercitosPorPaises),
    ejercitosQueIncorporaPorContinentes(Jugador,CantidadEjercitosPorContinentes),
    CantidadEjercitos is CantidadEjercitosPorPaises + CantidadEjercitosPorContinentes.

ejercitosQueIncorporaPorContinentes(Jugador, CantidadEjercitos):-
    jugador(Jugador),
    findall(Cantidad,
            (
                ocupaTodoElContinente(Jugador, Continente),
                bonusPorContinente(Continente, Cantidad)
            ),
            Cantidades),
    sum_list(Cantidades, CantidadEjercitos).

ejercitosQueIncorporaPorPaises(Jugador, CantidadEjercitosPorPaises):-
    jugador(Jugador),
    findall(Pais, ocupa(Pais, Jugador), Paises),
    length(Paises, CantidadPaises),
    CantidadEjercitosPorPaises is max(3, CantidadPaises // 2).
%     CantidadEjercitos is CantidadPaises // 2,
%     maximoEntre(CantidadEjercitos, 3, CantidadEjercitosPorPaises).
% maximoEntre(UnNumero, OtroNumero, UnNumero):-
%     UnNumero > OtroNumero.
% maximoEntre(UnNumero, OtroNumero, OtroNumero):-
%     OtroNumero >= UnNumero.

seAtrinchero(Jugador):-
    ocupaContinente(Jugador, Continente),
    not((ocupaContinente(Jugador, OtroContinente),
         Continente \= OtroContinente)).

cantidadAtrincherados(CantidadJugadores):-
    findall(Jugador, seAtrinchero(Jugador), JugadoresAtrincherados),
    list_to_set(JugadoresAtrincherados, JugadoresAtrincheradosUnicos),
    length(JugadoresAtrincheradosUnicos, CantidadJugadores).

bonusPorContinente(asia, 7).
bonusPorContinente(europa, 5).
bonusPorContinente(americaDelNorte, 5).
bonusPorContinente(americaDelSur, 3).
bonusPorContinente(africa, 3).
bonusPorContinente(oceania, 2).

calificacion(Profesion,
             Aptitud,
             Calificacion).

% notas(Nombre, NotaEncantamiento, NotaHistoriaMagica, NotaDefensaContraArtesOscuras)
seSacoEn(harry, 6, 7, 10).

aptitud(Persona, nota(encantamiento, Nota)):-
    seSacoEn(Persona, Nota, _, _).
aptitud(Persona, nota(historia, Nota)):-
    seSacoEn(Persona, _, Nota, _).
aptitud(Persona, nota(defensaContraArtesOscuras, Nota)):-
    seSacoEn(Persona, _, _, Nota).
aptitud(sirius, esAnimago).
aptitud(peter, esAnimago).
aptitud(harry, quidditch(15, 10)).

profesion(auror, nota(defensaContraArtesOscuras, Nota), Calificacion):- Calificacion is Nota * 7.
profesion(auror, esAnimago, 40).

profesion(mortifago, nota(defensaContraArtesOscuras, Nota), Calificacion):-
    defensaContraArtesOscuras >= 10,
    Calificacion is 20 + Nota.
profesion(mortifago, nota(defensaContraArtesOscuras, Nota), Nota):-
    defensaContraArtesOscuras < 10.