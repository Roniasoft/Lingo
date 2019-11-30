import QtQuick 2.12
import QtQuick.Layouts 1.12
import QtQuick.Controls 2.5
import QtQuick.Window 2.12
import QtQuick.Controls.Universal 2.12
import QtQuick.Controls.Material 2.12

StackLayout {
        id: sv
        property var currentItem: sv.children[sv.currentIndex];
        property var listView: currentItem.listView;
        property var proxyModel: currentItem.proxyModel;
        property var lastOpened: currentItem.lastOpened;

        Shortcut {
            sequences: ["Return", "Enter"]
            onActivated: {
                sv.proxyModel.set(sv.listView.currentIndex, "isOpen", !sv.proxyModel.get(sv.listView.currentIndex).isOpen);
                if (sv.proxyModel.get(sv.listView.currentIndex).isOpen) {
                    if (sv.lastOpened != -1) {
                        sv.proxyModel.set(sv.lastOpened, "isOpen", false);
                    }
                    sv.lastOpened = sv.listView.currentIndex;
                }
            }
        }

        Shortcut {
            sequence: "escape"
            onActivated: {
                sv.proxyModel.set(sv.lastOpened, "isOpen", false);
                sv.proxyModel.set(sv.listView.currentIndex, "isOpen", false);
                sv.proxyModel.set(sv.lastOpened, "isOpen", false);
            }
        }

        Shortcut {
            id: shortcutTab;
            sequence: "Tab"
            onActivated: {
                if (sv.proxyModel.count <= sv.listView.currentIndex+1) {
                    return;
                }
                if (sv.lastOpened != -1) {
                    sv.proxyModel.set(sv.lastOpened, "isOpen", false);
                }
                if (sv.proxyModel.get(sv.listView.currentIndex).isOpen) {
                    sv.proxyModel.set(sv.listView.currentIndex, "isOpen", false);
                    sv.listView.currentIndex = sv.listView.currentIndex + 1; 
                }
                sv.proxyModel.set(sv.listView.currentIndex, "isOpen", true);
                sv.lastOpened = sv.listView.currentIndex;
            }
        }

        Shortcut {
            sequence: "Shift+Tab"
            onActivated: {
                if (sv.listView.currentIndex <= 0) {
                    return;
                }
                if (sv.lastOpened != -1) {
                    sv.proxyModel.set(sv.lastOpened, "isOpen", false);
                    // sv.proxyModel.set(sv.lastOpened, "highlighted", false);
                }
                sv.proxyModel.set(sv.listView.currentIndex, "isOpen", false);
                sv.listView.currentIndex = sv.listView.currentIndex - 1;
                sv.proxyModel.set(sv.listView.currentIndex, "isOpen", true);
                sv.lastOpened = sv.listView.currentIndex;
            }
        }

        Shortcut {
            sequences: ["Ctrl+Return", "Ctrl+Enter"]
            onActivated: {
                sv.proxyModel.set(sv.listView.currentIndex, "completed", !sv.proxyModel.get(sv.listView.currentIndex).completed);
            }
        }
        
        Shortcut {
            sequence: "Ctrl+Del"
            onActivated: {
                sv.proxyModel.set(sv.listView.currentIndex, "completed", false);
            }
        }
    }