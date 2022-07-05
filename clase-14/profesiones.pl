% Migue es maestro cocinero y su herramienta es una olla essen.
% Carla es maestra alquimista y su herramienta es un mechero.
% Feche es aprendiz de mecánico y su herramienta es una llave inglesa.
% Aye es oficial alquimista y su herramienta es una piedra filosofal.

% trabajador(Nombre, Profesion, Herramienta).
trabajador(migue, profesion(cocinero, maestro), ollaEssen).
trabajador(carla, profesion(alquimista, maestro), mechero).
trabajador(feche, profesion(mecanico, aprendiz), llaveInglesa).
trabajador(aye, profesion(alquimista, oficial), piedraFilosofal).

% nacio(juan, fecha(9, 7, 1994)).

camaradas(UnTrabajador, OtroTrabajador):-
    trabajador(UnTrabajador, UnaProfesion, _),
    trabajador(OtroTrabajador, OtraProfesion, _),
    mismoArea(UnaProfesion, OtraProfesion),
    UnTrabajador \= OtroTrabajador.

% escribimos directamente cual es mayor que cual
nivelInmediatamenteMayor(maestro, experto).
nivelInmediatamenteMayor(experto, oficial).
nivelInmediatamenteMayor(oficial, aprendiz).

nivelMayor(NivelMayor, NivelMenor):-
    nivelInmediatamenteMayor(NivelMayor, NivelMenor).

nivelMayor(NivelMayor, NivelMenor):-
    nivelInmediatamenteMayor(NivelMayor, NivelIntermedio),
    nivelMayor(NivelIntermedio, NivelMenor).

% convertimos a otro valor que ya tiene el concepto de mayor
% implementado (los numeros)
% nivelMayor(Nivel, OtroNivel):-
%     nivelANumero(Nivel, Numero),
%     nivelANumero(OtroNivel, OtroNumero),
%     Numero > OtroNumero.

% nivelANumero(maestro, 3).
% nivelANumero(experto, 2.5).
% nivelANumero(oficial, 2).
% nivelANumero(aprendiz, 1).


puedeEntrenarA(Entrenador, Alumno):-
    camaradas(Entrenador, Alumno),
    tieneMasExperiencia(Entrenador, Alumno).

tieneMasExperiencia(Entrenador,Alumno):-
    trabajador(Entrenador, profesion(_,Nivel),_),
    trabajador(Alumno, profesion(_,OtroNivel),_),
    nivelMayor(Nivel, OtroNivel).

mismoArea(profesion(Area, _), profesion(Area, _)):-
    trabajador(_, profesion(Area, _), _).

% Tareas, ¿Quién puede hacer cada una?

% cocinar milanesas con puré: puede hacerlo cualquier
% cocinero.

% Además, Migue se da maña arreglando cualquier cosa así que siempre puede reparar lo que sea.

cocinero(Trabajador):-
    trabajador(Trabajador, profesion(cocinero, _), _).

puedeCocinarMilanesas(Trabajador):-
    cocinero(Trabajador).

% recalentar comida: puede hacerlo cualquier cocinero
% o cualquiera que tenga un mechero.

recalentarComida(Trabajador):-
    cocinero(Trabajador).
recalentarComida(Trabajador):-
    trabajador(Trabajador, _, mechero).

% producir cierta cantidad de medicina: alquimistas aprendices y oficiales pueden hacer solo hasta 100 gramos, alquimistas de grado más alto pueden hacer cualquier cantidad.

nivelEsComoMucho(Nivel, NivelEsperado):-
    not(nivelMayor(Nivel, NivelEsperado)).

natural(0).
natural(Numero):-
    natural(Anterior),
    Numero is Anterior + 1.


% producirMedicina(Trabajador, Cantidad):-
%     between(1, 100, Cantidad),
%     trabajador(Trabajador, profesion(alquimista, Nivel), _),
%     nivelEsComoMucho(Nivel, oficial),
%     Cantidad =< 100.

% producirMedicina(Trabajador, Cantidad):-
%     trabajador(Trabajador, profesion(alquimista, Nivel), _),
%     nivelMayor(Nivel, oficial),
%     natural(Cantidad).

% reparar un aparato: para cada aparato sabemos con qué herramienta se puede arreglar. Y solo puede ser arreglado por alguien que trabaje en mecánica y tenga esa herramienta.

puedeHacer(Trabajador, repararAparato(Herramienta)):-
    trabajador(Trabajador, profesion(mecanico, _), Herramienta).

% repararUnAparato(Trabajador, Herramienta):-
%     trabajador(Trabajador, profesion(mecanico, _), Herramienta).

puedeHacer(Trabajador, crearObraMaestra(Area)):-
    trabajador(Trabajador, profesion(Area, maestro), _).
puedeHacer(Trabajador, crearObraMaestra(alquimista)):-
    trabajador(Trabajador, profesion(alquimista, _), piedraFilosofal).

% crearUnaObraMaestra(Trabajador):-
%     trabajador(Trabajador, profesion(_, maestro), _).

% crearUnaObraMaestra(Trabajador):-
%     trabajador(Trabajador, profesion(alquimista, _), piedraFilosofal).

puedeCubrir(UnTrabajador, OtroTrabajador, Tarea):-
    puedeHacer(UnTrabajador, Tarea),
    puedeHacer(OtroTrabajador, Tarea),
    UnTrabajador \= OtroTrabajador.

esIrremplazable(Trabajador, Tarea):-
    puedeHacer(Trabajador, Tarea),
    not(puedeCubrir(_, Trabajador, Tarea)).

puedeHacer(Trabajador, cocinarMilanesas):-
    cocinero(Trabajador).

puedeHacer(Trabajador, recalentarComida):-
    cocinero(Trabajador).
puedeHacer(Trabajador, recalentarComida):-
    trabajador(Trabajador, _, mechero).

puedeHacer(Trabajador, producirMedicina(Cantidad)):-
    between(1, 100, Cantidad),
    trabajador(Trabajador, profesion(alquimista, Nivel), _),
    nivelEsComoMucho(Nivel, oficial),
    Cantidad =< 100.

puedeHacer(Trabajador, producirMedicina(Cantidad)):-
    trabajador(Trabajador, profesion(alquimista, Nivel), _),
    nivelMayor(Nivel, oficial),
    natural(Cantidad).

% recalentarComida(Trabajador):-
%     cocinero(Trabajador).
% recalentarComida(Trabajador):-
%     trabajador(Trabajador, _, mechero).
