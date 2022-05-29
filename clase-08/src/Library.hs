module Library where
import PdePreludat

si :: Bool -> a -> a -> a
si condicion primerValor segundoValor
    | condicion = primerValor
    | otherwise = segundoValor

unos :: [Number]
unos = 1 : unos
-- unos
-- 1 : unos
-- 1 : 1 : unos
-- 1 : 1 : 1 : unos

repetir :: a -> [a]
repetir valor = valor : repetir valor

replicar :: Number -> a -> [a]
replicar cantidadDeVeces valor =
    (take cantidadDeVeces . repetir) valor

naturales :: [Number]
naturales = 1 : map (+1) naturales

losNaturalesPares :: [Number]
losNaturalesPares = map (*2) naturales
-- losNaturalesPares = filter even naturales

losNaturalesImpares :: [Number]
losNaturalesImpares = map (subtract 1) losNaturalesPares

serieDeFibonacci :: [Number]
serieDeFibonacci =
    1 : 1 : zipWith (+) serieDeFibonacci (tail serieDeFibonacci)

-- estas expresiones no terminarian de evaluar:
-- all even losNaturalesPares
-- any even losNaturalesImpares
-- length naturales
-- sum naturales

elPrimero :: p1 -> p2 -> p1
elPrimero a b = a
