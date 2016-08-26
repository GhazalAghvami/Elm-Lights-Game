module LightsGame exposing (Model, init, update, view, Msg(..), defaultBoard)

import Array
import Html
import Html.Attributes
import Html.Events
import Matrix exposing (Matrix)


-- model


type alias Model =
    { isOn : Matrix Bool }


init : Matrix Bool -> Model
init startingBoard =
    { isOn = startingBoard }


defaultBoard : Matrix Bool
defaultBoard =
    Matrix.repeat 5 5 True



-- update


type alias LightIndex =
    { x : Int, y : Int }


type Msg
    = Toggle LightIndex


update : Msg -> Model -> Model
update msg model =
    case msg of
        Toggle indexToToggle ->
            { model | isOn = toggleLight indexToToggle model.isOn }


toggleLight : LightIndex -> Matrix Bool -> Matrix Bool
toggleLight indexToToggle matrix =
    matrix
        |> Matrix.update indexToToggle.x indexToToggle.y not
        |> Matrix.update (indexToToggle.x + 1) indexToToggle.y not
        |> Matrix.update (indexToToggle.x - 1) indexToToggle.y not
        |> Matrix.update indexToToggle.x (indexToToggle.y + 1) not
        |> Matrix.update indexToToggle.x (indexToToggle.y - 1) not



--toggleLight indexToToggle list =
--    --TODO use the y index
--    Matrix.indexedMap
--        (\x y isOn ->
--            if indexToToggle.x == x then
--                not isOn
--            else if indexToToggle.x == x - 1 then
--                not isOn
--            else if indexToToggle.x == x + 1 then
--                not isOn
--            else
--                isOn
--        )
--        list
-- view


view : Model -> Html.Html Msg
view model =
    Html.div []
        [ model.isOn
            |> Matrix.indexedMap lightButton
            |> matrixToDivs
          --            |> Html.div []
        , Html.hr [] []
        , Html.pre [] [ Html.text <| toString model ]
        ]


matrixToDivs : Matrix (Html.Html Msg) -> Html.Html Msg
matrixToDivs matrix =
    let
        makeRow y =
            Matrix.getRow y matrix
                |> Maybe.map (Array.toList)
                |> Maybe.withDefault []
                |> Html.div []

        -- the Maybe.map or .withDefault puts the returned list as child of the div
        height =
            Matrix.height matrix
    in
        [0..height]
            |> List.map makeRow
            |> Html.div []


lightButton : Int -> Int -> Bool -> Html.Html Msg
lightButton x y isOn =
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
        , Html.Events.onClick (Toggle { x = x, y = y })
          --TODO use y
        ]
        []
