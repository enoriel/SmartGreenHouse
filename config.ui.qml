import QtQuick 2.11
import QtQuick.Controls 2.4
import bordeaux.ynov.com 1.0

Page {
    width: 640
    height: 400

    title: qsTr("Page 2")

    BackLight {
        id: backlight
    }

    Slider {
        id: slider
        x: 166
        y: 45
        width: 458
        height: 40
        from: 0
        value: 100
        to: 100
        stepSize: 1
    }

    Text {
        id: element
        x: 55
        y: 45
        width: 111
        height: 40
        text: qsTr("Luminositée")
        verticalAlignment: Text.AlignVCenter
        font.pixelSize: 18
    }

    Button {
        id: btn_shutdon
        x: 46
        y: 155
        width: 130
        height: 130
        text: qsTr("Eteindre")
        checked: false
        padding: 2
        font.pointSize: 18
        checkable: false
        background: Rectangle {
            border.width: 1
            radius: 4
            gradient: Gradient {
                GradientStop {
                    position: 0
                    color: "#e36565"
                }

                GradientStop {
                    position: 1
                    color: "#a31c1c"
                }
            }
            border.color: "#bc2424"
        }
    }

    Button {
        id: btn_reboot
        x: 201
        y: 155
        width: 130
        height: 130
        text: qsTr("Redémarrer")
        checked: false
        padding: 2
        font.pointSize: 16
        checkable: false
        background: Rectangle {
            //Image: "img/svg/reboot.svg"
            border.width: 1
            radius: 4
            gradient: Gradient {
                GradientStop {
                    position: 0
                    color: "#3ac9f2"
                }

                GradientStop {
                    position: 1
                    color: "#1784ba"
                }
            }
            border.color: "#19b0ea"
        }
    }

    Connections {
        target: btn_shutdon
        onClicked: {
            print("Shutdown")
            backlight.shutdown()
        }
    }

    Connections {
        target: btn_reboot
        onClicked: {
            print("Reboot")
            backlight.reboot()
        }
    }

    Connections {
        target: slider
        onMoved: {
            print(slider.value)
            backlight.setBacklight(slider.value)
        }
    }
}
