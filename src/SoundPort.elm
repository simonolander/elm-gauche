port module SoundPort exposing (playSound)

import Model exposing (PlaySoundPayload)


port playSound : PlaySoundPayload -> Cmd msg
