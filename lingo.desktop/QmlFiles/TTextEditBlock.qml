import QtQuick 2.12
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.5
import QtQuick.Controls.Material 2.1
import QtQuick.Controls.Styles 1.4

Rectangle {
    id: control;
    color: isReadOnly ? "#1e2937" : "#17212b";
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
        anchors.fill: parent;
        contentWidth: txtEdit.paintedWidth;
        contentHeight: txtEdit.paintedHeight;
        clip: true
        anchors.margins: 5;

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
            //anchors.margins: 5;
            // height: 70;
            height: 250 * scaleFactor;
            wrapMode: TextEdit.Wrap;
            color: isReadOnly ? "#cecece" : "white"
            selectedTextColor: "white";
            selectionColor: "#3399ff"
            // clip: true;
            readOnly: isReadOnly;
            selectByMouse: true;
            font.pixelSize: fontSize;
           // contentHeight: 100 * scaleFactor;
            // inputMethodHints: Qt.ImhMultiLine;
            // focus: true;
            activeFocusOnPress: true;
            onCursorRectangleChanged: flick.ensureVisible(cursorRectangle)

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
