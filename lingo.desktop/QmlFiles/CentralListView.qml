import QtQuick 2.9
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.5
import QtQuick.Controls.Material 2.1
import QtQuick.Controls.Styles 1.4

import NetViewModels 1.0

Rectangle {
    color: "#0e1621";
    property int lastOpened: -1;
    property var pModel;
    property alias listModel: listModel;
    property alias listView: listView;
    function openProject(indx) {
        listModel.get(indx).isOpen = true;
    }
    function closeProject(indx) {
        listModel.get(indx).isOpen = false;
    }

    function fillModel(projectViewModel) {
        pModel = projectViewModel;
        listModel.clear();
        var phrasesCount = projectViewModel.phrases.count;
        for (let i = 0; i < phrasesCount; i++) {
            var phrase = projectViewModel.getPhraseViewModel(i);
            listModel.insert(i, 
            {
                "name": phrase.key,
                "isOpen": phrase.isOpen,
                "english": phrase.value,
                "translation": phrase.translation,
                "comment": phrase.description,
                "completed": phrase.isCompleted,
                "highlighted": phrase.highlighted
            });
        }
        
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

        MouseArea {
            anchors.fill: parent;
        }
    }


    Component {
        id: ldelegate;
        ListItemDelegate {
            id: listItemDelegate;
            width: listView.width
            height: isOpen ? 210 : 36;

            onUpdateRequested: {
                netContext.updatePhrase(pModel.langKey, aName, aTranslation, aIsCompleted);
            }
        }
    }

    TListModel {
        id: listModel;
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

        model: listModel
        delegate: ldelegate


    }
}