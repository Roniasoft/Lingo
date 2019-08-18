import QtQuick 2.0
import QtQuick.Controls 2.5
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.5
import QtQuick.Controls.Material 2.1

Dialog {
    id: root;
//    color: "#17212b";
    title: "Settings"
    modal: true;
    width: 400
    height: 600
    clip: false
    dim: true

    Material.theme: Material.Dark
    Material.accent: '#17212b'
    Material.primary: '#17212b'

    signal option1DialogReq();
    signal option2DialogReq();


    header: Rectangle {
        color: "#17212b";
        height: 50;
        width: parent.width;

        Text {
            id: txtTitle
            text: root.title;
            anchors.left: parent.left;
            anchors.leftMargin: 20;
            color: "white";
            anchors.verticalCenter: parent.verticalCenter;
            font.pixelSize: 15;
            font.bold: true;
        }

        Image {
            id: imgClose
            source: maClose.containsMouse ? "qrc:/images/Icons-filled/closeHovered.png" :
                                            "qrc:/images/Icons-filled/close.png"
            width: 16;
            fillMode: Image.PreserveAspectFit
            anchors.verticalCenter: parent.verticalCenter;
            anchors.right: parent.right;
            anchors.rightMargin: 20;

            MouseArea {
                id:  maClose;
                anchors.fill: parent;
                hoverEnabled: true;
                cursorShape: Qt.PointingHandCursor;
                onClicked: root.close();
            }
        }

        Image {
            id: imgSettings
            source: "qrc:/images/Icons-filled/Settings.png"
            width: 16;
            fillMode: Image.PreserveAspectFit
            anchors.verticalCenter: parent.verticalCenter;
            anchors.right: imgClose.left;
            anchors.rightMargin: 10;
        }
    }

    background: Rectangle {
        color:'#17212b'

        Rectangle {
            id: rectSep1;
            color: "#212d3b";
            height: 10;
            width: parent.width;
            y: 150;
        }


        HighlightButton {
            id: row1;
            anchors.left: parent.left;
            anchors.top: rectSep1.bottom;
            anchors.topMargin: 20;
            height: 44;
            width: parent.width;

            iconHoveredSrc: "qrc:/images/Icons-filled/EditHovered.png"
            iconSrc: "qrc:/images/Icons-filled/Edit.png"
            labelString: "Option 1";

            onButtonClicked: {
                option1DialogReq();
            }
        }


        HighlightButton {
            id: row2;
            anchors.left: parent.left;
            anchors.top: row1.bottom;
            anchors.topMargin: 0;
            height: 44;
            width: parent.width;

            iconHoveredSrc: "qrc:/images/Icons-filled/NotificationsHovered.png"
            iconSrc: "qrc:/images/Icons-filled/Notifications.png"
            labelString: "Option 2";

            onButtonClicked: {
                option2DialogReq();
            }
        }

        Rectangle {
            color: "#212d3b";
            height: 10;
            width: parent.width;
            y: 450;
        }
    }
}
