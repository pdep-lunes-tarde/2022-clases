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


type alias Model = {
  palabra : String
  , intento : String
  , resultado : Resultado
  , cantIntentos : Int
  }


init : Model
init = {
    palabra = ""
    , intento = ""
    , resultado = []
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
      if length str > 5 then model else 
        { model | palabra = str }
    ChequearPalabra -> case model.cantIntentos > 0 of
    -- hacer composición
      True ->    
        { palabra = model.palabra
        , intento = model.intento
        , resultado = chequear model.palabra model.intento
        , cantIntentos = model.cantIntentos - 1 }
      False ->    
        model
    CambiarIntento str ->
      { palabra = model.palabra
      , intento = str
      , resultado = []
      , cantIntentos = model.cantIntentos }
     


-- VIEW

view : Model -> Html Msg
view model =
  div 
  [ class "padre" ] [
    --if () then input [ onInput CambiarPalabra ] [] else nada
    --, button [ onInput ElegirPalabra ] [] para elegir la palabra y después esconder el primer text input
    input [ onInput CambiarIntento ] []
    , button [ onClick ChequearPalabra ] [ text "chequear" ]
    , span [] [ text ("intentos restantes: " ++ fromInt model.cantIntentos) ]
    , div [ class "contenedorCuadraditos" ] (map vistaResultado model.resultado) 
  ]

nada : Html msg
nada = text ""

vistaResultado : Verificacion -> Html Msg
vistaResultado unaVerificacion = div 
  [ class "cuadradito" 
  , style "background-color" (obtenerColor unaVerificacion) ] 
  [ text (fromChar unaVerificacion.letra) ]

obtenerColor : Verificacion -> String
obtenerColor unaVerificacion = 
  case unaVerificacion.color of
      LugarCorrecto -> "green"
      LugarIncorrecto -> "yellow"
      NoEsta -> "grey"