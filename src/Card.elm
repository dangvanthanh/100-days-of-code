module Main exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)


-- model


type alias Model =
    { suit : String
    , rank : String
    }


model : Model
model =
    { suit = "♥"
    , rank = "A"
    }



-- update


type Msg
    = ShuffleCard


update : Msg -> Model -> Model
update msg model =
    case msg of
        ShuffleCard ->
            model



-- view


view : Model -> Html Msg
view model =
    div []
        [ div [ class "card" ]
            [ span [ class "card__suit" ] [ text model.suit ]
            , span [ class "card__number" ] [ text model.rank ]
            , span [ class "card__suit" ] [ text model.suit ]
            ]
        ]


main : Program Never Model Msg
main =
    Html.beginnerProgram
        { model = model
        , update = update
        , view = view
        }
