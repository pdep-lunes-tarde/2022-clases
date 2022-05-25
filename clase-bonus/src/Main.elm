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
    palabra = "hola"
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
        { palabra = str
        , intento = ""
        , resultado = model.resultado
        , cantIntentos = model.cantIntentos }
    ChequearPalabra -> case model.cantIntentos > 0 of
      True ->    
        { palabra = model.palabra
        , intento = model.intento
        , resultado = chequear model.palabra model.intento
        , cantIntentos = model.cantIntentos - 1 }
      False ->    
        { palabra = model.palabra
        , intento = model.intento
        , resultado = model.resultado
        , cantIntentos = 0 }
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
    input [ onInput CambiarPalabra ] []
    , input [ onInput CambiarIntento ] []
    , button [ onClick ChequearPalabra ] [ text "chequear" ]
    , span [] [ text ("intentos restantes: " ++ fromInt model.cantIntentos) ]
    , div [ class "contenedorCuadraditos" ] (map vistaResultado model.resultado) 
  ]

vistaResultado : Verificacion -> Html Msg
vistaResultado unaVerificacion = div 
  [ class "cuadradito" 
  , style "background-color" (obtenerColor unaVerificacion) ] 
  [ text (fromChar unaVerificacion.letra) ]

obtenerColor : Verificacion -> String
obtenerColor unaVerificacion = 
  case unaVerificacion.color of
      Verde -> "green"
      Amarillo -> "yellow"
      Gris -> "grey"