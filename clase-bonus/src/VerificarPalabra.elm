module VerificarPalabra exposing (..)

import String exposing (toList, concat)
import List exposing (member, map, indexedMap, head, drop)
import Tuple exposing (pair)

type alias Resultado = List Verificacion

type alias Verificacion = 
    { letra : Char
    , color : Color
    }

type Color = Gris | Amarillo | Verde

chequear : String -> String -> Resultado
chequear palabra intento =
  (map (verSiEstaEn palabra) << indexedMap pair << toList) intento

verSiEstaEn : String -> (Int, Char) -> Verificacion
verSiEstaEn palabra tupla = (determinarCaracter tupla << toList) palabra

determinarCaracter : (Int, Char) -> List Char -> Verificacion
determinarCaracter (indice, caracter) lista =
  case (getAt indice lista) == Just caracter of
    True -> {letra = caracter, color = Verde}
    False -> case member caracter lista of
      True -> {letra = caracter, color = Amarillo}
      False -> {letra = caracter, color = Gris}

getAt : Int -> List a -> Maybe a
getAt indice = head << drop indice