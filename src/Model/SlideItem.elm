module Model.SlideItem
    exposing
        ( SlideItem(..)
        , blankSubtitle
        , blankParagraph
        , blankBulletList
        , subtitle
        , paragraph
        , bulletList
        , isSubtitle
        , isParagraph
        , isBulletList
        , bulletsAreRemaining
        , slideItemComplete
        , advanceBulletList
        , slideItemToHtml
        )

import Html exposing (..)


type SlideItem
    = Subtitle String
    | Paragraph String
    | BulletListItem BulletList


type alias BulletList =
    { previousBullets : List String
    , currentBullet : String
    , upcomingBullets : List String
    }


blankSubtitle : SlideItem
blankSubtitle =
    Subtitle ""


blankParagraph : SlideItem
blankParagraph =
    Paragraph ""


blankBulletList : SlideItem
blankBulletList =
    BulletListItem
        { previousBullets = []
        , currentBullet = ""
        , upcomingBullets = []
        }


subtitle : String -> SlideItem
subtitle =
    Subtitle


paragraph : String -> SlideItem
paragraph =
    Paragraph


bulletList : String -> List String -> SlideItem
bulletList firstBullet bullets =
    BulletListItem
        { previousBullets = []
        , currentBullet = firstBullet
        , upcomingBullets = bullets
        }


isSubtitle : SlideItem -> Bool
isSubtitle item =
    case item of
        Subtitle _ ->
            True

        _ ->
            False


isParagraph : SlideItem -> Bool
isParagraph item =
    case item of
        Paragraph _ ->
            True

        _ ->
            False


isBulletList : SlideItem -> Bool
isBulletList item =
    case item of
        BulletListItem _ ->
            True

        _ ->
            False


bulletsAreRemaining : SlideItem -> Bool
bulletsAreRemaining item =
    case item of
        BulletListItem bullets ->
            List.length bullets.upcomingBullets > 0

        _ ->
            False


slideItemComplete : SlideItem -> Bool
slideItemComplete = not << bulletsAreRemaining


advanceBulletList : SlideItem -> SlideItem
advanceBulletList item =
    case item of
        BulletListItem bullets ->
            case List.head bullets.upcomingBullets of
                Nothing -> BulletListItem bullets
                Just bullet ->
                    BulletListItem
                        { bullets |
                          previousBullets = bullets.previousBullets ++ [ bullets.currentBullet ]
                        , currentBullet = bullet
                        , upcomingBullets = List.drop 1 bullets.upcomingBullets
                        }

        _ ->
            item


slideItemToHtml : SlideItem -> Html a
slideItemToHtml slideItem =
    case slideItem of
        Subtitle body ->
            h2 [] [ text body ]

        Paragraph body ->
            p [] [ text body ]

        BulletListItem bullets ->
            listToUl <| bullets.previousBullets ++ [ bullets.currentBullet ]


listToUl : List String -> Html a
listToUl list =
    ul [] <| List.map bulletToLi list


bulletToLi : String -> Html a
bulletToLi =
    text >> List.singleton >> li []
