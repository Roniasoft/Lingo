import QtQuick 2.9
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.5
import QtQuick.Controls.Material 2.1
import QtQuick.Controls.Styles 1.4


Rectangle {
    width: 300;
    height: 75
    color: "#17212b";
    border.color: "#6f8398"
    border.width: 0;

    property alias txtEdit: txtEdit
    property bool isReadOnly: true;
    property int selectStart
    property int selectEnd
    property int curPos

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
        selectByMouse: true;

        MouseArea {
            anchors.fill: parent
            acceptedButtons: Qt.RightButton
            hoverEnabled: true
            enabled: false;
            onClicked: {
                selectStart = txtEdit.selectionStart;
                selectEnd = txtEdit.selectionEnd;
                curPos = txtEdit.cursorPosition;
                contextMenu.x = mouse.x;
                contextMenu.y = mouse.y;
                contextMenu.open();
                txtEdit.cursorPosition = curPos;
                txtEdit.select(selectStart,selectEnd);
            }
            onPressAndHold: {
                if (mouse.source === Qt.MouseEventNotSynthesized) {
                    selectStart = txtEdit.selectionStart;
                    selectEnd = txtEdit.selectionEnd;
                    curPos = txtEdit.cursorPosition;
                    contextMenu.x = mouse.x;
                    contextMenu.y = mouse.y;
                    contextMenu.open();
                    txtEdit.cursorPosition = curPos;
                    txtEdit.select(selectStart,selectEnd);
                }
            }
        }

        Menu {
            id: contextMenu
            MenuItem {
                text: "Cut"
                onTriggered: {
                    txtEdit.cut()
                }
            }
            MenuItem {
                text: "Copy"
                onTriggered: {
                    txtEdit.copy()
                }
            }
            MenuItem {
                text: "Paste"
                onTriggered: {
                    txtEdit.paste()
                }
            }
        }
    }

    Rectangle {
        height: 2;
        anchors.bottom: parent.bottom;
        anchors.horizontalCenter: parent.horizontalCenter;
        width: txtEdit.focus ? parent.width - 2 : 0;
        color: "#6396cb";
        visible: !isReadOnly;
        Behavior on width {
            NumberAnimation {
                duration: 250
            }
        }
    }
}
