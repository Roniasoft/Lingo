import QtQuick 2.7
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.5
import QtQuick.Controls.Material 2.1

TabButton {
    id: root
    signal closeTab(var indx);
    property bool closeable: true;
    property int projectIndex: -1;
    contentItem: RowLayout {
        id: row

        Text {
            id: txtLabel
            text: root.text
            font: root.font
            color: "white"

            elide: Text.ElideRight
            Layout.alignment: Qt.AlignHCenter;


        }

        Item {
            width: 25
            height: 25
            Layout.alignment: Qt.AlignRight | Qt.AlignVCenter
            anchors.margins: 5

            Button {
                id: btnClose
                icon.source: "qrc:/images/Icons-filled/close.png"
                anchors.fill: parent
                visible: closeable;
                enabled: closeable;
                flat: true;
                scale: btnMouseArea.containsMouse ? 1.3 : 1;
                icon.color: "transparent";
                onClicked: {
                    root.closeTab(projectIndex);
                }


                Behavior on scale { NumberAnimation { easing.type: Easing.InQuad; duration: 100 }}
            }

            MouseArea {
                id: btnMouseArea;
                anchors.fill: parent;
                hoverEnabled: true;
                cursorShape: Qt.PointingHandCursor

                onClicked: {
                    btnClose.clicked();
                }
            }
        }
    }

    background: Rectangle {
        implicitWidth: 100
        implicitHeight: 35
        opacity: enabled ? 1 : 0.6
        border.color: root.down ? "#17a81a" : "#21be2b"
        border.width: 0
        radius: 0
        color: root.checked ?  "#232a3d" : "#17212b";
    }

    MouseArea {
        anchors.fill: parent;
        anchors.rightMargin: 25;
        acceptedButtons: Qt.AllButtons;
        preventStealing: true;
        onPressed: {
            if(pressedButtons & Qt.MidButton) {
                closeTab(projectIndex);
            }
            if (pressedButtons & Qt.LeftButton) {
                root.checked = true;
            }
        }
    }
}
