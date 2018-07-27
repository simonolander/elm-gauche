module Update exposing (..)

import Event exposing (generateDirection)
import Model exposing (..)


update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
    case msg of
        NewDirection direction ->
            ( { model
              | direction = direction
              , lastDirection = model.direction
              }
            , Cmd.none
            )

        Resize size ->
            ( { model
              | windowSize = size
              }
            , Cmd.none
            )

        DirectionClicked direction ->
            ( { model
              | directionClickedTime = model.time
              , correctGuess = direction == model.direction
              }
            , generateDirection
            )

        Tick diff ->
            ( { model
              | time = model.time + diff / 1000
              }
            , Cmd.none
            )
