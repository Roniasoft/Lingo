import QtQuick 2.12
import QtQuick.Layouts 1.12
import QtQuick.Controls 2.5
import QtQuick.Window 2.12
import QtQuick.Controls.Universal 2.12
import QtQuick.Controls.Material 2.12

SwipeView {
        id: sv
        interactive: false


        Shortcut {
            sequence: "Down"
            onActivated: {
                if (sv.currentItem.listModel.count <= sv.currentItem.listView.currentIndex +1) {
                    return;
                }

                sv.currentItem.listModel.get(sv.currentItem.listView.currentIndex).highlighted = false;
                sv.currentItem.listView.currentIndex = sv.currentItem.listView.currentIndex + 1;
                sv.currentItem.listModel.get(sv.currentItem.listView.currentIndex).highlighted = true;
            }
        }
        Shortcut {
            sequence: "Up"
            onActivated: {
                if (sv.currentItem.listView.currentIndex <= 0) {
                    return;
                }

                sv.currentItem.listModel.get(sv.currentItem.listView.currentIndex).highlighted = false;
                sv.currentItem.listView.currentIndex = sv.currentItem.listView.currentIndex - 1;
                sv.currentItem.listModel.get(sv.currentItem.listView.currentIndex).highlighted = true;
            }
        }
        Shortcut {
            sequences: ["Return", "Enter"]
            onActivated: {
                sv.currentItem.listModel.get(listView.currentIndex).isOpen = !sv.currentItem.listModel.get(sv.currentItem.listView.currentIndex).isOpen;
                if (sv.currentItem.listModel.get(sv.currentItem.listView.currentIndex).isOpen) {
                    if (sv.currentItem.lastOpened != -1) {
                        sv.currentItem.listModel.get(sv.currentItem.lastOpened).isOpen = false;
                        sv.currentItem.listModel.get(sv.currentItem.lastOpened).highlighted = false;
                    }
                    sv.currentItem.lastOpened = listView.currentIndex;
                }
            }
        }
        Shortcut {
            sequence: "escape"
            onActivated: {
                sv.currentItem.listModel.get(sv.currentItem.lastOpened).isOpen = false;
                sv.currentItem.listModel.get(sv.currentItem.listView.currentIndex).isOpen = false;
                sv.currentItem.listModel.get(sv.currentItem.lastOpened).isOpen = false;
                sv.currentItem.listModel.get(sv.currentItem.listView.currentIndex).highlighted = false;
            }
        }
        Shortcut {
            id: shortcutTab;
            sequence: "Tab"
            //context: Qt.ApplicationShortcut
            onActivated: {
                if (sv.currentItem.listModel.count <= sv.currentItem.listView.currentIndex+1) {
                    return;
                }

                if (sv.currentItem.lastOpened != -1) {
                    sv.currentItem.listModel.get(sv.currentItem.lastOpened).isOpen = false;
                    sv.currentItem.listModel.get(sv.currentItem.lastOpened).highlighted = false;
                }
                sv.currentItem.listModel.get(sv.currentItem.listView.currentIndex).isOpen = false;
                sv.currentItem.listView.currentIndex = sv.currentItem.listView.currentIndex + 1;
                sv.currentItem.listModel.get(sv.currentItem.listView.currentIndex).isOpen = true;
                sv.currentItem.lastOpened = sv.currentItem.listView.currentIndex;
            }
        }
        Shortcut {
            sequence: "Shift+Tab"
            onActivated: {
                if (sv.currentItem.listView.currentIndex <= 0) {
                    return;
                }

                if (sv.currentItem.lastOpened != -1) {
                    sv.currentItem.listModel.get(sv.currentItem.lastOpened).isOpen = false;
                    sv.currentItem.listModel.get(sv.currentItem.lastOpened).highlighted = false;
                }
                sv.currentItem.listModel.get(sv.currentItem.listView.currentIndex).isOpen = false;
                sv.currentItem.listView.currentIndex = sv.currentItem.listView.currentIndex - 1;
                sv.currentItem.listModel.get(sv.currentItem.listView.currentIndex).isOpen = true;
                sv.currentItem.lastOpened = sv.currentItem.listView.currentIndex;
            }
        }
        Shortcut {
            sequences: ["Ctrl+Return", "Ctrl+Enter"]
            onActivated: {
                sv.currentItem.listModel.get(sv.currentItem.listView.currentIndex).completed = !sv.currentItem.listModel.get(sv.currentItem.listView.currentIndex).completed;
            }
        }
        Shortcut {
            sequence: "Ctrl+Del"
            onActivated: {
                sv.currentItem.listModel.get(sv.currentItem.listView.currentIndex).completed = false;
            }
        }
    }