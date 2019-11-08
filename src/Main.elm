module Main exposing (main)

import Browser
import Css
import Html.Styled as H
import Html.Styled.Attributes as HA
import Html.Styled.Events as HE


hitPointsInit : Int
hitPointsInit =
    10


hitPointsEnd : Int
hitPointsEnd =
    0


main : Program () Model Msg
main =
    Browser.sandbox
        { init = init
        , update = update
        , view = view >> H.toUnstyled
        }


type alias Model =
    { firstHitPoints : Int
    , otherHitPoints : Int
    }


init : Model
init =
    { firstHitPoints = hitPointsInit
    , otherHitPoints = hitPointsInit
    }


type Msg
    = UserClickedDecrementButton
    | UserClickedIncrementButton
    | UserClickedOtherDecrementButton
    | UserClickedOtherIncrementButton


update : Msg -> Model -> Model
update msg model =
    case msg of
        UserClickedDecrementButton ->
            if model.firstHitPoints <= hitPointsEnd then
                { model | firstHitPoints = hitPointsEnd }

            else
                { model | firstHitPoints = model.firstHitPoints - 1 }

        UserClickedIncrementButton ->
            if model.firstHitPoints >= hitPointsInit then
                { model | firstHitPoints = hitPointsInit }

            else
                { model | firstHitPoints = model.firstHitPoints + 1 }

        UserClickedOtherDecrementButton ->
            if model.otherHitPoints <= hitPointsEnd then
                { model | otherHitPoints = hitPointsEnd }

            else
                { model | otherHitPoints = model.otherHitPoints - 1 }

        UserClickedOtherIncrementButton ->
            if model.otherHitPoints >= hitPointsInit then
                { model | otherHitPoints = hitPointsInit }

            else
                { model | otherHitPoints = model.otherHitPoints + 1 }


view : Model -> H.Html Msg
view model =
    H.main_ []
        [ H.h1
            []
            [ H.text "Hello, Friday Tech Lounge!" ]

        -- Decrement Button
        , H.button
            [ HE.onClick UserClickedDecrementButton
            , HA.disabled <| model.firstHitPoints == hitPointsEnd
            , HA.css
                [ Css.fontSize <| Css.em 4
                , Css.display Css.inlineBlock
                , Css.marginRight <| Css.em 0.33
                ]
            ]
            [ H.text "-1" ]

        -- Display
        , H.div
            [ HA.css
                [ Css.fontSize <| Css.em 4
                , Css.display Css.inlineBlock
                , Css.marginRight <| Css.em 0.33
                ]
            ]
            [ H.text <| String.fromInt model.firstHitPoints ]

        -- Increment Button
        , H.button
            [ HE.onClick UserClickedIncrementButton
            , HA.disabled <| model.firstHitPoints == hitPointsInit
            , HA.css
                [ Css.fontSize <| Css.em 4
                , Css.display Css.inlineBlock
                , Css.marginRight <| Css.em 0.33
                ]
            ]
            [ H.text "+1" ]

        -- Line!
        , H.hr [] []

        -- Decrement Button
        , H.button
            [ HE.onClick UserClickedOtherDecrementButton
            , HA.disabled <| model.otherHitPoints == hitPointsEnd
            , HA.css
                [ Css.fontSize <| Css.em 4
                , Css.display Css.inlineBlock
                , Css.marginRight <| Css.em 0.33
                ]
            ]
            [ H.text "-1" ]

        -- Display
        , H.div
            [ HA.css
                [ Css.fontSize <| Css.em 4
                , Css.display Css.inlineBlock
                , Css.marginRight <| Css.em 0.33
                ]
            ]
            [ H.text <| String.fromInt model.otherHitPoints ]

        -- Increment Button
        , H.button
            [ HE.onClick UserClickedOtherIncrementButton
            , HA.disabled <| model.otherHitPoints == hitPointsInit
            , HA.css
                [ Css.fontSize <| Css.em 4
                , Css.display Css.inlineBlock
                , Css.marginRight <| Css.em 0.33
                ]
            ]
            [ H.text "+1" ]
        ]
