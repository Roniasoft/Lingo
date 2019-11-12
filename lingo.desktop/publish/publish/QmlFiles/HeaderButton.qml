import QtQuick 2.9
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.5
import QtQuick.Controls.Material 2.1
import QtQuick.Controls.Styles 1.4

Rectangle {
    id: control;
    color: mouseArea.containsMouse ? "#2B3741" : "#364451";
    property bool isAscending: true;
    property bool sortEnabled: false;
    property bool sortIsActive: false;
    property string title: "Name";

    signal headerClicked();

    Row {
        anchors.verticalCenter: parent.verticalCenter;
        anchors.horizontalCenter: parent.horizontalCenter
        spacing: 20;

        Text {
            id: txtLabel
            text: title;
            color: "white";
            font.pixelSize: fontSize - 2;
            anchors.verticalCenter: parent.verticalCenter;
        }
        Image {
            id: imgSortName;
            source: mouseArea.containsMouse ? (isAscending ? "../images/Icons/White/Ascending.png" : "../images/Icons/White/Descending.png") :
                            (isAscending ? "../images/Icons/Grey/Ascending.png" : "../images/Icons/Grey/Descending.png");
            visible: sortIsActive;
            fillMode: Image.PreserveAspectFit
            height: sortIsActive ? 15 : 0;
        }
    }
    MouseArea {
        id: mouseArea;
        anchors.fill: parent;
        enabled: sortEnabled;
        hoverEnabled: sortEnabled;
        cursorShape: Qt.PointingHandCursor;
        onClicked: headerClicked();
    }
}