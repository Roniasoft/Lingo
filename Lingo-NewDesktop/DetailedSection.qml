import QtQuick 2.0
import QtQuick.Controls 2.3

Rectangle {
    width: 635
    height: 205
//        color: "#17212b"
    color: "white";
    clip: true;

    Row {
        id: rowProjectTitle;
        x: 5
        spacing: 43;
        y: 41
        height: 40;

        Text {
            id: txtProjectTitle
            text: qsTr("Name:")
            color: "#2b5278";
            anchors.verticalCenter: parent.verticalCenter;
        }


        Rectangle {
            id: rectProjectTitle;
            width: 225;
            height: 35;
            color: "#2b5278";
            border.color: "white";
            border.width: 1;
            anchors.verticalCenter: parent.verticalCenter;

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
        x: 8
        y: 94
        width: 294
        height: 62
        spacing: 10;

        Text {
            id: txtProjectDesc
            text: qsTr("Description:")
            color: "#2b5278";
        }

        Rectangle {
            width: 225;
            height: 60
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

    FlatButton {
        id: btnSaveNewProject;
        y: 164
        height: 33
        anchors.horizontalCenterOffset: 218
        labelString: "Save Project";
        anchors.horizontalCenter: parent.horizontalCenter;
        labelIcon: "qrc:/images/Icons/SaveH.png";
        labelIconHovered: "qrc:/images/Icons/SaveH.png";
        KeyNavigation.tab: txtEditProjectTitle;
        KeyNavigation.priority: KeyNavigation.BeforeItem
    }

    Row {
        id: rowProjectDesc1
        x: 319
        y: 87
        height: 62
        Text {
            id: txtProjectDesc1
            color: "#2b5278";
            text: qsTr("Description:")
        }

        Rectangle {
            width: 225
            height: 60
            color: "#2b5278"
            TextInput {
                id: txtEditProjectDesc1
                color: "#ffffff"
                anchors.margins: 5
                wrapMode: TextEdit.Wrap
                maximumLength: 368
                anchors.fill: parent
            }
            border.width: 1
            border.color: "#ffffff"
        }
        spacing: 10
    }

    CheckBox {
        id: checkBox
        x: 17
        y: 157
        text: qsTr("Check Box")
    }
}
