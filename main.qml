import QtQuick 2.10
import QtQuick.Controls 2.3
import QtQuick.VirtualKeyboard 2.3
import bordeaux.ynov.com 1.0

ApplicationWindow {
    id: window
    visible: true
    width: 800
    height: 480
    title: qsTr("Serre connectée")

    Weather {
        id: weather
    }

    header: ToolBar {
        contentHeight: toolButton.implicitHeight

        ToolButton {
            id: toolButton
            text: stackView.depth > 1 ? "\u25C0" : "\u2630"
            font.pixelSize: Qt.application.font.pixelSize * 1.6
            onClicked: {
                if (stackView.depth > 1) {
                    stackView.pop()
                } else {
                    drawer.open()
                }
            }
        }

       Label {
        anchors.centerIn: parent
        Timer {
                interval: 1000; running: true; repeat: true
                // Display time & date
                onTriggered: {
                    time.text = Date().toString()
                    if ((Date().toString("m")) === "4"){
                        Weather.updateWeather();
                    }
                }
            }
            Text {
                id: time
                anchors.centerIn: parent
            }
       }
    }

    Drawer {
        id: drawer
        width: window.width * 0.25
        height: window.height

        Column {
            anchors.fill: parent

            ItemDelegate {
                text: qsTr("Entrée manuelle")
                width: parent.width
                onClicked: {
                    stackView.push("manForm.ui.qml")
                    drawer.close()
                }
            }
            ItemDelegate {
                text: qsTr("Configuration")
                width: parent.width
                onClicked: {
                    stackView.push("config.ui.qml")
                    drawer.close()
                }
            }
            ItemDelegate {
                text: qsTr("A propos")
                width: parent.width
                onClicked: {
                    stackView.push("about.ui.qml")
                    drawer.close()
                }
            }
        }
    }

    StackView {
        id: stackView
        initialItem: "HomeForm.ui.qml"
        anchors.fill: parent
    }

    InputPanel {
        id: inputPanel
        z: 99
        x: 0
        y: window.height
        width: window.width

        states: State {
            name: "visible"
            when: inputPanel.active
            PropertyChanges {
                target: inputPanel
                y: window.height - inputPanel.height
            }
        }
        transitions: Transition {
            from: ""
            to: "visible"
            reversible: true
            ParallelAnimation {
                NumberAnimation {
                    properties: "y"
                    duration: 250
                    easing.type: Easing.InOutQuad
                }
            }
        }
    }
}
