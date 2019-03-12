import Browser
import Html exposing (Html, Attribute, div, input, text, button)
import Html.Attributes exposing (..)
import Html.Events exposing (onInput, onClick)



-- MAIN


main =
  Browser.sandbox { init = init, update = update, view = view }



-- MODEL

type Mode = Normal | Reverse
type alias Model =
  { content : String,
    mode : Mode
  }


init : Model
init =
  { content = "", mode = Reverse}



-- UPDATE


type Msg = Change String | UpdateMode Mode


update : Msg -> Model -> Model
update msg model =
  case msg of
    Change newContent ->
      { model | content = newContent }
    UpdateMode newMode ->
      { model | mode = newMode }


-- VIEW


view : Model -> Html Msg
view model =
  div []
    [ input [ placeholder ("Text to " ++ (if model.mode == Reverse then "reverse" else "display")), value model.content, onInput Change ] []
    , div [] [ text (if model.mode == Reverse then (String.reverse model.content) else model.content) ]
    , button [ onClick (UpdateMode (if model.mode == Reverse then Normal else Reverse)) ] [ text ("Switch mode to " ++ (if model.mode == Reverse then "normal" else "reverse")) ]
    , button [ onClick (Change "") ] [ text "Clear Input" ]
    ]
