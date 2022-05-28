module VerificarPalabra exposing (..)

import String exposing (toList)
import List exposing (member, map, indexedMap, head, drop, all)
import Tuple exposing (pair)

type alias Resultado = List Verificacion

type alias Verificacion = 
    { letra : Char
    , posicion : Posicion
    }

-- al menos es mejor que color... no estoy muy seguro igual
type Posicion = NoEsta | LugarIncorrecto | LugarCorrecto

gano : Resultado -> Bool
gano resultado = all ((\unColor -> unColor == LugarCorrecto) << .posicion) resultado
-- ¿se puede evitar esta lambda?

chequear : String -> String -> Resultado
chequear palabra intento =
  (map (verSiEstaEn palabra) << indexedMap pair << toList) intento

verSiEstaEn : String -> (Int, Char) -> Verificacion
verSiEstaEn palabra tupla = (determinarCaracter tupla << toList) palabra

determinarPosicion : (Int, Char) -> List Char -> Posicion
determinarPosicion (indice, caracter) lista =
  if (getAt indice lista) == Just caracter 
  then
    LugarCorrecto
  else if member caracter lista then
    LugarIncorrecto
  else NoEsta

determinarCaracter : (Int, Char) -> List Char -> Verificacion
determinarCaracter (indice, caracter) lista = {letra = caracter, posicion = determinarPosicion (indice, caracter) lista}

getAt : Int -> List a -> Maybe a
getAt indice = head << drop indice