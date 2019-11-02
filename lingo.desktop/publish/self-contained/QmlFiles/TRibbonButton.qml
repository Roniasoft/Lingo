import QtQuick 2.7
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.5
import QtQuick.Controls.Material 2.1
import FramelessWindow 1.0

Rectangle {
    height: 35;
    width: 35;
    radius: 3;
    color: checkable ? (checked ? "#364451" : (mouseArea.containsMouse ? "#253646" : "transparent")) :
                       (mouseArea.pressed ? "#364451" : (mouseArea.containsMouse ? "#253646" : "transparent"));

    property string imgSource;
    property string imgSourceHovered;
    property bool checkable: false;
    property bool checked: false;
    property string tooltipStr: "Tooltip"
    signal buttonClicked();

    Image {
        id: imgOpenFileToolbar
        source: mouseArea.containsMouse ? (imgSourceHovered) : (imgSource)
        fillMode: Image.PreserveAspectFit;
        height: parent.height * 0.7;
        anchors.verticalCenter: parent.verticalCenter;
        anchors.horizontalCenter: parent.horizontalCenter;
    }

    Rectangle {
        id: tooltipRect;
        implicitWidth: tooltipText.width + 12;
        height: 25;
        anchors.top: parent.bottom;
        anchors.topMargin: 8;
        visible: mouseArea.containsMouse;
        color: "#0e1621";
        border.color: "white"
        opacity: 0.8;


        Text {
            id: tooltipText
            text: tooltipStr;
            anchors.verticalCenter: parent.verticalCenter;
            anchors.horizontalCenter: parent.horizontalCenter;
            color: "white";
            font.pixelSize: 13;
        }
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
