import QtQuick 2.8
import QtQuick.Controls 1.4
import QtQuick.Controls 2.0
import QtQuick.VirtualKeyboard 2.0
import QtQuick.Extras 1.4

Popup {
    id: control;
    width: (txtMessage.implicitWidth + 20) < 200 ? 200 : txtMessage.implicitWidth + 20;
    height: 150        
    background: Rectangle {
        color: "#17212B";
        border.color: "#6C7883";
    }
    closePolicy: Popup.NoAutoClose;

    property string msg;
    signal refreshRequested();

    Text {
        id: txtMessage;
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.top: parent.top;
        anchors.topMargin: 20;
        font.pixelSize: fontSize;
        text: msg;
        color: "white";
    }

    Row {
        anchors.horizontalCenter: parent.horizontalCenter
        anchors.bottom: parent.bottom;
        anchors.bottomMargin: scaleFactor * 5;
        spacing: 10;

        Button {
            id: btnExitApp;
            width: 70 * scaleFactor
            height: 40 * scaleFactor
            text: qsTr("Exit App")
            font.pixelSize: fontSize;
            onClicked: {
                Qt.quit();
            }
        }

        Button {
            id: btnRefresh;
            width: 70 * scaleFactor
            height: 40 * scaleFactor
            text: qsTr("Refresh")
            font.pixelSize: fontSize;
            onClicked: {
                refreshRequested();
            }
        }
    }
}