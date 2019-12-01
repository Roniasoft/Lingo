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
        listView.currentIndex = 0;
        listView.focus = true;
    }

    Item {
        id: header;
        anchors.top: parent.top;
        anchors.topMargin: 15 * scaleFactor;
        anchors.left: listViewRect.left;
        anchors.right: listViewRect.right;
        height: 30 * scaleFactor;
        HeaderButton {
            id: nameRectHeader;
            width: 0.27 * parent.width;
            height: parent.height;
            anchors.left: parent.left;
            sortIsActive: sortingColumn === 0 ? true : false;
            sortEnabled: true;
            title: "Name";
            onHeaderClicked: {
                listView.currentIndex = 0;
                if (sortingColumn === 0) {
                    nameRectHeader.isAscending = !nameRectHeader.isAscending;
                }
                sortingColumn = 0;
            }
        }
        HeaderButton {
            id: englishRectHeader;
            width: 0.28 * parent.width;
            height: parent.height;
            anchors.left: nameRectHeader.right;
            sortEnabled: false;
            title: "English";
            onHeaderClicked: {
                listView.currentIndex = 0;
                if (sortingColumn === 1) {
                    englishRectHeader.isAscending = !englishRectHeader.isAscending;
                }
                sortingColumn = 1;
            }
        }
        HeaderButton {
            id: translationRectHeader;
            width: 0.28 * parent.width;
            height: parent.height;
            anchors.left: englishRectHeader.right;
            sortEnabled: false;
            title: "Translation";
            onHeaderClicked: {
                listView.currentIndex = 0;
                if (sortingColumn === 2) {
                    translationRectHeader.isAscending = !translationRectHeader.isAscending;
                }
                sortingColumn = 2;
            }
        }
        HeaderButton {
            id: completedRectHeader;
            width: 0.17 * parent.width;
            height: parent.height;
            anchors.left: translationRectHeader.right;
            sortIsActive: sortingColumn === 3 ? true : false;
            sortEnabled: true;
            title: "Completed";
            
            onHeaderClicked: {
                listView.currentIndex = 0;
                if (sortingColumn === 3) {
                    completedRectHeader.isAscending = !completedRectHeader.isAscending;
                }
                sortingColumn = 3;
            }
        }
    }

    Component {
        id: ldelegate;
        ListItemDelegate {
            id: listItemDelegate;
            width: listViewRect.width
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
            StringSorter { roleName: "name"; sortOrder: nameRectHeader.isAscending ? 0 : 1; enabled: nameRectHeader.sortIsActive},
            StringSorter { roleName: "english"; sortOrder: englishRectHeader.isAscending ? 0 : 1; enabled: englishRectHeader.sortIsActive},
            StringSorter { roleName: "translation"; sortOrder: translationRectHeader.isAscending ? 0 : 1; enabled: translationRectHeader.sortIsActive},
            StringSorter { roleName: "completed"; sortOrder: completedRectHeader.isAscending ? 0 : 1; enabled: completedRectHeader.sortIsActive}
        ]
    }

    Rectangle {
        id: listViewRect;
        anchors.top: header.bottom;
        anchors.topMargin: 0;
        anchors.left: parent.left;
        anchors.leftMargin: 20;
        anchors.right: parent.right;
        anchors.rightMargin: 20;
        anchors.bottom: parent.bottom;
        anchors.bottomMargin: 5;
        color:  "#17212b";

        ListView {
            id: listView;
            anchors.fill: parent;
            keyNavigationEnabled: true;
            clip: true;

            ScrollBar.vertical: ScrollBar {
                    id: lvScrollbar;
                    opacity: 0.3;
                    width: 5;
                    policy: ScrollBar.AlwaysOn;
            }
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
            highlight: Rectangle
            {
                color:"#253646"
                width: parent.width;
            }
            delegate: ldelegate

            highlightFollowsCurrentItem: true;
            highlightMoveDuration: -1;
            highlightMoveVelocity: -1;
            highlightResizeDuration: 0;
        }
    }
}