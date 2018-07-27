module Event exposing (..)

import Model exposing (..)
import Random


generateDirection : Cmd Msg
generateDirection =
    Random.bool
    |> Random.map (\boolean -> if boolean then Left else Right)
    |> Random.generate NewDirection
