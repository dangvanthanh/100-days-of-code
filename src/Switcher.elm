module Main exposing (..)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)


-- model


type alias Model =
    { channels : List String
    , selectedChannel : Int
    , query : String
    }


model : Model
model =
    { channels = [ "Elm", "Vue.js", "Ember.js", "React.js", "Angular", "Om" ]
    , selectedChannel = -1
    , query = ""
    }



-- update


type Msg
    = NoOp
    | Filter String
    | Select Int


update : Msg -> Model -> Model
update msg model =
    case msg of
        NoOp ->
            model

        Filter query ->
            { model | query = query }

        Select index ->
            { model | selectedChannel = index }



-- view


filterChannels : List String -> String -> List String
filterChannels channels query =
    let
        containsCaseInsensitive str1 str2 =
            String.contains (String.toLower str1) (String.toLower str2)
    in
        List.filter (containsCaseInsensitive query) channels


renderChannelName : String -> String
renderChannelName name =
    name
        |> String.toUpper
        |> String.reverse
        |> String.reverse


renderChannel : String -> Html Msg
renderChannel name =
    li [ class "collection-item" ]
        [ text (renderChannelName name)
        ]


renderChannels : List String -> Html Msg
renderChannels channels =
    let
        channelItems =
            List.map renderChannel channels
    in
        ul [ class "collection" ] channelItems


view : Model -> Html Msg
view model =
    div [ class "" ]
        [ input [ class "search-box", onInput Filter ] []
        , renderChannels (filterChannels model.channels model.query)
        ]


main : Program Never Model Msg
main =
    Html.beginnerProgram
        { model = model
        , update = update
        , view = view
        }
