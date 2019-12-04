import QtQuick 2.12
import QtQuick.Layouts 1.12
import QtQuick.Controls 2.5
import QtQuick.Window 2.12
import QtQuick.Controls.Universal 2.12
import QtQuick.Controls.Material 2.12

StackLayout {
        id: sv
        // property var currentItem: sv.children[sv.currentIndex];
        // property var listView: sv.children[sv.currentIndex].listView;
        // property var proxyModel: sv.children[sv.currentIndex].proxyModel;
        // property var lastOpened: sv.children[sv.currentIndex].lastOpened;

        Shortcut {
            sequences: ["Return", "Enter"]
            onActivated: {
                if (sv.children[sv.currentIndex].lastOpened != -1) {
                    sv.children[sv.currentIndex].proxyModel.set(sv.children[sv.currentIndex].lastOpened, "isOpen", false);
                }
                sv.children[sv.currentIndex].proxyModel.set(sv.children[sv.currentIndex].listView.currentIndex, "isOpen", !sv.children[sv.currentIndex].proxyModel.get(sv.children[sv.currentIndex].listView.currentIndex).isOpen);
                if (sv.children[sv.currentIndex].proxyModel.get(sv.children[sv.currentIndex].listView.currentIndex).isOpen) {
                    sv.children[sv.currentIndex].lastOpened = sv.children[sv.currentIndex].listView.currentIndex;
                } else {
                    sv.children[sv.currentIndex].lastOpened = -1;
                }
            }
        }

        Shortcut {
            sequence: "escape"
            onActivated: {
                sv.children[sv.currentIndex].proxyModel.set(sv.children[sv.currentIndex].lastOpened, "isOpen", false);
                sv.children[sv.currentIndex].proxyModel.set(sv.children[sv.currentIndex].listView.currentIndex, "isOpen", false);
                sv.children[sv.currentIndex].proxyModel.set(sv.children[sv.currentIndex].lastOpened, "isOpen", false);
            }
        }

        Shortcut {
            id: shortcutTab;
            sequence: "Tab"
            onActivated: {
                if (sv.children[sv.currentIndex].proxyModel.count <= sv.children[sv.currentIndex].listView.currentIndex+1) {
                    return;
                }
                if (sv.children[sv.currentIndex].lastOpened != -1) {
                    sv.children[sv.currentIndex].proxyModel.set(sv.children[sv.currentIndex].lastOpened, "isOpen", false);
                }
                if (sv.children[sv.currentIndex].proxyModel.get(sv.children[sv.currentIndex].listView.currentIndex).isOpen) {
                    sv.children[sv.currentIndex].proxyModel.set(sv.children[sv.currentIndex].listView.currentIndex, "isOpen", false);
                    sv.children[sv.currentIndex].listView.currentIndex = sv.children[sv.currentIndex].listView.currentIndex + 1; 
                }
                sv.children[sv.currentIndex].proxyModel.set(sv.children[sv.currentIndex].listView.currentIndex, "isOpen", true);
                sv.children[sv.currentIndex].lastOpened = sv.children[sv.currentIndex].listView.currentIndex;
            }
        }

        Shortcut {
            sequence: "Shift+Tab"
            onActivated: {
                if (sv.children[sv.currentIndex].listView.currentIndex <= 0) {
                    return;
                }
                if (sv.children[sv.currentIndex].lastOpened != -1) {
                    sv.children[sv.currentIndex].proxyModel.set(sv.children[sv.currentIndex].lastOpened, "isOpen", false);
                }
                sv.children[sv.currentIndex].proxyModel.set(sv.children[sv.currentIndex].listView.currentIndex, "isOpen", false);
                sv.children[sv.currentIndex].listView.currentIndex = sv.children[sv.currentIndex].listView.currentIndex - 1;
                sv.children[sv.currentIndex].proxyModel.set(sv.children[sv.currentIndex].listView.currentIndex, "isOpen", true);
                sv.children[sv.currentIndex].lastOpened = sv.children[sv.currentIndex].listView.currentIndex;
            }
        }

        Shortcut {
            sequences: ["Ctrl+Return", "Ctrl+Enter"]
            onActivated: {
                sv.children[sv.currentIndex].proxyModel.set(sv.children[sv.currentIndex].listView.currentIndex, "completed", !sv.children[sv.currentIndex].proxyModel.get(sv.children[sv.currentIndex].listView.currentIndex).completed);
            }
        }
        
        Shortcut {
            sequence: "Ctrl+Del"
            onActivated: {
                sv.children[sv.currentIndex].proxyModel.set(sv.children[sv.currentIndex].listView.currentIndex, "completed", false);
            }
        }
    }