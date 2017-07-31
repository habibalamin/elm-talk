module Model.Slide
    exposing
        ( Slide
        , title
        , previousItems
        , currentItem
        , upcomingItems
        , blankSlide
        , slide
        )

import Model.SlideItem exposing (..)


type Slide
    = Slide
        { title : String
        , previousItems : List SlideItem
        , currentItem : Maybe SlideItem
        , upcomingItems : List SlideItem
        }


title : Slide -> String
title (Slide { title }) =
    title


previousItems : Slide -> List SlideItem
previousItems (Slide { previousItems }) =
    previousItems


currentItem : Slide -> Maybe SlideItem
currentItem (Slide { currentItem }) =
    currentItem


upcomingItems : Slide -> List SlideItem
upcomingItems (Slide { upcomingItems }) =
    upcomingItems


blankSlide : Slide
blankSlide =
    Slide
        { title = ""
        , previousItems = []
        , currentItem = Nothing
        , upcomingItems = []
        }


slide : String -> List SlideItem -> Slide
slide title items =
    Slide
        { title = title
        , previousItems = []
        , currentItem = Nothing
        , upcomingItems = items
        }
