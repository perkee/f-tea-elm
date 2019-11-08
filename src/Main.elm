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
        { init = hitPointsInit
        , update = update
        , view = view >> H.toUnstyled
        }


type alias Model =
    Int


type Msg
    = UserClickedDecrementButton
    | UserClickedIncrementButton


update : Msg -> Model -> Model
update msg model =
    case msg of
        UserClickedDecrementButton ->
            if model <= hitPointsEnd then
                hitPointsEnd

            else
                model - 1

        UserClickedIncrementButton ->
            if model >= hitPointsInit then
                hitPointsInit

            else
                model + 1


view : Model -> H.Html Msg
view model =
    H.main_ []
        [ H.h1
            []
            [ H.text "Hello, Friday Tech Lounge!" ]

        -- Decrement Button
        , H.button
            [ HE.onClick UserClickedDecrementButton
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
            [ H.text <| String.fromInt model ]

        -- Increment Button
        , H.button
            [ HE.onClick UserClickedIncrementButton
            , HA.css
                [ Css.fontSize <| Css.em 4
                , Css.display Css.inlineBlock
                , Css.marginRight <| Css.em 0.33
                ]
            ]
            [ H.text "+1" ]
        ]
