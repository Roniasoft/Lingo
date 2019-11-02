import QtQuick 2.0

Rectangle {
    id: flatButton
    width: 155
    height: 35
    border.width: 0
    border.color: "#888"
    radius: 0
    color: maFlatButton.containsMouse ? "#3476ab" : "#2f6ea5";

    property string labelString: "New Button"
    property string labelIcon
    property string labelIconHovered
    signal buttonClicked();

    Row {
        id: buttonRow;
        spacing: 10;
        anchors.horizontalCenter: parent.horizontalCenter;
        anchors.verticalCenter: parent.verticalCenter;
        Image {
            id: iconImg;
            source: (maFlatButton.containsMouse ? labelIconHovered : labelIcon);
            width: 16;
            fillMode: Image.PreserveAspectFit;
            anchors.verticalCenter: labelTxt.verticalCenter
        }
        Text {
            id: labelTxt;
            text: labelString
            font.pixelSize: 15;
            font.bold: false;
            color: "white";
            font.family: "Open Sans"
            font.underline: flatButton.focus
        }
    }

    MouseArea {
        id: maFlatButton
        anchors.fill: parent;
        hoverEnabled: true;
        cursorShape: Qt.PointingHandCursor;
        onClicked: buttonClicked();
    }
}
