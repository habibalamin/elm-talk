module Model.Presentation
    exposing
        ( Presentation(..)
        , previousSlides
        , currentSlide
        , upcomingSlides
        , blankPresentation
        , presentation
        , advanceSlide
        , retractSlide
        )

import Model.Slide exposing (..)


type Presentation
    = Presentation
        { previousSlides : List Slide
        , currentSlide : Slide
        , upcomingSlides : List Slide
        }


previousSlides : Presentation -> List Slide
previousSlides (Presentation { previousSlides }) =
    previousSlides


currentSlide : Presentation -> Slide
currentSlide (Presentation { currentSlide }) =
    currentSlide


upcomingSlides : Presentation -> List Slide
upcomingSlides (Presentation { upcomingSlides }) =
    upcomingSlides


blankPresentation : Presentation
blankPresentation =
    Presentation
        { previousSlides = []
        , currentSlide = blankSlide
        , upcomingSlides = []
        }


presentation : List Slide -> Presentation
presentation slides =
    Presentation
        { previousSlides = []
        , currentSlide = Maybe.withDefault blankSlide <| List.head slides
        , upcomingSlides = List.drop 1 slides
        }


advanceSlide : Presentation -> Presentation
advanceSlide (Presentation { previousSlides, currentSlide, upcomingSlides }) =
    case List.head upcomingSlides of
        Nothing ->
            Presentation
                { previousSlides = previousSlides
                , currentSlide = currentSlide
                , upcomingSlides = upcomingSlides
                }

        Just slide ->
            if slideItemsRemaining presentation then
                Presentation
                    { previousSlides = previousSlides ++ [ currentSlide ]
                    , currentSlide = slide
                    , upcomingSlides = List.drop 1 upcomingSlides
                    }
            else
                Presentation
                    { previousSlides = previousSlides ++ [ currentSlide ]
                    , currentSlide = slide
                    , upcomingSlides = List.drop 1 upcomingSlides
                    }


slideItemsRemaining : Presentation -> Bool
slideItemsRemaining = currentSlide >> upcomingItems >> List.isEmpty


retractSlide : Presentation -> Presentation
retractSlide presentation =
    presentation
