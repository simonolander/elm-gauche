module Update exposing (..)

import Constants exposing (waitingTime)
import Event exposing (generateDirection)
import Model exposing (..)
import SoundPort
import Translation exposing (getDirectionSoundPath)


update : Msg -> Model -> (Model, Cmd Msg)
update msg model =
    case msg of
        NewDirection direction ->
            ( { model
              | direction = direction
              , lastDirection = model.direction
              }
            , SoundPort.playSound
                { timeout = waitingTime
                , filepath = getDirectionSoundPath model.language direction
                }
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

        LanguageClicked language ->
            ( { model
              | language = language
              }
            , Cmd.none
            )

        Tick diff ->
            ( { model
              | time = model.time + diff / 1000
              }
            , Cmd.none
            )
