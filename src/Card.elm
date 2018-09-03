module Main exposing (Model, Msg(..), init, main, update, view)

import Browser
import Html exposing (Html, div, span, text)
import Html.Attributes exposing (..)



-- model


type alias Model =
    { suit : String
    , rank : String
    }


init : Model
init =
    { suit = "♥"
    , rank = "A"
    }



-- update


type Msg
    = ShuffleCard


update : Msg -> Model -> Model
update msg card =
    case msg of
        ShuffleCard ->
            card



-- view


view : Model -> Html Msg
view card =
    div []
        [ div [ class "card" ]
            [ span [ class "card__suit" ] [ text card.suit ]
            , span [ class "card__number" ] [ text card.rank ]
            , span [ class "card__suit" ] [ text card.suit ]
            ]
        ]


main =
    Browser.sandbox
        { init = init
        , update = update
        , view = view
        }
