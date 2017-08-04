module View.Presentation exposing (view)

import Html exposing (..)
import Model.Presentation exposing (..)
import Model.Slide exposing (..)
import Model.SlideItem exposing (..)
import Action exposing (..)


view : Presentation -> Html Action
view =
    .currentSlide >> slideView


slideView : Slide -> Html Action
slideView slide =
    body
        []
        (slideHeading slide :: slideBody slide)


slideHeading : Slide -> Html Action
slideHeading slide =
    h1 [] [ text slide.title ]


slideBody : Slide -> List (Html Action)
slideBody slide =
    List.map slideItemView <| slideItemsInView slide


slideItemsInView : Slide -> List SlideItem
slideItemsInView slide =
    case slide.currentItem of
        Nothing ->
            slide.previousItems

        Just item ->
            slide.previousItems ++ [ item ]


slideItemView : SlideItem -> Html Action
slideItemView =
    slideItemToHtml
