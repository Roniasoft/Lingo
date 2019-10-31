import QtQuick 2.12
import QtQuick.Controls 2.12

CheckBox {
    id: control
    text: qsTr("")
    checked: true

    indicator: Rectangle {
        implicitWidth: 16
        implicitHeight: 16
        x: control.leftPadding
        y: parent.height / 2 - height / 2
        radius: 0
        border.color: control.down ? "#2e7bcd" : "#5288c1"

        Rectangle {
            width: 10
            height: 10
            x: 3
            y: 3
            radius: 0
            color: control.down ? "#2e7bcd" : "#5288c1"
            opacity: control.checked ? 1 : 0;

            Behavior on opacity {
                NumberAnimation {
                    duration: 100
                    easing.type: Easing.InQuart

                }
            }

        }
    }

    contentItem: Text {
        text: control.text
        font: control.font
        opacity: enabled ? 1.0 : 0.3
        color: control.down ? "#2e7bcd" : "#5288c1"
        verticalAlignment: Text.AlignVCenter
        leftPadding: control.indicator.width + control.spacing
    }
}
