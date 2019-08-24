import QtQuick 2.0

Rectangle {
    height: 35;
    width: 35;
    color: mouseArea.pressed ? "#364451" :
                               (mouseArea.containsMouse ? "#253646" : "transparent");
    property string imgSource;
    property string imgSourceHovered;
    signal buttonClicked();
    radius: 3;

    Image {
        id: imgOpenFileToolbar
        source: mouseArea.containsMouse ? imgSourceHovered : imgSource
        fillMode: Image.PreserveAspectFit;
        height: parent.height * 0.7;
        anchors.verticalCenter: parent.verticalCenter;
        anchors.horizontalCenter: parent.horizontalCenter;
    }

    MouseArea {
        id: mouseArea;
        anchors.fill: parent;
        hoverEnabled: true;
        cursorShape: Qt.PointingHandCursor
        onClicked: {
            buttonClicked();
        }
    }
}
