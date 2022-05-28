module VerificarPalabra exposing (..)

import String exposing (toList)
import List exposing (member, map, indexedMap, head, drop, all)
import Tuple exposing (pair)

type alias Resultado = List Verificacion

type alias Verificacion = 
    { letra : Char
    , color : Color
    }

type Color = NoEsta | LugarIncorrecto | LugarCorrecto

gano : Resultado -> Bool
gano resultado = all ((\unColor -> unColor == LugarCorrecto) << .color) resultado

chequear : String -> String -> Resultado
chequear palabra intento =
  (map (verSiEstaEn palabra) << indexedMap pair << toList) intento

verSiEstaEn : String -> (Int, Char) -> Verificacion
verSiEstaEn palabra tupla = (determinarCaracter tupla << toList) palabra

determinarColor : (Int, Char) -> List Char -> Color
determinarColor (indice, caracter) lista =
  case (getAt indice lista) == Just caracter of
    True -> LugarCorrecto
    False -> case member caracter lista of
      True -> LugarIncorrecto
      False -> NoEsta

determinarCaracter : (Int, Char) -> List Char -> Verificacion
determinarCaracter (indice, caracter) lista = {letra = caracter, color = determinarColor (indice, caracter) lista}

getAt : Int -> List a -> Maybe a
getAt indice = head << drop indice