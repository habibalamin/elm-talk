module Model.Presentation
    exposing
        ( Presentation
        , blankPresentation
        , presentation
        , advancePresentation
        , retractPresentation
        )

import Model.Slide exposing (..)
import Model.SlideItem exposing (..)


type alias Presentation =
    { previousSlides : List Slide
    , currentSlide : Slide
    , upcomingSlides : List Slide
    }


blankPresentation : Presentation
blankPresentation =
    { previousSlides = []
    , currentSlide = blankSlide
    , upcomingSlides = []
    }


presentation : List Slide -> Presentation
presentation slides =
    { previousSlides = []
    , currentSlide = Maybe.withDefault blankSlide <| List.head slides
    , upcomingSlides = List.drop 1 slides
    }


advancePresentation : Presentation -> Presentation
advancePresentation presentation =
    if not (slideComplete presentation) then
        { presentation | currentSlide = advanceSlide presentation.currentSlide }
    else
        case List.head presentation.upcomingSlides of
            Nothing ->
                presentation

            Just slide ->
                { previousSlides = presentation.previousSlides ++ [ presentation.currentSlide ]
                , currentSlide = slide
                , upcomingSlides = List.drop 1 presentation.upcomingSlides
                }


slideComplete : Presentation -> Bool
slideComplete presentation =
    List.isEmpty presentation.currentSlide.upcomingItems
    && Maybe.withDefault True (Maybe.map slideItemComplete presentation.currentSlide.currentItem)


retractPresentation : Presentation -> Presentation
retractPresentation presentation =
    presentation
