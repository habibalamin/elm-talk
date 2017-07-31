module View.Presentation exposing (view)

import Html exposing (..)
import Model.Presentation exposing (..)
import Model.Slide exposing (..)
import Model.SlideItem exposing (..)
import Action exposing (..)


view : Presentation -> Html Action
view =
    currentSlide >> slideView


slideView : Slide -> Html Action
slideView slide =
    body
        []
        (slideHeading slide :: List.map slideItemView (previousItems slide))


slideHeading : Slide -> Html Action
slideHeading slide =
    h1 [] [ slide |> title |> text ]


slideItemView : SlideItem -> Html Action
slideItemView =
    slideItemToHtml
