module Main exposing (main)

import Browser
import Contestant
import Css
import Html.Styled as H
import Html.Styled.Attributes as HA
import Html.Styled.Events as HE


main : Program () Model Msg
main =
    Browser.sandbox
        { init = init
        , update = update
        , view = view >> H.toUnstyled
        }


type alias Model =
    { firstContestant : Contestant.State
    , otherContestant : Contestant.State
    }


init : Model
init =
    { firstContestant = Contestant.init
    , otherContestant = Contestant.init
    }


type Msg
    = UserUpdatedFirstContestant Contestant.State
    | UserUpdatedOtherContestant Contestant.State


update : Msg -> Model -> Model
update msg model =
    case msg of
        UserUpdatedFirstContestant s ->
            { model | firstContestant = s }

        UserUpdatedOtherContestant s ->
            { model | otherContestant = s }


view : Model -> H.Html Msg
view model =
    H.main_ []
        [ H.h1 [] [ H.text "Counting!" ]

        -- first guy
        , Contestant.view
            model.firstContestant
            UserUpdatedFirstContestant

        -- Line!
        , H.hr [] []

        -- other guy
        , Contestant.view
            model.otherContestant
            UserUpdatedOtherContestant

        -- Line!
        , H.hr [] []
        , Contestant.viewMatchup
            model.firstContestant
            model.otherContestant
        ]
