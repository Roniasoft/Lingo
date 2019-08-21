import QtQuick 2.0
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.3

Rectangle {
    height: 200
    property alias txtEditComment: txtEditComment
    property alias txtEditTranslation: txtEditTranslation
    property alias txtEditEng: txtEditEng
    property alias btnSave: btnSave
    width: 600;
    //        color: "#17212b"
    clip: true;

    Rectangle {
        color: "#253646";
        width: parent.width;
        height: 36;
    }

    FlatButton {
        id: btnSave;
        x: 495
        y: 4
        width: 95
        height: 28
        anchors.rightMargin: 0
        labelString: "Save";
        labelIcon: "qrc:/images/Icons/SaveH.png";
        labelIconHovered: "qrc:/images/Icons/SaveH.png";
        // KeyNavigation.tab: txtEditProjectTitle;
        KeyNavigation.priority: KeyNavigation.BeforeItem
        anchors.right: rowLayout.right;
    }

    RowLayout {
        id: rowLayout;
        anchors.left: parent.left;
        anchors.right: parent.right;
        anchors.leftMargin: 10;
        anchors.rightMargin: 10;

        y: 40;
        Column {
//            Layout.preferredWidth: rowLayout.width * 0.49;
            Layout.fillWidth: true;
            Layout.preferredWidth: 290;
            Text {
                id: txtProjectDesc
                text: qsTr("English:")
                color: "#2b5278";
            }

            Rectangle {
                width: parent.width;
                height: 75
                color: "white";
                border.color: "#2b5278"
                border.width: 1;
                TextInput {
                    id: txtEditEng;
                    anchors.fill: parent;
                    anchors.margins: 5;
                    wrapMode: TextEdit.Wrap;
                    color: "#2b5278"
                    KeyNavigation.tab: btnSave;
                    KeyNavigation.priority: KeyNavigation.BeforeItem
                    maximumLength: 150;
                    clip: true;
                }
            }
        }

        Column {
//            Layout.preferredWidth: rowLayout.width * 0.49;
            Layout.fillWidth: true;
            Layout.preferredWidth: 290;
            Text {
                id: txtProjectDesc1
                color: "#2b5278";
                text: qsTr("Translation:")
            }

            Rectangle {
                width: parent.width;
                height: 75
                color: "white";
                border.color: "#2b5278"
                TextInput {
                    id: txtEditTranslation
                    color: "#2b5278"
                    anchors.margins: 5
                    wrapMode: TextEdit.Wrap
                    maximumLength: 150
                    anchors.fill: parent
                    clip: true;
                }
                border.width: 1
            }
        }
    }


    Column {
        width: rowLayout.width * 0.49;
        x: 11
        y: 136
        Text {
            id: txtProjectDesc2
            color: "#2b5278"
            text: qsTr("Comment:")
        }

        Rectangle {
            width: rowLayout.width * 0.49;
            height: 40
            border.width: 1
            radius: 0;
            color: "white";
            border.color: "#2b5278"
            TextInput {
                id: txtEditComment
                color: "#2b5278"
                anchors.fill: parent
                anchors.margins: 5
                wrapMode: TextEdit.Wrap
                maximumLength: 100
                clip: true;
            }
        }
    }
}
