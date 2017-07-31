module Action exposing (..)


type alias Url =
    String


type Action
    = LoadSlide Url
    | AdvanceSlide
    | RetractSlide
