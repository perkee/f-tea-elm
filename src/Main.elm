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
    , firstPlayerName : String
    , otherPlayerName : String
    }


init : Model
init =
    { firstHitPoints = hitPointsInit
    , otherHitPoints = hitPointsInit
    , firstPlayerName = "The good guy"
    , otherPlayerName = "The bad guy"
    }


type Msg
    = UserClickedDecrementButton
    | UserClickedIncrementButton
    | UserClickedOtherDecrementButton
    | UserClickedOtherIncrementButton
    | UserChangedFirstPlayerName String
    | UserChangedOtherPlayerName String


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

        UserChangedFirstPlayerName name ->
            { model | firstPlayerName = name }

        UserChangedOtherPlayerName name ->
            { model | otherPlayerName = name }


view : Model -> H.Html Msg
view model =
    H.main_ []
        [ H.h1 [] [ H.text "Counting!" ]
        , viewContestant
            model.firstPlayerName
            model.firstHitPoints
            UserChangedFirstPlayerName
            UserClickedIncrementButton
            UserClickedDecrementButton

        -- Line!
        , H.hr [] []
        , viewContestant
            model.otherPlayerName
            model.otherHitPoints
            UserChangedOtherPlayerName
            UserClickedOtherIncrementButton
            UserClickedOtherDecrementButton

        -- Line!
        , H.hr [] []
        , (case compare model.firstHitPoints model.otherHitPoints of
            EQ ->
                model.firstPlayerName ++ " and " ++ model.otherPlayerName ++ " are tied."

            GT ->
                model.firstPlayerName ++ " is beating " ++ model.otherPlayerName ++ "."

            LT ->
                model.otherPlayerName ++ " is beating " ++ model.firstPlayerName ++ "."
          )
            |> H.text
            |> List.singleton
            |> H.div []
        ]


viewContestant : String -> Int -> (String -> msg) -> msg -> msg -> H.Html msg
viewContestant name hitPoints nameMsg incMsg decMsg =
    H.div []
        [ -- Title
          H.input
            [ HA.type_ "text"
            , HA.value name
            , HE.onInput <| nameMsg
            , HA.css
                [ Css.fontSize <|
                    Css.em 2
                , Css.display
                    Css.block
                ]
            ]
            []

        -- Decrement Button
        , H.button
            [ HE.onClick decMsg
            , HA.disabled <| hitPoints == hitPointsEnd
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
            [ H.text <| String.fromInt hitPoints ]

        -- Increment Button
        , H.button
            [ HE.onClick incMsg
            , HA.disabled <| hitPoints == hitPointsInit
            , HA.css
                [ Css.fontSize <| Css.em 4
                , Css.display Css.inlineBlock
                , Css.marginRight <| Css.em 0.33
                ]
            ]
            [ H.text "+1" ]
        ]
