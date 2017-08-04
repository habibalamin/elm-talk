module Model.Slide
    exposing
        ( Slide
        , blankSlide
        , slide
        , advanceSlide
        )

import Model.SlideItem exposing (..)


type alias Slide =
    { title : String
    , previousItems : List SlideItem
    , currentItem : Maybe SlideItem
    , upcomingItems : List SlideItem
    }


blankSlide : Slide
blankSlide =
    { title = ""
    , previousItems = []
    , currentItem = Nothing
    , upcomingItems = []
    }


slide : String -> List SlideItem -> Slide
slide title items =
    { title = title
    , previousItems = []
    , currentItem = Nothing
    , upcomingItems = items
    }


advanceSlide : Slide -> Slide
advanceSlide slide =
    case slide.currentItem of
        Nothing ->
            nextItem slide

        Just item ->
            if bulletsAreRemaining item then
                { slide | currentItem = Just <| advanceBulletList item }
            else
                nextItem slide


nextItem : Slide -> Slide
nextItem slide =
    { slide
        | previousItems = slide.previousItems ++ Maybe.withDefault [] (Maybe.map List.singleton slide.currentItem)
        , currentItem = List.head slide.upcomingItems
        , upcomingItems = List.drop 1 slide.upcomingItems
    }


dropFromEnd : Int -> List a -> List a
dropFromEnd n =
    List.reverse >> List.drop n >> List.reverse
