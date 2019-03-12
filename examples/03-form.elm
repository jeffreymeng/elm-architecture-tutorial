import Browser
import Html exposing (..)
import Html.Attributes exposing (..)
import Html.Events exposing (onInput)
import Char exposing (isUpper, isLower, isDigit)
import String


-- MAIN


main =
  Browser.sandbox { init = init, update = update, view = view }



-- MODEL


type alias Model =
  { name : String
  , password : String
  , passwordAgain : String
  , age : String
  }


init : Model
init =
  Model "" "" "" ""



-- UPDATE


type Msg
  = Name String
  | Password String
  | PasswordAgain String
  | Age String


update : Msg -> Model -> Model
update msg model =
  case msg of
    Name name ->
      { model | name = name }

    Password password ->
      { model | password = password }

    PasswordAgain password ->
      { model | passwordAgain = password }
    Age age ->
      { model | age = age }


-- VIEW


view : Model -> Html Msg
view model =
  div []
    [ viewInput "text" "Name" model.name Name
    , viewInput "text" "Password" model.password Password
    , viewInput "password" "Re-enter Password" model.passwordAgain PasswordAgain
    , viewInput "text" "Age" model.age Age
    , hr [] []
    , viewValidation model
    , hr [] []
    ]


viewInput : String -> String -> String -> (String -> msg) -> Html msg
viewInput t p v toMsg =
  input [ type_ t, placeholder p, value v, onInput toMsg ] []


viewValidation : Model -> Html msg
viewValidation model =
  if model.password /= model.passwordAgain then
    div [ style "color" "red" ] [ text "Passwords do not match!" ]
  else if not (String.length model.password >= 8) then
    div [ style "color" "red" ] [ text "Passwords must be at least eight characters in length!"]
  else if not (String.any isUpper model.password) then
    div [ style "color" "red" ] [ text "Passwords must contain at least one upper case character."]
  else if not (String.any isLower model.password) then
      div [ style "color" "red" ] [ text "Passwords must contain at least one lower case character."]
  else if not (String.any isDigit model.password) then
      div [ style "color" "red" ] [ text "Passwords must contain at least one number."]
  else if not (String.all isDigit model.age) then
      div [style "color" "red" ] [ text "Age must be a number!"]
  else
    div [ style "color" "green" ] [ text "OK" ]

