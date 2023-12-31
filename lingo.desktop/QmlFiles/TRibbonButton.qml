import QtQuick 2.7
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.5
import QtQuick.Controls.Material 2.1
import FramelessWindow 1.0

Rectangle {
    radius: 3;
    property bool tooltipOnBottom: true;


    color: checkable ? (checked ? "#364451" : (mouseArea.containsMouse ? "#253646" : "transparent")) :
                       (mouseArea.pressed ? "#364451" : (mouseArea.containsMouse ? "#253646" : "transparent"));

    property string imgSource;
    property string imgSourceHovered;
    property bool checkable: false;
    property bool checked: false;
    property string tooltipStr: "Tooltip"
    property int tooltipBottomMargin: 5;
    property real tooltipOpacity: 0.8;
    property bool tooltipVisible: true;
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
        height: 25 * scaleFactor;
        y: tooltipOnBottom ? parent.height + tooltipBottomMargin : -tooltipRect.height - 0;
        visible: mouseArea.containsMouse & tooltipVisible;
        color: "#0e1621";
        border.color: "white"
        opacity: tooltipOpacity;

        Text {
            id: tooltipText
            text: tooltipStr;
            anchors.verticalCenter: parent.verticalCenter;
            anchors.horizontalCenter: parent.horizontalCenter;
            color: "white";
            font.pixelSize: fontSize + 2;
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
