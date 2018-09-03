module Main exposing (Model, Msg(..), Todo, addItem, clearItem, main, model, todoApp, todoAside, todoForm, todoHeader, todoItem, todoList, update, view)

import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (..)



-- model


type alias Model =
    { name : String
    , todos : List Todo
    }


type alias Todo =
    { id : Int
    , name : String
    }


model : Model
model =
    { name = ""
    , todos = []
    }



-- update


type Msg
    = Input String
    | AddItem
    | ClearItem Todo


update : Msg -> Model -> Model
update msg model =
    case msg of
        Input name ->
            { model | name = name }

        AddItem ->
            if String.isEmpty model.name then
                model

            else
                addItem model

        ClearItem todo ->
            clearItem model todo


clearItem : Model -> Todo -> Model
clearItem model todo =
    let
        newTodos =
            List.filter
                (\p ->
                    p.id
                        /= todo.id
                )
                model.todos
    in
    { model | todos = newTodos }


addItem : Model -> Model
addItem model =
    let
        todo =
            Todo (List.length model.todos) model.name

        newTodos =
            todo :: model.todos
    in
    { model
        | todos = newTodos
        , name = ""
    }



-- view


view : Model -> Html Msg
view model =
    div []
        [ todoHeader
        , todoApp model
        ]


todoHeader : Html Msg
todoHeader =
    header [ class "intro" ]
        [ h1 [] [ text "Done list" ]
        , p [] [ text "A list of things you have archived today." ]
        , p []
            [ strong [] [ text "Note: " ]
            , text "The data isn't stored, so it will dissapear if you reload!"
            ]
        ]


todoApp : Model -> Html Msg
todoApp model =
    section [ class "app" ]
        [ section [ class "app__input" ]
            [ h2 [] [ text "What you've done" ]
            , todoList model
            , todoForm model
            ]
        , todoAside model
        ]


todoAside : Model -> Html Msg
todoAside model =
    aside [ class "app__status" ]
        [ p []
            [ text "You've done "
            , span [] [ text (List.length model.todos |> toString) ]
            , text " things today"
            ]
        ]


todoForm : Model -> Html Msg
todoForm model =
    Html.form [ onSubmit AddItem ]
        [ div []
            [ label [] [ text "Add a new item" ]
            , input [ type_ "text", onInput Input, value model.name ] []
            , button [ type_ "button", onClick AddItem ] [ text "Save" ]
            ]
        ]


todoList : Model -> Html Msg
todoList model =
    model.todos
        |> List.map todoItem
        |> ul []


todoItem : Todo -> Html Msg
todoItem todo =
    li []
        [ text todo.name
        , button [ type_ "button", onClick (ClearItem todo) ] [ text "×" ]
        ]


main : Program Never Model Msg
main =
    Html.beginnerProgram
        { model = model
        , update = update
        , view = view
        }
