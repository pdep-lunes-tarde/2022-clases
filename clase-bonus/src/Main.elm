module Main exposing (..)

import Browser
import Html exposing (..)
import Html.Events exposing (..)
import Html.Attributes exposing (..)
import String exposing (length, fromChar, fromInt)
import List exposing (..)

main : Program () Model Msg
main =
  Browser.sandbox { init = init, update = update, view = view }

type alias Model = ()

type alias Msg = ()

init : Model
init = ()

update : Msg -> Model -> Model
update mensaje modelo = modelo

view : Model -> Html Msg
view modelo = text "Hola Mundo"
