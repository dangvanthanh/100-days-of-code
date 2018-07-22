module Main exposing (..)

import Html exposing (..)
import Html.Events exposing (..)
import Html.Attributes exposing (..)


-- model


type alias Model =
    { voteType : Int
    , score : Int
    }


model : Model
model =
    { voteType = 0
    , score = 0
    }



-- update


type Msg
    = UpVote Int
    | DownVote Int


update : Msg -> Model -> Model
update msg model =
    case msg of
        UpVote voteType ->
            { model
                | voteType =
                    if model.voteType == voteType then
                        0
                    else
                        1
            }

        DownVote voteType ->
            { model
                | voteType =
                    if model.voteType == voteType then
                        0
                    else
                        -1
            }



-- view


view : Model -> Html Msg
view model =
    div []
        [ h1 [] [ text (toString (model.score + model.voteType)) ]
        , button
            [ classList
                [ ( "button-up-vote", True )
                , ( "active", model.voteType == 1 )
                ]
            , onClick (UpVote 1)
            ]
            [ text "Upvote" ]
        , button
            [ classList
                [ ( "button-down-vote", True )
                , ( "active", model.voteType == -1 )
                ]
            , onClick (DownVote -1)
            ]
            [ text "Downvote" ]
        ]


main : Program Never Model Msg
main =
    Html.beginnerProgram
        { model = model
        , update = update
        , view = view
        }
