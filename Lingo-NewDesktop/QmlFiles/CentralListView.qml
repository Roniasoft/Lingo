import QtQuick 2.9
import QtQuick.Layouts 1.3
import QtQuick.Controls 2.5
import QtQuick.Controls.Material 2.1
import QtQuick.Controls.Styles 1.4

Rectangle {
    color: "#0e1621";
    signal openRequested(var projName, var projDetail, var index);
    signal closeRequested(var index);
    signal itemDeleted();

    function openProject(indx) {
        listModel.get(indx).isOpen = true;
    }
    function closeProject(indx) {
        listModel.get(indx).isOpen = false;
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
            }
            Text {
                id: txtHeaderEnglish
                text: qsTr("English");
                color: "white";
                Layout.preferredWidth: 70
            }
            Text {
                id: txtHeaderTranslation
                text: qsTr("Translation");
                color: "white";
                Layout.preferredWidth: 70;
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

        }
    }

    Component {
        id: delegate;
        ListItemDelegate {
            width: listView.width
            height: isOpen ? 210 : 36;
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
        focus: true
        snapMode: ListView.NoSnap;
        ScrollBar.vertical: ScrollBar{}
        ScrollBar.horizontal: ScrollBar{}
        interactive: true;

        model: listModel
        delegate: delegate
    }
}
