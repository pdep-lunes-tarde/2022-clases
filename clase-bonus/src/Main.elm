module Main exposing (..)

import Browser
import Html exposing (..)
import Html.Events exposing (..)
import Html.Attributes exposing (..)
import String exposing (length, fromChar, fromInt)
import List exposing (map)
import VerificarPalabra exposing (..)

main : Program () Model Msg
main =
  Browser.sandbox { init = init, update = update, view = view }

type alias Model = String

type alias Msg = ()

init : Model
init = "Hola Mundo"

update : Msg -> Model -> Model
update mensaje modelo = modelo

view : Model -> Html Msg
view modelo = text modelo
