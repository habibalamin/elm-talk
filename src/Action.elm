module Action exposing (..)

import Keyboard exposing (..)


type alias Url =
    String


type Action
    = HitKey KeyCode
    | LoadPresentation Url
