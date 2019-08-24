import QtQuick 2.0


Rectangle {
    width: 300;
    height: 75
    color: "#17212b";
    border.color: "#6f8398"
    border.width: 0;

    property alias txtEdit: txtEdit
    property bool isReadOnly: true;

    TextInput {
        id: txtEdit;
        anchors.fill: parent;
        anchors.margins: 5;
        wrapMode: TextEdit.Wrap;
        color: "white"
        KeyNavigation.priority: KeyNavigation.BeforeItem
        maximumLength: 150;
        clip: true;
        readOnly: isReadOnly;
    }

    Rectangle {
        height: 2;
        anchors.bottom: parent.bottom;
        anchors.horizontalCenter: parent.horizontalCenter;
        width: txtEdit.focus ? parent.width - 2 : 0;
        color: "#6396cb";
        Behavior on width {
            NumberAnimation {
                duration: 150
            }
        }
    }
}
