import QtQuick 2.12
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.5
import QtQuick.Controls.Material 2.1
import QtQuick.Controls.Styles 1.4


Rectangle {
    color: "#17212b";
    border.color: "#6f8398"
    border.width: 0;
    property alias txtEdit: txtEdit
    property bool isReadOnly: true;
    property int selectStart
    property int selectEnd
    property int curPos
    width: 300;
    height: 75

    Flickable {
        id: flick;
        width: parent.width;
        height: parent.height;

        contentWidth: txtEdit.paintedWidth
        contentHeight: txtEdit.paintedHeight
        clip: true

        ScrollBar.vertical: ScrollBar{}
        ScrollBar.horizontal: ScrollBar{}


        function ensureVisible(r)
        {
            if (contentX >= r.x)
                contentX = r.x;
            else if (contentX+width <= r.x+r.width)
                contentX = r.x+r.width-width;
            if (contentY >= r.y)
                contentY = r.y;
            else if (contentY+height <= r.y+r.height)
                contentY = r.y+r.height-height;
        }

        TextEdit {
            id: txtEdit;
            width: flick.width;
            anchors.margins: 5;
            wrapMode: TextEdit.Wrap;
            color: "white"
            selectedTextColor: "white";
            selectionColor: "#3399ff"
            clip: true;
            readOnly: isReadOnly;
            selectByMouse: true;
            font.pixelSize: fontSize;
            inputMethodHints: Qt.ImhMultiLine;
            onCursorRectangleChanged: flick.ensureVisible(cursorRectangle)
//            Keys.onPressed: {
//                if ( event.key === Qt.Key_Tab ) {
//                    txtEdit.focus = false;
//                    event.accepted = true;
//                } else {
//                    event.accepted = false
//                }
//            }

            Keys.onTabPressed: {
                event.accepted = true;
                txtEdit.focus = false;
                listView.tabIsPressedInTextEdit();
            }

            MouseArea {
                anchors.fill: parent
                acceptedButtons: Qt.RightButton
                cursorShape: isReadOnly ? Qt.ArrowCursor : Qt.IBeamCursor;
                hoverEnabled: true
                enabled: false;
//                onClicked: {
//                    selectStart = txtEdit.selectionStart;
//                    selectEnd = txtEdit.selectionEnd;
//                    curPos = txtEdit.cursorPosition;
//                    contextMenu.x = mouse.x;
//                    contextMenu.y = mouse.y;
//                    contextMenu.open();
//                    txtEdit.cursorPosition = curPos;
//                    txtEdit.select(selectStart,selectEnd);
//                }
//                onPressAndHold: {
//                    if (mouse.source === Qt.MouseEventNotSynthesized) {
//                        selectStart = txtEdit.selectionStart;
//                        selectEnd = txtEdit.selectionEnd;
//                        curPos = txtEdit.cursorPosition;
//                        contextMenu.x = mouse.x;
//                        contextMenu.y = mouse.y;
//                        contextMenu.open();
//                        txtEdit.cursorPosition = curPos;
//                        txtEdit.select(selectStart,selectEnd);
//                    }
//                }


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
