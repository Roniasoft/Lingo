import QtQuick 2.7
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.5
import QtQuick.Controls.Material 2.1

Dialog {
    id: newProjectDialog;
    width: 350;
    height: 450;
    title: "New Project"
    modal: true;
    clip: false
    dim: true

    property alias btnSaveNewProject: btnSaveNewProject;
    property alias txtEditProjectTitle: txtEditProjectTitle;
    property alias txtEditProjectDesc: txtEditProjectDesc;

    header: Rectangle {
        color: "#17212b";
        height: 50;
        width: parent.width;


        Text {
            id: txtTitle
            text: newProjectDialog.title;
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
                onClicked: newProjectDialog.close();
            }
        }
    }
    background: Rectangle {
        color: "#17212b"

        Rectangle {
            id: rectSep1;
            color: "#212d3b";
            height: 10;
            width: parent.width;
            y: 50;
        }

        Row {
            id: rowProjectTitle;
            anchors.top: rectSep1.bottom;
            anchors.topMargin: 35;
            anchors.left: parent.left;
            anchors.leftMargin: 20;
            spacing: 43;

            Text {
                id: txtProjectTitle
                text: qsTr("Title:")
                color: "white";
            }

            Rectangle {
                id: rectProjectTitle;
                width: 225;
                height: 35;
                color: "#2b5278";
                border.color: "white";
                border.width: 1;
                anchors.verticalCenter: txtProjectTitle.verticalCenter;
                TextInput {
                    id: txtEditProjectTitle;
                    anchors.verticalCenter: parent.verticalCenter;
                    clip: true;
                    maximumLength: 25;
                    anchors.fill: parent;
                    anchors.margins: 5;
                    wrapMode: TextEdit.NoWrap
                    font.pixelSize: 15;
                    color: "white";
                    KeyNavigation.tab: txtEditProjectDesc;
                    KeyNavigation.priority: KeyNavigation.BeforeItem
                }
            }
        }

        Row {
            id: rowProjectDesc;
            anchors.top: rowProjectTitle.bottom;
            anchors.topMargin: 0;
            anchors.left: parent.left;
            anchors.leftMargin: 20;
            spacing: 10;

            Text {
                id: txtProjectDesc
                text: qsTr("Description:")
                color: "white";
            }

            Rectangle {
                width: 225;
                height: 220;
                color: "#2b5278";
                border.color: "white";
                border.width: 1;
                TextInput {
                    id: txtEditProjectDesc;
                    anchors.fill: parent;
                    anchors.margins: 5;
                    wrapMode: TextEdit.Wrap;
                    color: "white";
                    KeyNavigation.tab: btnSaveNewProject;
                    KeyNavigation.priority: KeyNavigation.BeforeItem
                    maximumLength: 368;
                }
            }
        }

        Rectangle {
            id: rectSep2;
            color: "#212d3b";
            height: 10;
            width: parent.width;
            y: 370;
        }

        FlatButton {
            id: btnSaveNewProject;
            labelString: "Save Project";
            anchors.top: rectSep2.bottom;
            anchors.topMargin: 20;
            anchors.horizontalCenter: parent.horizontalCenter;
            labelIcon: "qrc:/images/Icons/SaveH.png";
            labelIconHovered: "qrc:/images/Icons/SaveH.png";
            KeyNavigation.tab: txtEditProjectTitle;
            KeyNavigation.priority: KeyNavigation.BeforeItem
        }
    }
}
