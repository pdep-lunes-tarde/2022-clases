module Main exposing (..)

import Browser
import Html exposing (..)
import Html.Events exposing (..)
import Html.Attributes exposing (..)
import String exposing (fromChar, fromInt, toList)
import List exposing (..)
import Char exposing (isAlpha)
import Random

main : Program () Model Msg
main =
  Browser.element { init = (\_ -> init), update = update, view = view, subscriptions = subscriptions }

subscriptions : Model -> Sub Msg
subscriptions _ = Sub.none

intentosMaximos : Int
intentosMaximos = 6

type Model = Preparando {
    palabraAAdivinar : String
  } | Jugando {
    palabraAAdivinar : String
    , intentoEscribiendo : String
    , intentos : List String
  } | Victoria
  | Derrota

type Msg = CambiarIntento String | 
  ChequearPalabra | 
  CambiarPalabraAAdivinar String | 
  Jugar String |
  Reiniciar | 
  PalabraAlAzar

init : (Model, Cmd Msg)
init = 
  (Preparando {
    palabraAAdivinar = ""
  }, Cmd.none)

update : Msg -> Model -> (Model, Cmd Msg)
update mensaje modelo = 
  if mensaje == PalabraAlAzar then (modelo, Random.generate Jugar (Random.uniform "carta" baseDeDatosPalabras))
  else (
  (case (mensaje, modelo) of 
  (CambiarIntento intentoNuevo, Jugando jugando) 
    -> Jugando { jugando | intentoEscribiendo = dejarSoloLetras intentoNuevo }
  (ChequearPalabra, Jugando jugando) 
    -> verSiTerminoElJuego (Jugando { jugando | intentos = jugando.intentos ++ [jugando.intentoEscribiendo] })
  (CambiarPalabraAAdivinar palabraNueva, Preparando preparando) 
    -> Preparando { preparando | palabraAAdivinar = dejarSoloLetras palabraNueva }
  (Jugar palabraAAdivinar, Preparando _) 
    -> Jugando { palabraAAdivinar = palabraAAdivinar, intentoEscribiendo = "", intentos = [] }
  (Reiniciar, Victoria)
    -> Preparando {
    palabraAAdivinar = ""
    }
  _ -> modelo)
  , Cmd.none)

view : Model -> Html Msg
view modelo = case modelo of
  Preparando preparando
    -> div [ class "juego-input-container" ] [
      button [ onClick PalabraAlAzar ] [ text "Elegí por mí" ]
      , input [ value preparando.palabraAAdivinar, onInput CambiarPalabraAAdivinar ] []
      , button [ onClick (Jugar preparando.palabraAAdivinar) ] [ text "Empezar juego" ]
    ]
  Jugando jugando
    -> div [ class "jugando-container" ] [
        input [ value jugando.intentoEscribiendo, onInput CambiarIntento ] [],
        button [ onClick ChequearPalabra ] [ text "Intentar" ],
        div [] 
          (List.map (mostrarResultado jugando.palabraAAdivinar) jugando.intentos), 
        span [] [ text ("Te quedan " ++ fromInt (intentosRestantes modelo) ++ " intentos")]
      ]
  Victoria
    -> viewJuegoTerminado "Ganaste"
  Derrota
    -> viewJuegoTerminado "Perdiste"

intentosRestantes : Model -> Int
intentosRestantes modelo = case modelo of
    Jugando jugando -> intentosMaximos - List.length jugando.intentos
    _ -> intentosMaximos

viewJuegoTerminado : String -> Html Msg
viewJuegoTerminado mensaje = 
  div [] [
      span [] [ text mensaje ]
      , button [ onClick Reiniciar ] [ text "Reiniciar" ]
    ]

mostrarResultado : String -> String -> Html Msg
mostrarResultado palabraAAdivinar intentoActual = div [ class "contenedorCuadraditos" ]
  (List.map2 (mostrarResultadoLetra palabraAAdivinar) (toList palabraAAdivinar) (toList intentoActual))

mostrarResultadoLetra : String -> Char -> Char -> Html Msg
mostrarResultadoLetra palabraAAdivinar charAAdivinar charIntento = 
  div 
  [ class "cuadradito", colorDeCuadradito palabraAAdivinar charAAdivinar charIntento ] 
  [ text (fromChar charIntento) ]

colorDeCuadradito : String -> Char -> Char -> Attribute Msg
colorDeCuadradito palabraAAdivinar charAAdivinar charIntento = 
  style "background-color" 
    (if charAAdivinar == charIntento
    then "green"
    else if member charIntento (toList palabraAAdivinar)
    then "yellow"
    else "grey")

juegoGanado : Model -> Bool
juegoGanado modelo = case modelo of
    Jugando jugando -> member jugando.palabraAAdivinar jugando.intentos
    _ -> False

juegoPerdido : Model -> Bool
juegoPerdido modelo = intentosRestantes modelo == 0

verSiTerminoElJuego : Model -> Model
verSiTerminoElJuego modelo =
  if juegoGanado modelo
  then Victoria
  else if juegoPerdido modelo
  then Derrota
  else modelo

dejarSoloLetras : String -> String
dejarSoloLetras palabra = String.filter isAlpha palabra

baseDeDatosPalabras : List String
baseDeDatosPalabras = 
  ["aboya"
  ,"aboya"
  ,"abran"
  ,"abras"
  ,"abras"
  ,"abria"
  ,"acles"
  ,"acoja"]