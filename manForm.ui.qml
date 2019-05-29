import QtQuick 2.11
import QtQuick.Controls 2.4
import bordeaux.ynov.com 1.0

Page {
    width: 600
    height: 400

    title: qsTr("Selection manuel")

    Switch {
        id: lights
        x: 334
        y: 24
        width: 175
        height: 66
        text: qsTr("Lumière")
        font.pointSize: 15
        checked: weather.lightStatus
    }

    Text {
        id: element
        x: 57
        y: 19
        width: 209
        height: 38
        text: "Température de la serre"
        horizontalAlignment: Text.AlignHCenter
        verticalAlignment: Text.AlignVCenter
        font.pixelSize: 18
    }

    SpinBox {
        id: sBtemp
        x: 20
        y: 58
        width: 283
        height: 70
        valueFromText: weather.getTempGH
    }

    ToolSeparator {
        id: toolSeparator
        x: 309
        y: 24
        width: 13
        height: 351
    }

    Text {
        id: element1
        x: 57
        y: 134
        width: 209
        height: 38
        text: "Humidité de l'air"
        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignHCenter
        font.pixelSize: 18
    }

    SpinBox {
        id: sBair
        x: 25
        y: 173
        width: 278
        height: 70
        valueFromText: weather.humAir
    }

    Text {
        id: element2
        x: 57
        y: 255
        width: 209
        height: 38
        text: "Humidité du sol"
        verticalAlignment: Text.AlignVCenter
        horizontalAlignment: Text.AlignHCenter
        font.pixelSize: 18
    }

    SpinBox {
        id: sBgnd
        x: 25
        y: 299
        width: 278
        height: 71
        valueFromText: weather.humGnd
    }

    Connections {
        target: lights
        onClicked: {
            weather.setLightStatus
        }
    }
}
