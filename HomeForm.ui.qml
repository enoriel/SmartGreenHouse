import QtQuick 2.10
import QtQuick.Controls 2.3
import QtQuick.Layouts 1.3
import QtQuick.Extras 1.4

Page {
    width: 800
    height: 480

    title: qsTr("Home")
    property int id_input: 0

    // Connections between buttons and text input & display
    Connections {
        target: switch_city
        onToggled: {
            // Display input menu
            inputItem.visible = !inputItem.visible
            btn_search.visible = !btn_search.visible
            city_text.visible = !city_text.visible
            // Enable or disable buttons uses
            switch_gps.checkable = !switch_gps.checkable
            switch_postal.checkable = !switch_postal.checkable
            id_input = 0
        }
    }

    Rectangle {
        id: select
        x: 0
        y: 0
        width: 800
        height: 91
        color: "#ffffff"

        SwitchDelegate {
            id: switch_city
            x: 0
            y: 0
            width: 208
            height: 31
            text: qsTr("Ville")
            clip: false
            display: AbstractButton.TextOnly
            autoExclusive: false
            checked: false
            focusPolicy: Qt.NoFocus
            wheelEnabled: false
            highlighted: false
        }

        TextArea {
            id: city_text
            x: 229
            y: 6
            width: 127
            height: 78
            text: qsTr("Ville :
Pays:")
            visible: false
            padding: 10
            font.pointSize: 13
        }

        TextArea {
            id: gps_coordonate
            x: 237
            y: 4
            width: 112
            height: 80
            text: qsTr("Longitude :
Latitude:")
            visible: false
            font.pointSize: 13
            padding: 10
        }

        Button {
            id: btn_search
            x: 703
            y: 7
            width: 93
            height: 70
            text: qsTr("Rechercher")
            font.pointSize: 10
            visible: false
        }

        SwitchDelegate {
            id: switch_postal
            x: 0
            y: 32
            width: 208
            height: 28
            text: qsTr("Code postal")
            autoExclusive: false
            highlighted: false
        }

        SwitchDelegate {
            id: switch_gps
            x: 0
            y: 61
            width: 208
            height: 30
            text: qsTr("Coordonnées GPS")
            autoExclusive: false
            highlighted: false
        }

        TextArea {
            id: cp_country
            x: 229
            y: 4
            width: 127
            height: 80
            text: qsTr("Code postal:
Pays:")
            visible: false
            font.pointSize: 13
            padding: 10
        }

        Rectangle {
            id: input_rect2
            x: 362
            y: 6
            width: 324
            height: 39
            color: "#f5f5f5"
            radius: 4
            visible: true
            border.width: 0

            TextInput {
                id: aInput
                objectName: "city"
                x: 4
                y: 0
                width: 320
                height: 39
                horizontalAlignment: Text.AlignHCenter
                font.pixelSize: 18
            }
        }

        Rectangle {
            id: input_rect
            x: 362
            y: 51
            width: 324
            height: 32
            color: "#f5f5f5"
            radius: 4
            visible: true
            border.width: 0

            TextInput {
                id: bInput
                objectName: "country"
                x: 5
                y: 0
                width: 319
                height: 37
                horizontalAlignment: Text.AlignHCenter
                font.pixelSize: 18
            }
        }

        Item {
            id: inputItem
            x: 277
            y: 4
            width: 420
            height: 73
            visible: false
        }
    }

    Connections {
        target: switch_postal
        onToggled: {
            // Display input menu
            cp_country.visible = !cp_country.visible
            inputItem.visible = !inputItem.visible
            btn_search.visible = !btn_search.visible
            // Enable or disable buttons uses
            switch_gps.checkable = !switch_gps.checkable
            switch_city.checkable = !switch_city.checkable
            id_input = 1
        }
    }

    Connections {
        target: switch_gps
        onToggled: {
            // Display input menu
            gps_coordonate.visible = !gps_coordonate.visible
            inputItem.visible = !inputItem.visible
            btn_search.visible = !btn_search.visible
            // Enable or disable buttons uses
            switch_postal.checkable = !switch_postal.checkable
            switch_city.checkable = !switch_city.checkable
            id_input = 2
        }
    }
    // Status and weather windows
    Rectangle {
        id: main_window
        x: 0
        y: 103
        width: 800
        height: 377
        color: "#ffffff"
        radius: 6

        ToolSeparator {
            id: toolSeparator
            x: 398
            y: 15
            width: 13
            height: 294
        }

        Item {
            id: param_serre
            x: 408
            y: 8
            width: 384
            height: 258

            ToolSeparator {
                id: toolSeparator1
                x: 43
                y: 47
                width: 324
                height: 5
            }

            Text {
                id: element
                x: 1
                y: 10
                width: 375
                height: 31
                color: "#000000"
                text: qsTr("Paramètres de la serre connectée")
                font.underline: false
                font.italic: false
                font.bold: true
                horizontalAlignment: Text.AlignRight
                font.pixelSize: 18
            }

            StatusIndicator {
                id: statusLigth
                x: 5
                y: 71
                width: 50
                height: 50
                color: "#0cbc16"
                active: weather.lightStatus
            }

            Text {
                id: element1
                x: 64
                y: 71
                width: 191
                height: 50
                text: qsTr("Etat de l'éclairage")
                horizontalAlignment: Text.AlignLeft
                verticalAlignment: Text.AlignVCenter
                font.pixelSize: 22
            }

            Text {
                id: element2
                x: 68
                y: 124
                width: 174
                height: 60
                text: qsTr("Humidité au sol:")
                verticalAlignment: Text.AlignVCenter
                font.pixelSize: 23
            }

            Text {
                id: element3
                x: 60
                y: 190
                width: 146
                height: 60
                text: qsTr("Humidité de l'air:")
                verticalAlignment: Text.AlignVCenter
                font.pixelSize: 23
            }

            Image {
                id: image2
                x: 284
                y: 257
                width: 56
                height: 56
                sourceSize.height: 56
                sourceSize.width: 56
                fillMode: Image.PreserveAspectFit
                source: "img/svg/wi-celsius.svg"
            }

            Image {
                id: image
                x: 0
                y: 256
                width: 60
                height: 60
                sourceSize.height: 60
                sourceSize.width: 60
                fillMode: Image.PreserveAspectFit
                source: "img/svg/wi-thermometer.svg"
            }

            Text {
                id: element4
                x: 43
                y: 266
                width: 115
                height: 38
                text: qsTr("Température:")
                verticalAlignment: Text.AlignVCenter
                font.pixelSize: 26
            }

            Label {
                id: gnd_humidity
                x: 274
                y: 139
                width: 45
                height: 31
                font.pointSize: 18
                text: weather.humGnd
                verticalAlignment: Text.AlignVCenter
            }

            Label {
                id: temp_s_value
                x: 223
                y: 266
                width: 60
                height: 38
                horizontalAlignment: Text.AlignLeft
                font.pointSize: 20
                text: weather.tempGH
                verticalAlignment: Text.AlignVCenter
            }

            Image {
                id: image1
                x: 0
                y: 190
                width: 60
                height: 60
                sourceSize.height: 60
                sourceSize.width: 60
                fillMode: Image.PreserveAspectFit
                source: "img/svg/wi-umbrella.svg"
            }

            Image {
                id: image3
                x: 0
                y: 124
                width: 60
                height: 60
                sourceSize.height: 60
                sourceSize.width: 60
                fillMode: Image.PreserveAspectFit
                source: "img/svg/wi-sleet.svg"
            }

            Label {
                id: air_humidity
                x: 266
                y: 190
                width: 53
                height: 60
                text: weather.humAir
                verticalAlignment: Text.AlignVCenter
                font.pointSize: 20
            }
        }

        Item {
            id: param_city
            x: 8
            y: 8
            width: 384
            height: 314
            visible: true

            ToolSeparator {
                id: toolSeparator2
                x: 16
                y: 47
                width: 354
                height: 5
            }

            Text {
                id: element5
                x: 74
                y: 10
                width: 317
                height: 31
                color: "#000000"
                text: qsTr("Condition météorologique")
                font.italic: false
                font.pixelSize: 18
                horizontalAlignment: Text.AlignRight
                font.underline: false
                font.bold: true
            }

            Label {
                id: temp_value
                x: 213
                y: 58
                width: 72
                height: 39
                /* text: qsTr("6.2") */
                text: weather.temp
                verticalAlignment: Text.AlignTop
                horizontalAlignment: Text.AlignRight
                font.pointSize: 25
            }

            Image {
                id: weather_svg
                x: 16
                y: 58
                width: 150
                height: 150
                sourceSize.height: 150
                sourceSize.width: 150
                //source: "img/svg/01d.svg"
                source: "img/svg/" + weather.svg + ".svg"
                fillMode: Image.PreserveAspectFit
            }

            Image {
                id: image4
                x: 268
                y: 47
                width: 60
                height: 51
                sourceSize.height: 50
                sourceSize.width: 50
                source: "img/svg/wi-celsius.svg"
                fillMode: Image.PreserveAspectFit
            }

            Image {
                id: image5
                x: 172
                y: 58
                sourceSize.height: 45
                sourceSize.width: 45
                source: "img/svg/wi-thermometer.svg"
                fillMode: Image.PreserveAspectFit
            }

            Label {
                id: humidity_value
                x: 215
                y: 103
                width: 72
                height: 41
                text: weather.humidity + "%"
                font.pointSize: 25
                horizontalAlignment: Text.AlignHCenter
                verticalAlignment: Text.AlignBottom
            }

            Label {
                id: city_name
                x: 73
                y: 214
                width: 249
                height: 38
                text: weather.city
                horizontalAlignment: Text.AlignRight
                font.italic: true
                font.bold: true
                font.capitalization: Font.AllUppercase
                font.pointSize: 24
                font.family: "Times New Roman"
                verticalAlignment: Text.AlignVCenter
            }

            Text {
                id: sunrise
                x: 8
                y: 250
                width: 99
                height: 29
                text: qsTr("Lever de soleil:")
                horizontalAlignment: Text.AlignLeft
                verticalAlignment: Text.AlignVCenter
                font.pixelSize: 18
            }

            Text {
                id: sunset
                x: 8
                y: 280
                width: 152
                height: 29
                text: qsTr("Coucher de soleil:")
                horizontalAlignment: Text.AlignLeft
                font.pixelSize: 18
                verticalAlignment: Text.AlignVCenter
            }

            Label {
                id: sunrise_value
                x: 147
                y: 253
                width: 150
                height: 24
                text: weather.sunrise
                font.bold: false
                font.pointSize: 14
                verticalAlignment: Text.AlignVCenter
            }

            Label {
                id: sunset_value
                x: 172
                y: 283
                width: 126
                height: 24
                text: weather.sunset
                font.pointSize: 14
                verticalAlignment: Text.AlignVCenter
            }

            Image {
                id: image7
                x: 177
                y: 105
                width: 40
                height: 30
                sourceSize.height: 40
                sourceSize.width: 40
                source: "img/svg/dropwater.svg"
                fillMode: Image.PreserveAspectFit
            }
        }
    }

    Text {
        id: title_h1
        x: 0
        y: 0
        width: 362
        height: 55
        color: "#000000"
        text: qsTr("Serre Connectée")
        visible: false
        font.italic: true
        font.bold: true
        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignHCenter
        font.pixelSize: 46
    }

    // Button send Connections to cpp research function
    Connections {
        target: btn_search
        onClicked: {
            // Searching for weather info
            if ((aInput.text !== "") && (bInput.text != "")) {
                weather.sendRequest(id_input, aInput.text, bInput.text)
                aInput.clear()
                bInput.clear()
            } else {
                // Display error message
                weather.errSearch()
            }
        }
    }
}

