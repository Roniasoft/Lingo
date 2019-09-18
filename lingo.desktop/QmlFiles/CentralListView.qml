﻿import QtQuick 2.9
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.5
import QtQuick.Controls.Material 2.1
import QtQuick.Controls.Styles 1.4

Rectangle {
    id: control;
    color: "#0e1621";
    property int lastOpened: -1;
    property var phraseModel;
    property var phraseViewModel;
    signal openRequested(var projName, var projDetail, var index);
    signal closeRequested(var index);
    signal itemDeleted();

    function setPhraseViewModel(pModel) {
        control.phraseViewModel = pModel;
    }

    Rectangle {
        id: header;
        anchors.top: parent.top;
        anchors.topMargin: 15;
        anchors.left: listView.left;
        anchors.right: listView.right;
        color: "#364451";
        height: 30;

        RowLayout {
            id: rowTableHeader;
            anchors.fill: parent;
            anchors.leftMargin: 20;
            anchors.rightMargin: 0;
            anchors.verticalCenter: parent.verticalCenter;
            spacing: 10;

            Text {
                id: txtHeaderName
                text: qsTr("Name");
                color: "white";
                Layout.preferredWidth: 70;
                font.pixelSize: fontSize - 2;
            }
            Text {
                id: txtHeaderEnglish
                text: qsTr("English");
                color: "white";
                Layout.preferredWidth: 70
                font.pixelSize: fontSize - 2;
            }
            Text {
                id: txtHeaderTranslation
                text: qsTr("Translation");
                color: "white";
                Layout.preferredWidth: 70;
                font.pixelSize: fontSize - 2;
            }
        }

        // adjusting the last column header is very difficult in the rowLayout.
        //  so we adjust it manualy
        Text {
            id: txtHeaderIsCompleted
            text: qsTr("Completed");
            color: "white";
            anchors.right: parent.right;
            anchors.rightMargin: 20
            anchors.verticalCenter: parent.verticalCenter;
            font.pixelSize: fontSize - 2;

        }
    }

    Component {
        id: delegate;
        ListItemDelegate {
            id: listItemDelegate;
            width: listView.width
            height: modelData.isOpen ? 210 : 36;
            phraseViewModel: control.phraseViewModel;
        }
    }

    ListView {
        id: listView;
        anchors.top: header.bottom;
        anchors.topMargin: 0;
        anchors.left: parent.left;
        anchors.leftMargin: 20;
        anchors.right: parent.right;
        anchors.rightMargin: 20;
        anchors.bottom: parent.bottom;
        anchors.bottomMargin: 5;
        keyNavigationEnabled: true;
        clip: true;
        focus: true
        ScrollBar.vertical:
            ScrollBar {
            opacity: 0.3;
            width: 5;
            }
        ScrollBar.horizontal: ScrollBar{}
//        snapMode: ListView.SnapToItem;
//        interactive: true;
//        highlightRangeMode: ListView.StrictlyEnforceRange;

        function tabIsPressedInTextEdit() {
            // if (listModel.count <= listView.currentIndex+1) {
            //     return;
            // }

            // if (lastOpened != -1) {
            //     listModel.get(lastOpened).isOpen = false;
            //     listModel.get(lastOpened).highlighted = false;
            // }
            // listModel.get(listView.currentIndex).isOpen = false;
            // listView.currentIndex = listView.currentIndex + 1;
            // listModel.get(listView.currentIndex).isOpen = true;
            // lastOpened = listView.currentIndex;
        }

        model: Net.toListModel(control.phraseModel)
        

        
        
        delegate: delegate

        Shortcut {
            sequence: "Down"
            onActivated: {
                if (listModel.count <= listView.currentIndex +1) {
                    return;
                }

                listModel.get(listView.currentIndex).highlighted = false;
                listView.currentIndex = listView.currentIndex + 1;
                listModel.get(listView.currentIndex).highlighted = true;
            }
        }
        Shortcut {
            sequence: "Up"
            onActivated: {
                if (listView.currentIndex <= 0) {
                    return;
                }

                listModel.get(listView.currentIndex).highlighted = false;
                listView.currentIndex = listView.currentIndex - 1;
                listModel.get(listView.currentIndex).highlighted = true;
            }
        }
        Shortcut {
            sequences: ["Return", "Enter"]
            onActivated: {
                listModel.get(listView.currentIndex).isOpen = !listModel.get(listView.currentIndex).isOpen;
                if (listModel.get(listView.currentIndex).isOpen) {
                    if (lastOpened != -1) {
                        listModel.get(lastOpened).isOpen = false;
                        listModel.get(lastOpened).highlighted = false;
                    }
                    lastOpened = listView.currentIndex;
                }
            }
        }
        Shortcut {
            sequence: "escape"
            onActivated: {
                listModel.get(lastOpened).isOpen = false;
                listModel.get(listView.currentIndex).isOpen = false;
                listModel.get(lastOpened).isOpen = false;
                listModel.get(listView.currentIndex).highlighted = false;
            }
        }
        Shortcut {
            id: shortcutTab;
            sequence: "Tab"
            context: Qt.ApplicationShortcut
            onActivated: {
                if (listModel.count <= listView.currentIndex+1) {
                    return;
                }

                if (lastOpened != -1) {
                    listModel.get(lastOpened).isOpen = false;
                    listModel.get(lastOpened).highlighted = false;
                }
                listModel.get(listView.currentIndex).isOpen = false;
                listView.currentIndex = listView.currentIndex + 1;
                listModel.get(listView.currentIndex).isOpen = true;
                lastOpened = listView.currentIndex;
            }
        }
        Shortcut {
            sequence: "Shift+Tab"
            onActivated: {
                if (listView.currentIndex <= 0) {
                    return;
                }

                if (lastOpened != -1) {
                    listModel.get(lastOpened).isOpen = false;
                    listModel.get(lastOpened).highlighted = false;
                }
                listModel.get(listView.currentIndex).isOpen = false;
                listView.currentIndex = listView.currentIndex - 1;
                listModel.get(listView.currentIndex).isOpen = true;
                lastOpened = listView.currentIndex;
            }
        }
        Shortcut {
            sequences: ["Ctrl+Return", "Ctrl+Enter"]
            onActivated: {
                listModel.get(listView.currentIndex).completed = !listModel.get(listView.currentIndex).completed;
            }
        }
        Shortcut {
            sequence: "Ctrl+Del"
            onActivated: {
                listModel.get(listView.currentIndex).completed = false;
            }
        }
    }
}
