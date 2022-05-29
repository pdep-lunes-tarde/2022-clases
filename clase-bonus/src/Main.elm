module Main exposing (..)

import Browser
import Html exposing (..) 
import Html.Events exposing (..)
import Html.Attributes exposing (..)
import String exposing (length, fromChar, fromInt, toList)
import List

main : Program () Model Msg
main =
  Browser.sandbox { init = init, update = update, view = view }

type Model = Preparando { palabraAAdivinar : String } |
  Jugando { palabraAAdivinar : String
  , intentoActual : String
  , intentos : List String
  }

type Msg = 
  CambiarPalabraAAdivinar String
  | Comenzar
  | CambiarIntento String
  | ChequearIntento

init : Model
init = Preparando { palabraAAdivinar = "" }

update : Msg -> Model -> Model
update mensaje model = case (mensaje, model) of
  (CambiarIntento nuevoIntento, Jugando jugando)
    -> Jugando { jugando | intentoActual = nuevoIntento }
  (ChequearIntento, Jugando jugando)
    -> Jugando { jugando | intentos = jugando.intentos ++ [jugando.intentoActual] }
  (CambiarPalabraAAdivinar nuevaPalabra, Preparando preparando)
    -> Preparando { preparando | palabraAAdivinar = nuevaPalabra }
  (Comenzar, Preparando {palabraAAdivinar})
    -> Jugando { palabraAAdivinar = palabraAAdivinar, intentoActual = "", intentos = []}
  _ -> model

view : Model -> Html Msg
view model = case model of
  Preparando preparando ->
    div [] [ 
      text "Palabra a adivinar: ", 
      input [ onInput CambiarPalabraAAdivinar, value preparando.palabraAAdivinar ] [],
      div [] [button [ onClick Comenzar ] [ text "Comenzar juego" ]]
      ]
  Jugando jugando ->
    div [] [
      div [] [ text "Intento: "],
      input [ onInput CambiarIntento, value jugando.intentoActual ] [],
      button [ onClick ChequearIntento ] [ text "Probar" ],
      div [] (List.map (resultadoDeAdivinar jugando.palabraAAdivinar) jugando.intentos)
      ]

type alias ResultadoParaLetra = { letra: Char, resultado: ClaseDeResultado }

type ClaseDeResultado = Correcto | Incorrecto | PosicionIncorrecta

resultadoDeAdivinar : String -> String -> Html Msg
resultadoDeAdivinar palabraAAdivinar intento = 
  div [ class "contenedorCuadraditos" ] <| List.map viewResultadoParaLetra <| List.map2 (resultadoParaLetra palabraAAdivinar)
                                                                              (toList palabraAAdivinar)
                                                                              (toList intento)

viewResultadoParaLetra : ResultadoParaLetra -> Html Msg
viewResultadoParaLetra resultado = 
  div [ class "cuadradito", htmlAttributeParaResultado resultado.resultado ] [ text (fromChar resultado.letra) ]

htmlAttributeParaResultado : ClaseDeResultado -> Attribute Msg
htmlAttributeParaResultado resultado = case resultado of
  Correcto -> class "correcto"
  Incorrecto -> class "incorrecto"
  PosicionIncorrecta -> class "posicionIncorrecta"

resultadoParaLetra : String -> Char -> Char -> ResultadoParaLetra
resultadoParaLetra palabraAAdivinar letraAAdivinar letraIntento = 
  { letra = letraIntento,
    resultado =
      if letraAAdivinar == letraIntento
        then Correcto
      else if List.member letraIntento (toList palabraAAdivinar)
        then PosicionIncorrecta
      else Incorrecto
  }