module LightsGame exposing (Model, init, update, view, Msg(..), defaultBoard)

import Html
import Html.Attributes
import Html.Events


-- model


type alias Model =
    { isOn : List Bool }


init : List Bool -> Model
init startingBoard =
    { isOn = startingBoard }


defaultBoard : List Bool
defaultBoard =
    [ True, False, True, False, True ]



-- update


type Msg
    = Toggle Int


update : Msg -> Model -> Model
update msg model =
    case msg of
        Toggle indexToToggle ->
            { model | isOn = toggleLight indexToToggle model.isOn }


toggleLight : Int -> List Bool -> List Bool
toggleLight indexToToggle list =
    List.indexedMap
        (\i isOn ->
            if indexToToggle == i then
                not isOn
            else if indexToToggle == i - 1 then
                not isOn
            else if indexToToggle == i + 1 then
                not isOn
            else
                isOn
        )
        list



-- view


view : Model -> Html.Html Msg
view model =
    Html.div []
        [ model.isOn
            |> List.indexedMap lightButton
            |> Html.div []
        , Html.hr [] []
        , Html.pre [] [ Html.text <| toString model ]
        ]


lightButton : Int -> Bool -> Html.Html Msg
lightButton buttonIndex isOn =
    Html.div
        [ Html.Attributes.style
            [ ( "background-color"
              , if isOn then
                    "orange"
                else
                    "green"
              )
            , ( "width", "80px" )
            , ( "height", "80px" )
            , ( "border-radius", "4px" )
            , ( "margin", "2px" )
            , ( "display", "inline-block" )
            ]
        , Html.Events.onClick (Toggle buttonIndex)
        ]
        []
