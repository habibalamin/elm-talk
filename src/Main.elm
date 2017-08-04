module Main exposing (main)

import Html exposing (Html)
import Model.Presentation exposing (..)
import Model.Slide exposing (..)
import Model.SlideItem exposing (..)
import Action exposing (..)
import View.Presentation exposing (..)
import Subscription exposing (..)


main : Program Never Presentation Action
main =
    Html.program
        { init = init
        , view = view
        , update = update
        , subscriptions = subscriptions
        }


init : ( Presentation, Cmd Action )
init =
    ( examplePresentation, Cmd.none )


update : Action -> Presentation -> ( Presentation, Cmd Action )
update msg presentation =
    case msg of
        LoadPresentation ul ->
            ( presentation, Cmd.none )

        HitKey keycode ->
            if keycode == 32 then
                ( advancePresentation presentation, Cmd.none )
            else
                ( retractPresentation presentation, Cmd.none )


examplePresentation : Presentation
examplePresentation =
    presentation
        [ slide
            "Elm Talk"
            [ paragraph "This is an Elm talk given using elm-talk. In this talk, we shall:"
            , bulletList
                "Demonstrate the capabilities of the app."
                [ "Look at the code which powers the app."
                , "Talk about Elm and functional programming in the ML family in general"
                ]
            ]
        , slide
            "Let's Demo It!"
            [ subtitle "The first of two subtitles"
            , paragraph "This is a paragraph."
            , bulletList
                "Here's a bullet #1.1"
                [ "Here's another bullet #1.2"
                , "Final bullet on this slide #1.3"
                ]
            , subtitle "The second of two subtitles"
            , paragraph "This is another paragraph."
            , bulletList
                "The first of the second set of bullets #2.1"
                [ "The second of the second set of bullets #2.2"
                , "The second of the second set of bullets #2.3"
                ]
            ]
        , slide
            "Code Time"
            []
        ]
