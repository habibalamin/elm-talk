module Model.SlideItem
    exposing
        ( SlideItem
        , blankParagraph
        , blankBulletList
        , blankSubtitle
        , paragraph
        , bulletList
        , subtitle
        , slideItemToHtml
        )

import Html exposing (..)


type SlideItem
    = Subtitle String
    | Paragraph String
    | BulletListItem BulletList


type BulletList =
    BulletList
        { previousBullets : List String
        , currentBullet : Maybe String
        , upcomingBullets : List String
        }


previousBullets : BulletList -> List String
previousBullets (BulletList { previousBullets }) = previousBullets


currentBullet : BulletList -> Maybe String
currentBullet (BulletList { currentBullet }) = currentBullet


upcomingBullets : BulletList -> List String
upcomingBullets (BulletList { upcomingBullets }) = upcomingBullets


blankParagraph : SlideItem
blankParagraph =
    Paragraph ""


blankBulletList : SlideItem
blankBulletList =
    BulletListItem
        (BulletList
            { previousBullets = []
            , currentBullet = Nothing
            , upcomingBullets = []
            })


blankSubtitle : SlideItem
blankSubtitle =
    Subtitle ""


paragraph : String -> SlideItem
paragraph =
    Paragraph


bulletList : List String -> SlideItem
bulletList bullets =
    BulletListItem
        (BulletList
            { previousBullets = []
            , currentBullet = Nothing
            , upcomingBullets = bullets
            })


subtitle : String -> SlideItem
subtitle =
    Subtitle


slideItemToHtml : SlideItem -> Html a
slideItemToHtml slideItem =
    case slideItem of
        Subtitle body ->
            h2 [] [ text body ]

        Paragraph body ->
            p [] [ text body ]

        BulletListItem (BulletList { previousBullets, currentBullet, upcomingBullets }) ->
            case currentBullet of
                Nothing ->
                    listToUl previousBullets

                Just bullet ->
                    listToUl <| previousBullets ++ [ bullet ]


listToUl : List String -> Html a
listToUl list =
    ul [] <| List.map bulletToLi list


bulletToLi : String -> Html a
bulletToLi =
    text >> flip (::) [] >> li []
