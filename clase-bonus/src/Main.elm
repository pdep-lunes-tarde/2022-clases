module Main exposing (..)

import Browser
import Html exposing (Html, button, div, text, span, input)
import Html.Events exposing (onClick, onInput)
import Html.Attributes exposing (style, class)
import String exposing (length, fromChar, fromInt)
import List exposing (map)
import VerificarPalabra exposing (..)

-- MAIN


main : Program () Model Msg
main =
  Browser.sandbox { init = init, update = update, view = view }



-- MODEL

-- tipo Model también incluye pantallas para victoria y derrota
type Model =
  Preparando { palabra : String } | 
  Jugando 
    { palabra : String
    , intento : String
    , resultado : Resultado
    , cantIntentos : Int
    }
  | Victoria | Derrota



init : Model
init = Preparando { palabra = "" }



-- UPDATE


type Msg
  = CambiarPalabra String
  | SetearPalabra
  | CambiarIntento String
  | ChequearPalabra
  | VolverAlInicio

-- líneas 72, 83, 90, 97: para completar casos de pattern matching. ¿Es necesario?

update : Msg -> Model -> Model
update msg model =
  case (msg, model) of
    (CambiarPalabra str, Preparando _) ->
      if length str > 5 then model else 
        Preparando { palabra = str }
    (SetearPalabra, Preparando { palabra }) ->
      Jugando 
        { palabra = palabra
        , intento = ""
        , resultado = []
        , cantIntentos = 5
        }
    (CambiarIntento str, Jugando unModel) ->
      Jugando { unModel | intento = str }
    (ChequearPalabra, Jugando unModel) ->
      if unModel.cantIntentos > 0 then
        (cambiarAFinal << restarIntento << cambiarResultado) model
      else model
    (VolverAlInicio, _) -> init
    _ -> model

-- ¿qué mejor nombre puede tener esta función?
cambiarAFinal : Model -> Model
cambiarAFinal model = case model of
  Jugando unModel ->
    if unModel.cantIntentos == 0 then 
      Derrota
    else if gano unModel.resultado then 
      Victoria
    else model
  _ -> model

cambiarResultado : Model -> Model
cambiarResultado model = case model of
  Jugando unModel -> Jugando { unModel | 
    resultado = chequear unModel.palabra unModel.intento
    }
  _ -> model

restarIntento : Model -> Model
restarIntento model = case model of
  Jugando unModel -> Jugando { unModel |
    cantIntentos = unModel.cantIntentos - 1 
    }
  _ -> model

view : Model -> Html Msg
view model = case model of 
  Preparando _ ->
    div 
    [ class "padre" ] 
    [ input [ onInput CambiarPalabra ] []
    , button [ onClick SetearPalabra ] [ text "Ingresar" ]
    ]
  Jugando unModel ->
    div 
    [ class "padre" ] 
    [ input [ onInput CambiarIntento ] []
    , button [ onClick ChequearPalabra ] [ text "Chequear" ]
    , span [] [ text ("intentos restantes: " ++ fromInt unModel.cantIntentos) ]
    , div [ class "contenedorCuadraditos" ] (map vistaResultado unModel.resultado) 
    ]
  Victoria ->
    div
    [ class "padre" ]
    [ span [] [ text "Ganaste" ]
    , button [ onClick VolverAlInicio ] [ text "Volver" ]
    ]
  Derrota ->
    div
    [ class "padre" ]
    [ span [] [ text "Perdiste" ]
    , button [ onClick VolverAlInicio ] [ text "Volver" ]
    ]

vistaResultado : Verificacion -> Html Msg
vistaResultado unaVerificacion = div 
  [ class "cuadradito" 
  , style "background-color" (obtenerColor unaVerificacion) ] 
  [ text (fromChar unaVerificacion.letra) ]

obtenerColor : Verificacion -> String
obtenerColor unaVerificacion = 
  case unaVerificacion.posicion of
    LugarCorrecto -> "green"
    LugarIncorrecto -> "yellow"
    NoEsta -> "grey"