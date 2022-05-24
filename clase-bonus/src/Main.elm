module Main exposing (..)


import Browser
import Html exposing (Html, button, div, text, span, input)
import Html.Events exposing (onClick, onInput)
import String exposing (length, toList, concat)
import List exposing (member, map, indexedMap, head, drop)
import Tuple exposing (pair)

-- MAIN


main : Program () Model Msg
main =
  Browser.sandbox { init = init, update = update, view = view }



-- MODEL


type alias Model = {
  palabra : String
  , intento : String
  , resultado : String
  , cantIntentos : Int
  }


init : Model
init = {
    palabra = "hola"
    , intento = ""
    , resultado = ""
    , cantIntentos = 5
  }



-- UPDATE


type Msg
  = CambiarPalabra String
  | ChequearPalabra
  | CambiarIntento String


update : Msg -> Model -> Model
update msg model =
  case msg of
    CambiarPalabra str ->
      if length str > 5 then model else {
        palabra = str,
        intento = "",
        resultado = "",
        cantIntentos = model.cantIntentos}
    ChequearPalabra -> case (model.cantIntentos - 1) > 0 of
      True ->    
        { palabra = model.palabra,
        intento = model.intento,
        resultado = chequear model.palabra model.intento,
        cantIntentos = model.cantIntentos - 1 }
      False ->    
        { palabra = model.palabra,
        intento = model.intento,
        resultado = "perdiste",
        cantIntentos = 0 }
    CambiarIntento str ->
      { palabra = model.palabra,
        intento = str,
        resultado = "",
        cantIntentos = model.cantIntentos}
     
chequear : String -> String -> String
chequear palabra intento =
  if palabra == intento then "ganaste" else
  (concat << map (verSiEstaEn palabra) << indexedMap pair << toList) intento

verSiEstaEn : String -> (Int, Char) -> String
verSiEstaEn palabra tupla = (determinarCaracter tupla << toList) palabra

determinarCaracter : (Int, Char) -> List Char -> String
determinarCaracter (indice, caracter) lista =
  case (getAt indice lista) == Just caracter of
    True -> "Verde "
    False -> case member caracter lista of
      True -> "Amarillo "
      False -> "Gris "

getAtOr : Int ->  a -> List a  -> a
getAtOr indice default lista = case getAt indice lista of
  Just x -> x
  Nothing -> default

getAt : Int -> List a -> Maybe a
getAt indice = head << drop indice

-- VIEW


view : Model -> Html Msg
view model =
  div [] [
    input [ onInput CambiarPalabra ] []
    , input [ onInput CambiarIntento ] []
    , button [ onClick ChequearPalabra ] [ text "chequear" ]
    , span [] [ text model.resultado ] -- aca deberia hacer cuadraditos
  ]
