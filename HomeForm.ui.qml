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
            y: 15
            width: 324
            height: 24
            color: "#f5f5f5"
            radius: 4
            visible: true
            border.width: 0

            TextInput {
                id: aInput
                objectName: "city"
                x: 4
                y: 0
                width: 312
                height: 24
                font.pixelSize: 12
            }
        }

        Rectangle {
            id: input_rect
            x: 362
            y: 45
            width: 324
            height: 24
            color: "#f5f5f5"
            radius: 4
            visible: true
            border.width: 0

            TextInput {
                id: bInput
                objectName: "country"
                x: 5
                y: 0
                width: 304
                height: 24
                font.pixelSize: 12
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
        x: 40
        y: 103
        width: 720
        height: 290
        color: "#ffffff"
        radius: 6

        ToolSeparator {
            id: toolSeparator
            x: 398
            y: 15
            width: 13
            height: 267
        }

        Item {
            id: param_serre
            x: 408
            y: 8
            width: 304
            height: 258

            ToolSeparator {
                id: toolSeparator1
                x: 8
                y: 47
                width: 290
                height: 5
            }

            Text {
                id: element
                x: 1
                y: 10
                width: 306
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
                x: 11
                y: 58
                width: 26
                height: 29
                color: "#0cbc16"
                active: weather.lightStatus
            }

            Text {
                id: element1
                x: 43
                y: 58
                width: 176
                height: 29
                text: qsTr("Etat de l'éclairage")
                horizontalAlignment: Text.AlignLeft
                verticalAlignment: Text.AlignVCenter
                font.pixelSize: 14
            }

            Text {
                id: element2
                x: 43
                y: 106
                width: 127
                height: 22
                text: qsTr("Humidité au sol:")
                verticalAlignment: Text.AlignVCenter
                font.pixelSize: 14
            }

            Text {
                id: element3
                x: 43
                y: 153
                width: 127
                height: 22
                text: qsTr("Humidité de l'air:")
                verticalAlignment: Text.AlignVCenter
                font.pixelSize: 14
            }

            Image {
                id: image2
                x: 182
                y: 196
                width: 29
                height: 26
                sourceSize.height: 29
                sourceSize.width: 29
                fillMode: Image.PreserveAspectFit
                source: "img/svg/wi-celsius.svg"
            }

            Image {
                id: image
                x: 11
                y: 194
                sourceSize.height: 30
                sourceSize.width: 30
                fillMode: Image.PreserveAspectFit
                source: "img/svg/wi-thermometer.svg"
            }

            Text {
                id: element4
                x: 43
                y: 198
                width: 94
                height: 22
                text: qsTr("Température:")
                verticalAlignment: Text.AlignVCenter
                font.pixelSize: 14
            }

            Label {
                id: gnd_humidity
                x: 169
                y: 108
                width: 33
                height: 20
                font.pointSize: 14
                text: weather.humGnd
            }

            Label {
                id: temp_s_value
                x: 140
                y: 196
                width: 41
                height: 22
                horizontalAlignment: Text.AlignRight
                font.pointSize: 14
                text: weather.tempGH
            }

            Image {
                id: image1
                x: 11
                y: 148
                sourceSize.height: 30
                sourceSize.width: 30
                fillMode: Image.PreserveAspectFit
                source: "img/svg/wi-umbrella.svg"
            }

            Image {
                id: image3
                x: 11
                y: 102
                sourceSize.height: 30
                sourceSize.width: 30
                fillMode: Image.PreserveAspectFit
                source: "img/svg/wi-sleet.svg"
            }

            Label {
                id: air_humidity
                x: 164
                y: 153
                width: 33
                height: 22
                font.pointSize: 14
                text: weather.humAir
            }
        }

        Item {
            id: param_city
            x: 8
            y: 8
            width: 384
            height: 282
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
                x: 134
                y: 191
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
                y: 224
                width: 99
                height: 29
                text: qsTr("Lever de soleil:")
                horizontalAlignment: Text.AlignLeft
                verticalAlignment: Text.AlignVCenter
                font.pixelSize: 14
            }

            Text {
                id: sunset
                x: 8
                y: 254
                width: 120
                height: 29
                text: qsTr("Coucher de soleil:")
                horizontalAlignment: Text.AlignLeft
                font.pixelSize: 14
                verticalAlignment: Text.AlignVCenter
            }

            Label {
                id: sunrise_value
                x: 113
                y: 227
                width: 149
                height: 24
                text: weather.sunrise
                font.bold: false
                font.pointSize: 12
                verticalAlignment: Text.AlignVCenter
            }

            Label {
                id: sunset_value
                x: 134
                y: 257
                width: 138
                height: 24
                text: weather.sunset
                font.pointSize: 12
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
