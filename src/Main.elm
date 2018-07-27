module Main exposing (..)

import Event exposing (..)
import Html
import Html.Styled
import Model exposing (..)
import Task exposing (perform)
import AnimationFrame
import Update
import View
import Window exposing (Size)

main : Program Never Model Msg
main = Html.program
    { init = init
    , update = Update.update
    , subscriptions = subscriptions
    , view = View.view >> Html.Styled.toUnstyled
    }


init : (Model, Cmd Msg)
init =
    let
        model =
            { direction = Left
            , windowSize = Size 0 0
            , directionClickedTime = -1000
            , time = 0
            }

        cmd =
            Cmd.batch
                [ generateDirection
                , perform Resize Window.size
                ]
    in
        ( model
        , cmd
        )


subscriptions : Model -> Sub Msg
subscriptions model =
    let
        subs =
            [ AnimationFrame.diffs Tick
            , Window.resizes Resize
            ]
    in
        Sub.batch subs