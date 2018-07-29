port module SoundPort exposing (playSound)

import Time exposing (Time)


port playSound : { timeout: Time, filepath: String } -> Cmd msg
