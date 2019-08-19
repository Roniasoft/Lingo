import QtQuick 2.0
import QtQuick.Controls 2.3

Rectangle {
    height: 200
    width: 600;
    //        color: "#17212b"
    clip: true;

    Row {
        id: rowProjectTitle;
        x: 5
        spacing: 43;
        y: 41
        height: 40;

    }


    Text {
        id: txtProjectDesc
        x: 11
        y: 39
        text: qsTr("English:")
        color: "#2b5278";
    }

    Rectangle {
        x: 302
        y: 56
        width: 290
        height: 75
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

    FlatButton {
        id: btnSaveNewProject;
        y: 8
        width: 111
        height: 33
        anchors.horizontalCenterOffset: 237
        labelString: "Save";
        anchors.horizontalCenter: parent.horizontalCenter;
        labelIcon: "qrc:/images/Icons/SaveH.png";
        labelIconHovered: "qrc:/images/Icons/SaveH.png";
        // KeyNavigation.tab: txtEditProjectTitle;
        KeyNavigation.priority: KeyNavigation.BeforeItem
    }
    Text {
        id: txtProjectDesc1
        x: 302
        y: 39
        color: "#2b5278";
        text: qsTr("Translation:")
    }

    Rectangle {
        x: 8
        y: 56
        width: 290
        height: 75
        color: "#2b5278"
        TextInput {
            id: txtEditProjectDesc1
            width: 225
            color: "#ffffff"
            anchors.margins: 5
            wrapMode: TextEdit.Wrap
            maximumLength: 368
            anchors.fill: parent
        }
        border.width: 1
        border.color: "#ffffff"
    }

    CheckBox {
        id: checkBox
        x: 376
        y: 5
        text: qsTr("Completed")
    }
    Text {
        id: txtProjectDesc2
        x: 11
        y: 136
        color: "#2b5278"
        text: qsTr("Comment:")
    }

    Rectangle {
        x: 8
        y: 152
        width: 270
        height: 40
        color: "#2b5278"
        border.width: 1
        TextInput {
            id: txtEditProjectDesc2
            color: "#ffffff"
            anchors.fill: parent
            anchors.margins: 5
            wrapMode: TextEdit.Wrap
            maximumLength: 368
        }
        border.color: "#ffffff"
    }
}
