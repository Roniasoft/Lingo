import QtQuick 2.0

Rectangle {
    id: highlightButton;
    height: 44;
    color: maOption1.containsMouse ? "#232e3c" : parent.color;
    property string iconSrc
    property string iconHoveredSrc
    property string labelString : "option";

    signal buttonClicked();

    Image {
        id: imgOption1
        source: maOption1.containsMouse ? iconHoveredSrc : iconSrc
        width: 20;
        fillMode: Image.PreserveAspectFit;
        anchors.verticalCenter: parent.verticalCenter;
        anchors.left: parent.left;
        anchors.leftMargin: 20;
    }

    Text {
        id: txtOption1
        text: labelString;
        color: "#ebf5f7";
        font.pixelSize: 15;
        anchors.verticalCenter: imgOption1.verticalCenter
        font.family: "open sans"
        anchors.left: imgOption1.right;
        anchors.leftMargin: 25;
    }

    MouseArea {
        id: maOption1;
        anchors.fill: parent;
        hoverEnabled: true;
        cursorShape: Qt.PointingHandCursor;
        onClicked: {
            buttonClicked();
        }
    }
}
