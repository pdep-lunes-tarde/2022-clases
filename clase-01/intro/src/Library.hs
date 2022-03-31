module Library where
import PdePreludat

-- REPL / Intérprete
-- Read. Evaluate. Print. Loop

-- f : |R -> |R
-- f(x) = x + x
-- g(x) = x * 3
doble :: Number -> Number
doble numero = numero + numero

triple :: Number -> Number
triple numero = numero * 3

perimetroCirculo :: Number -> Number
perimetroCirculo radio = 2 * pi * radio

perimetroCuadrado :: Number -> Number
perimetroCuadrado lado = lado * 4

superficieCuadrado :: Number -> Number
superficieCuadrado lado = lado * lado

superficieCubo :: Number -> Number
superficieCubo lado = superficieCuadrado lado * 6

superficieCilindro :: Number -> Number -> Number
superficieCilindro radio altura =
    superficieTuboDelCilindro radio altura +
    superficieTapasDelCilindro radio

superficieTuboDelCilindro :: Number -> Number -> Number
superficieTuboDelCilindro radio altura =
    perimetroCirculo radio * altura

superficieTapasDelCilindro :: Number -> Number
superficieTapasDelCilindro radio =
    2 * superficieCirculo radio

superficieCirculo :: Number -> Number
superficieCirculo radio = pi * radio ^^ 2
