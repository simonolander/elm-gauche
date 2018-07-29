port module SoundPort exposing (playSound)

import Model exposing (PlaySoundPayload)
import Time exposing (Time)


port playSound : PlaySoundPayload -> Cmd msg
