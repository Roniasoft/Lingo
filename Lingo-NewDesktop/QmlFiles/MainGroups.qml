import QtQuick 2.12
import QtQuick.Controls 2.12
import QtQuick.Controls.Universal 2.12
import QtQuick.Controls.Material 2.12
import QtQuick.Layouts 1.12

Pane {
    id: control
    property var feedViewModel
    property var style
    property int scrollWidth: scrollBar.visible ? scrollBar.width : 0
    signal itemClicked(int projectId)
    signal openProjectRequested(int projectId, string txt, bool isOpen)
    signal switchToProjectRequested(var project)

    Universal.background: style.background
    Material.background: style.background

    ListView {
        id: listView
        focus: true
        currentIndex: -1
        anchors.fill: parent
        clip: true;

        delegate: GroupItemDelegate {
            id: itemDelegate;
            width: parent.width
            style: control.style
            MouseArea {
                anchors.fill: parent
                cursorShape: Qt.PointingHandCursor;
                onClicked: {
                    control.openProjectRequested(project_id, title, isOpen);
                    isOpen = true;
                }
            }
        }
        model: ListModel {
            ListElement {
                project_id: 1;
                title: "Russian"
                isOpen: false;
                text: "";
                summary: "English to Russian Translation!";
                imageURL: "qrc:/images/language_icon.png";
                updateTime: "1979-23-12 12:22:10";
            }
            ListElement {
                project_id: 2;
                title: "French"
                isOpen: false;
                text: "this is english";
                summary: "English to French Translation!";
                imageURL: "qrc:/images/language_icon.png";
                updateTime: "1979-23-12 12:22:10";
            }
            ListElement {
                project_id: 3;
                title: "Arabic"
                isOpen: false;
                text: "this is english";
                summary: "English to Arabic Translation!";
                imageURL: "qrc:/images/language_icon.png";
                updateTime: "1979-23-12 12:22:10";
            }
            ListElement {
                project_id: 4;
                title: "Chinese"
                isOpen: false;
                text: "this is english";
                summary: "English to Chinese Translation!";
                imageURL: "qrc:/images/language_icon.png";
                updateTime: "1979-23-12 12:22:10";
            }
            ListElement {
                project_id: 5;
                title: "Persian (Farsi)"
                isOpen: false;
                text: "this is english";
                summary: "English to Persian Translation!";
                imageURL: "qrc:/images/language_icon.png";
                updateTime: "1979-23-12 12:22:10";
            }
            ListElement {
                project_id: 6;
                title: "Albanian"
                isOpen: false;
                text: "this is english";
                summary: "English to Albanian Translation!";
                imageURL: "qrc:/images/language_icon.png";
                updateTime: "1979-23-12 12:22:10";
            }
            ListElement {
                project_id: 7;
                title: "Czech"
                isOpen: false;
                text: "this is english";
                summary: "English to Czech Translation!";
                imageURL: "qrc:/images/language_icon.png";
                updateTime: "1979-23-12 12:22:10";
            }
            ListElement {
                project_id: 1;
                title: "Danish"
                isOpen: false;
                text: "this is english";
                summary: "English to Danish Translation!";
                imageURL: "qrc:/images/language_icon.png";
                updateTime: "1979-23-12 12:22:10";
            }
            ListElement {
                project_id: 1;
                title: "Dutch"
                isOpen: false;
                text: "this is english";
                summary: "English to Dutch Translation!";
                imageURL: "qrc:/images/language_icon.png";
                updateTime: "1979-23-12 12:22:10";
            }
            ListElement {
                project_id: 1;
                title: "Spanish"
                isOpen: false;
                text: "this is english";
                summary: "English to Spanish Translation!";
                imageURL: "qrc:/images/language_icon.png";
                updateTime: "1979-23-12 12:22:10";
            }
            ListElement {
                project_id: 1;
                title: "French"
                isOpen: false;
                text: "this is english";
                summary: "English to French Translation!";
                imageURL: "qrc:/images/language_icon.png";
                updateTime: "1979-23-12 12:22:10";
            }
            ListElement {
                project_id: 1;
                title: "Greek"
                isOpen: false;
                text: "this is english";
                summary: "English to Greek Translation!";
                imageURL: "qrc:/images/language_icon.png";
                updateTime: "1979-23-12 12:22:10";
            }
        }

        ScrollBar.vertical: ScrollBar {
            id: scrollBar
            opacity: 0.3;
            width: 5;
        }
    }
}
