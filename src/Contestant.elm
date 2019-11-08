module Contestant exposing
    ( State
    , init
    , view
    , viewMatchup
    )

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


type alias State =
    { hitPoints : Int
    , name : String
    }


init : State
init =
    { hitPoints = hitPointsInit
    , name = "Some guy"
    }


viewMatchup : State -> State -> H.Html msg
viewMatchup a b =
    (case compare a.hitPoints b.hitPoints of
        EQ ->
            a.name ++ " and " ++ b.name ++ " are tied."

        GT ->
            a.name ++ " is beating " ++ b.name ++ "."

        LT ->
            b.name ++ " is beating " ++ a.name ++ "."
    )
        |> H.text
        |> List.singleton
        |> H.div []


updateContestantName : State -> String -> State
updateContestantName state name =
    { state | name = name }


decrementHitPoints : State -> State
decrementHitPoints state =
    if state.hitPoints <= hitPointsEnd then
        { state | hitPoints = hitPointsEnd }

    else
        { state | hitPoints = state.hitPoints - 1 }


incrementHitPoints : State -> State
incrementHitPoints state =
    if state.hitPoints >= hitPointsInit then
        { state | hitPoints = hitPointsInit }

    else
        { state | hitPoints = state.hitPoints + 1 }


view : State -> (State -> msg) -> H.Html msg
view state updateMsg =
    H.div []
        [ -- Title
          H.input
            [ HA.type_ "text"
            , HA.value state.name
            , HE.onInput (updateContestantName state >> updateMsg)
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
            [ HE.onClick (decrementHitPoints state |> updateMsg)
            , HA.disabled <| state.hitPoints == hitPointsEnd
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
            [ H.text <| String.fromInt state.hitPoints ]

        -- Increment Button
        , H.button
            [ incrementHitPoints state
                |> updateMsg
                |> HE.onClick
            , HA.disabled <| state.hitPoints == hitPointsInit
            , HA.css
                [ Css.fontSize <| Css.em 4
                , Css.display Css.inlineBlock
                , Css.marginRight <| Css.em 0.33
                ]
            ]
            [ H.text "+1" ]
        ]
