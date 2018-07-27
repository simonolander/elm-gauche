module Model exposing (..)


import Time exposing (Time)
import Window exposing (Size)


type Direction =
    Left
    | Right

type alias Model =
    { direction: Direction
    , windowSize: Size
    , directionClickedTime: Time
    , time: Time
    }

type Msg =
    Tick Time
    | NewDirection Direction
    | Resize Size
    | DirectionClicked Direction