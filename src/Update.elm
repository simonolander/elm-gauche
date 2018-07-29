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
            , if model.muted
                then
                    Cmd.none
                else
                    SoundPort.playSound
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

        MutedClicked muted ->
            ( { model
              | muted = muted
              }
            , Cmd.none
            )

        PlaySoundClicked playSoundPayload ->
            ( model
            , if model.muted
                then
                    Cmd.none
                else
                    SoundPort.playSound playSoundPayload
            )

        Tick diff ->
            ( { model
              | time = model.time + diff / 1000
              }
            , Cmd.none
            )
