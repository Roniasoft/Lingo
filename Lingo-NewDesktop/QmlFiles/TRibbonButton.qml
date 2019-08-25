import QtQuick 2.0

Rectangle {
    height: 35;
    width: 35;
    color: checkable ? (checked ? "#364451" : (mouseArea.containsMouse ? "#253646" : "transparent")) :
                       (mouseArea.pressed ? "#364451" : (mouseArea.containsMouse ? "#253646" : "transparent"));
    property string imgSource;
    property string imgSourceHovered;
    property bool checkable: false;
    property bool checked: false;
    signal buttonClicked();
    radius: 3;

    Image {
        id: imgOpenFileToolbar
        source: mouseArea.containsMouse ? pathCRDepth1(imgSourceHovered) : pathCRDepth1(imgSource)
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
            checked = !checked;
            buttonClicked();
        }
    }
}
