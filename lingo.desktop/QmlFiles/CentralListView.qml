import QtQuick 2.9
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.5
import QtQuick.Controls.Material 2.1
import QtQuick.Controls.Styles 1.4
import SortFilterProxyModel 0.2

import NetViewModels 1.0

Rectangle {
    color: "#0e1621";
    property int lastOpened: -1;
    property var pModel;
    property alias sourceModel: sourceListModel;
    property alias proxyModel: proxyModel;
    property alias listView: listView;
    property int sortingColumn: 0;
    property bool col0_isAscending: true;
    property bool col1_isAscending: true;
    property bool col2_isAscending: true;
    property bool col3_isAscending: true;
    

    function openProject(indx) {
        proxyModel.set(indx, "isOpen", true);
    }
    function closeProject(indx) {
        proxyModel.set(indx, "isOpen", false);
    }

    function fillModel(projectViewModel) {
        pModel = projectViewModel;
        sourceModel.clear();
        var phrasesCount = projectViewModel.phrases.count;
        for (let i = 0; i < phrasesCount; i++) {
            var phrase = projectViewModel.getPhraseViewModel(i);
            sourceModel.insert(i, 
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

    Item {
        id: header;
        anchors.top: parent.top;
        anchors.topMargin: 15;
        anchors.left: listView.left;
        anchors.right: listView.right;
        // color: "#364451";
        height: 30;

            Rectangle {
                id: nameRectHeader;
                color: nameRectHeaderMA.containsMouse ? "#2B3741" : "#364451";
                width: 0.3 * parent.width;
                height: parent.height;
                anchors.left: parent.left;
                Text {
                    id: txtHeaderName
                    text: qsTr("Name");
                    color: "white";
                    font.pixelSize: fontSize - 2;
                    anchors.verticalCenter: parent.verticalCenter;
                    anchors.horizontalCenter: parent.horizontalCenter
                }
                MouseArea {
                    id: nameRectHeaderMA;
                    anchors.fill: parent;
                    hoverEnabled: true;
                    cursorShape: Qt.PointingHandCursor;
                    onClicked: {
                        listView.currentIndex = 0;
                        if (sortingColumn === 0) {
                            col0_isAscending = !col0_isAscending;
                        }
                        sortingColumn = 0;
                    }
                }
            }

            
            Rectangle {
                id: englishRectHeader;
                color: englishRectHeaderMA.containsMouse ? "#2B3741" : "#364451";
                width: 0.30 * parent.width;
                height: parent.height;
                anchors.left: nameRectHeader.right;
                Text {
                    id: txtHeaderEnglish
                    text: qsTr("English");
                    color: "white";
                    anchors.verticalCenter: parent.verticalCenter;
                    anchors.horizontalCenter: parent.horizontalCenter
                    font.pixelSize: fontSize - 2;
                }
                MouseArea {
                    id: englishRectHeaderMA;
                    anchors.fill: parent;
                    hoverEnabled: true;
                    cursorShape: Qt.PointingHandCursor;
                    onClicked: {
                        listView.currentIndex = 0;
                        if (sortingColumn === 1) {
                            col1_isAscending = !col1_isAscending;
                        }
                        sortingColumn = 1;
                    }
                }
            }
            
            Rectangle {
                id: translationRectHeader;
                color: translationRectHeaderMA.containsMouse ? "#2B3741" : "#364451";
                width: 0.30 * parent.width;
                height: parent.height;
                anchors.left: englishRectHeader.right;
                Text {
                    id: txtHeaderTranslation
                    text: qsTr("Translation");
                    color: "white";
                    anchors.verticalCenter: parent.verticalCenter;
                    anchors.horizontalCenter: parent.horizontalCenter
                    font.pixelSize: fontSize - 2;
                }
                MouseArea {
                    id: translationRectHeaderMA;
                    anchors.fill: parent;
                    hoverEnabled: true;
                    cursorShape: Qt.PointingHandCursor;
                    onClicked: {
                        listView.currentIndex = 0;
                        if (sortingColumn === 2) {
                            col2_isAscending = !col2_isAscending;
                        }
                        sortingColumn = 2;
                    }
                }
            }

        // adjusting the last column header is very difficult in the rowLayout.
        //  so we adjust it manualy
        
            Rectangle {
                id: completedRectHeader;
                color: completedRectHeaderMA.containsMouse ? "#2B3741" : "#364451";
                width: 0.1 * parent.width;
                height: parent.height;
                anchors.left: translationRectHeader.right;
                Text {
                    id: txtHeaderIsCompleted
                    text: qsTr("Completed");
                    color: "white";
                    anchors.verticalCenter: parent.verticalCenter;
                    anchors.horizontalCenter: parent.horizontalCenter
                    font.pixelSize: fontSize - 2;
                }
                MouseArea {
                    id: completedRectHeaderMA;
                    anchors.fill: parent;
                    hoverEnabled: true;
                    cursorShape: Qt.PointingHandCursor;
                    onClicked: {
                        listView.currentIndex = 0;
                        if (sortingColumn === 3) {
                            col3_isAscending = !col3_isAscending;
                        }
                        sortingColumn = 3;
                    }
                }
            }
    }


    Component {
        id: ldelegate;
        ListItemDelegate {
            id: listItemDelegate;
            width: listView.width
            height: isOpen ? 210 * scaleFactor : 36 * scaleFactor;

            onUpdateRequested: {
                netContext.updatePhrase(pModel.langKey, aName, aTranslation, aIsCompleted);
            }
        }
    }

    TListModel {
        id: sourceListModel;
    }

    QQmlSortFilterProxyModel {
        id: proxyModel;
        sourceModel: sourceListModel
        filters: RegExpFilter {
            roleName: "completed"
            pattern: "false";
            enabled: hideCompleteds
        }
        sorters: [
            StringSorter { roleName: "name"; sortOrder: col0_isAscending ? 0 : 1; enabled: sortingColumn === 0},
            StringSorter { roleName: "english"; sortOrder: col1_isAscending ? 0 : 1; enabled: sortingColumn === 1},
            StringSorter { roleName: "translation"; sortOrder: col2_isAscending ? 0 : 1; enabled: sortingColumn === 2},
            StringSorter { roleName: "completed"; sortOrder: col3_isAscending ? 0 : 1; enabled: sortingColumn === 3}
        ]
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
                id: lvScrollbar;
            opacity: 0.3;
            width: 5;
            }
        ScrollBar.horizontal: ScrollBar{}
//        snapMode: ListView.SnapToItem;
//        interactive: true;
//        highlightRangeMode: ListView.StrictlyEnforceRange;

        function tabIsPressedInTextEdit() {
            if (proxyModel.count <= listView.currentIndex+1) {
                return;
            }

            if (lastOpened != -1) {
                proxyModel.set(lastOpened, "isOpen", false);
                proxyModel.set(lastOpened, "highlighted", false);
            }
            proxyModel.set(listView.currentIndex, "isOpen", false);
            listView.currentIndex = listView.currentIndex + 1;
            proxyModel.set(listView.currentIndex, "isOpen", true);
            lastOpened = listView.currentIndex;
        }

        model: proxyModel
        delegate: ldelegate
    }
}