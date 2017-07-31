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
        LoadSlide ul ->
            ( presentation, Cmd.none )

        AdvanceSlide ->
            ( advanceSlide presentation, Cmd.none )

        RetractSlide ->
            ( retractSlide presentation, Cmd.none )


examplePresentation : Presentation
examplePresentation =
    Presentation
        { previousSlides = []
        , currentSlide = firstExampleSlide
        , upcomingSlides = exampleSlides
        }


firstExampleSlide = slide
    "Title"
    [ subtitle "Subtitle #1"
    , paragraph "A paragraph."
    , bulletList
        [ "Bullet #1.1"
        , "Bullet #1.2"
        , "Bullet #1.3"
        ]
    , subtitle "Subtitle #2"
    , paragraph "Another paragraph."
    , bulletList
        [ "Bullet #1.1"
        , "Bullet #1.2"
        , "Bullet #1.3"
        ]
    ]


exampleSlides =
    [ slide
          "Elm Talk"
          [ paragraph "This is an Elm talk given using elm-talk. In this talk, we shall:"
          , bulletList
                [ "Demonstrate the capabilities of the app."
                , "Look at the code which powers the app."
                ]
          ]
    ]
